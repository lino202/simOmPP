import numpy as np
from scipy.spatial.distance import cdist
import matplotlib.pyplot as plt
from tqdm import tqdm
import copy
import numba as nb
import warnings
import os
from multiprocessing import Pool
# from scipy.spatial import KDTree


def getNeededNumberOfPoints(maxDist):
    halfWidth = np.ceil(maxDist).astype(int)
    y, x = np.meshgrid(np.arange(halfWidth*2+2), np.arange(halfWidth*2+2))
    xy = np.array([x.flatten(), y.flatten()]).transpose()
    middlePoint = np.array([halfWidth, halfWidth])
    dists = np.squeeze(cdist([middlePoint], xy))
    idxs = np.where((dists > 0)&(dists <= maxDist))[0]
    return idxs.shape[0]

#CV for images -----------------------------------------------------------------------------------
def getLocalCvVanilla(img, maxDist, maxCV, shouldNotHaveAllPoints):
    img = img.astype(float)
    nPoints = getNeededNumberOfPoints(maxDist)
    idxs = np.logical_not(np.isnan(img)).nonzero()
    y, x = np.meshgrid(np.arange(img.shape[0]), np.arange(img.shape[0]))
    xyuv = np.zeros((x.flatten().shape[0],4))
    xyuv[:,:2] = np.array([x.flatten(), y.flatten()]).transpose()
    idxs = np.ravel_multi_index(idxs, (img.shape))
    xyuv = xyuv[idxs,:]

    for i in tqdm(range(xyuv.shape[0])):
        thisPoint = xyuv[i,:2].astype(int)
        dists = np.squeeze(cdist([thisPoint], xyuv[:,:2]))
        idxs = np.where((dists > 0)&(dists <= maxDist))[0]
        if idxs.shape[0] == nPoints or shouldNotHaveAllPoints:
            influencePoints = xyuv[idxs,:2].astype(int)

            dirs = influencePoints - thisPoint  
            dirsVersors = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
            
            times = img[influencePoints[:,0], influencePoints[:,1]]
            times = times - img[thisPoint[0],thisPoint[1]]
            pixCVs = np.empty(idxs.shape)
            pixCVs[:] = np.nan
            np.divide(dists[idxs], times, out=pixCVs, where=times!=0.)
            #We clean in order to avoid huge CV values when taking into account the situation:
            # of two points in the same wavefroint 
            # And two points, one one wavefront and the other in a colliding wavefront
            idxs2Nan = np.where(np.abs(pixCVs)>maxCV)
            pixCVs[idxs2Nan] = np.nan
            
            if not np.isnan(pixCVs).all():
                #Velocity sign changes direction so pixCVs must not be absolute value
                pixCVvectors = dirsVersors * np.expand_dims(pixCVs, axis=1)
                resVector = np.nanmean(pixCVvectors, axis=0)  
                if np.linalg.norm(resVector) != 0.0:
                    # Here I not consider sources and sinks of velocities as I wanted to do consider 
                    # only the travelling of the vector field 
                    xyuv[i,-2:] = resVector
                else:
                    xyuv[i,-2:] = [np.nan, np.nan]
            else:
                xyuv[i,-2:] = [np.nan, np.nan]
        
        else:
            xyuv[i,-2:] = [np.nan, np.nan]


    #Set reference in bottom-left angle of the screen
    x_y_vx_vy = copy.deepcopy(xyuv)
    x_y_vx_vy[:,2] = xyuv[:,3]
    x_y_vx_vy[:,3] = -1*xyuv[:,2]
    return x_y_vx_vy


def getLocalCvBayly(img, maxDist, shouldNotHaveAllPoints):
    # Performs local estimation of CV using Bayly's method (doi: 10.1109/10.668746).
    # IN:
    # img - activation map from which a vector field is obtained.
    # maxDist - distance around a point that is considered when fitting the Bayly polynomial.
    # OUT:
    # xyuv - a n-by-4 matrix, where n is number of pixels and columns correspond
    # to x,y,u,v:  x,y gives indices of row and column, with u,v
    # corresponding to dx,dy.
    img = img.astype(float)
    nPoints = getNeededNumberOfPoints(maxDist)
    idxs = np.logical_not(np.isnan(img)).nonzero()
    y, x = np.meshgrid(np.arange(img.shape[0]), np.arange(img.shape[0]))
    xyuv = np.zeros((x.flatten().shape[0],4))
    xyuv[:,:2] = np.array([x.flatten(), y.flatten()]).transpose()
    idxs = np.ravel_multi_index(idxs, (img.shape))
    xyuv = xyuv[idxs,:]

    for iPoint in tqdm(range(xyuv.shape[0])):
        # for each point, find points nearby.
        thisPoint = xyuv[iPoint,:2].astype(int)
        dists = np.squeeze(cdist([thisPoint], xyuv[:,:2]))
        x = thisPoint[0]; y = thisPoint[1]
        idxs = np.where((dists > 0)&(dists <= maxDist))[0]

        if idxs.shape[0] == nPoints or shouldNotHaveAllPoints:
            locationsNeighbours = xyuv[idxs,:2].astype(int)
            xArr = locationsNeighbours[:,0]; yArr = locationsNeighbours[:,1]
            neighbourActivationTimes = img[xArr, yArr]
            
            if not np.isnan(neighbourActivationTimes).all():
                noNanATidxs = ~np.isnan(neighbourActivationTimes)
                noNanATs = neighbourActivationTimes[noNanATidxs]
                sf, cond = polyfit22(locationsNeighbours[noNanATidxs,0],locationsNeighbours[noNanATidxs,1], noNanATs)
                coeffs = sf[0]
                # Check fitting
                # SST =  np.sum((noNanATs - np.mean(noNanATs))**2)
                # SSE = sf[1]
                # R2  =  1 - (SSE/SST)                      
                # linearAprox = coeffs[1]*locationsNeighbours[noNanATidxs,0] + coeffs[2]*locationsNeighbours[noNanATidxs,1] + coeffs[0] 
                # SSE = np.sum((noNanATs - linearAprox)**2)
                # R2lin = 1 - (SSE/SST)

                dx = coeffs[1] + 2*coeffs[3]*x + coeffs[4]*y
                dy = coeffs[2] + 2*coeffs[5]*y + coeffs[4]*x
                if ((dx!=0 or dy!=0) ): #and (R2lin>0.05) and (R2 > 0.5)
                    xyuv[iPoint, :] = [x, y, dx/(dx*dx+dy*dy), dy/(dx*dx + dy*dy)]
                else:
                    xyuv[iPoint, :] = [x, y, np.nan, np.nan]
            else:
                xyuv[iPoint, :] = [x, y, np.nan, np.nan]
        else:
            xyuv[iPoint, :] = [x, y, np.nan, np.nan]
    #Set reference in bottom-left angle of the screen
    x_y_vx_vy = copy.deepcopy(xyuv)
    x_y_vx_vy[:,2] = xyuv[:,3]
    x_y_vx_vy[:,3] = -1*xyuv[:,2]
    return x_y_vx_vy


def polyfit22(x, y, z):
    coeffs = np.ones(6)
    a = np.zeros((coeffs.size, x.size))
    a[0] = (coeffs[0] * x**0 * y**0).ravel()
    a[1] = (coeffs[1] * x**1 * y**0).ravel()
    a[2] = (coeffs[2] * x**0 * y**1).ravel()
    a[3] = (coeffs[3] * x**2 * y**0).ravel()
    a[4] = (coeffs[4] * x**1 * y**1).ravel()
    a[5] = (coeffs[5] * x**0 * y**2).ravel()
    # do leastsq fitting and return leastsq result
    return np.linalg.lstsq(a.T, np.ravel(z), rcond=None), np.linalg.cond(a.T)

def polyfit22_3D(x, y, z, at):
    coeffs = np.ones(10)
    a = np.zeros((coeffs.size, x.size))
    a[0] = (coeffs[0] * x**2 * y**0 * z**0).ravel()   #a
    a[1] = (coeffs[1] * x**0 * y**2 * z**0).ravel()   #b
    a[2] = (coeffs[2] * x**0 * y**0 * z**2).ravel()   #c
    a[3] = (coeffs[3] * x**1 * y**1 * z**0).ravel()   #d
    a[4] = (coeffs[4] * x**1 * y**0 * z**1).ravel()   #e
    a[5] = (coeffs[5] * x**0 * y**1 * z**1).ravel()   #f
    a[6] = (coeffs[6] * x**1 * y**0 * z**0).ravel()   #g
    a[7] = (coeffs[7] * x**0 * y**1 * z**0).ravel()   #h
    a[8] = (coeffs[8] * x**0 * y**0 * z**1).ravel()   #i
    a[9] = (coeffs[9] * x**0 * y**0 * z**0).ravel()   #j
    # do leastsq fitting and return leastsq result
    return np.linalg.lstsq(a.T, np.ravel(at), rcond=None), np.linalg.cond(a.T)


#CV for meshes -----------------------------------------------------------------------------------
# The CV vanilla calculation for Meshes was optimized for speed, several approaches were tried:
# 1-First KDTree crashes as it is  memory bounded (at least in scipy)
# 2-Numba was not performing faster (cpu) I think as several used functions
# are already implemented in c/c++ in the background
# 3-A vectorized approach with CV calculation of nodes in batches was tried
# but rarely this took more time to be computed (I migth made an error/unoptimization). 
# Also, using the batch increases the risk of unleashing an out-of-memory error.
# 4-Finally we tried to compute with multiprocesses in parallel, which maked it faster
# Batch With    Pool 628.04 s
# Batch Without Pool 941.68 s
# Node  With    Pool 53.20 s
# Node  Without Pool 110.27 s
# As seen, the CV per node is faster than using batches and the utilization of multiprocesses
# reduced the computation time.


def initPoolGradVanillaMesh(_points, _ats, _maxDist, _gradType):
    global points, ats, maxDist, gradType
    # warnings.filterwarnings(action='ignore', message='Mean of empty slice')
    points  = _points
    ats     = _ats
    maxDist = _maxDist
    gradType = _gradType

def getLocalGradsVanillaMeshPerNodeCorePool(idx):
    thisPoint = points[idx,:]
    dists = np.squeeze(cdist([thisPoint], points))
    nodeConns = np.where((dists > 0)&(dists <= maxDist))[0] #nodes connected
    
    #Calculate mean magnitude and direction
    dists = np.transpose(dists[nodeConns])
    times = ats[nodeConns] - ats[idx]
    nodeGrads = np.empty(dists.shape); nodeGrads[:] = np.nan
    if gradType == "time":
        np.divide(dists, times, out=nodeGrads, where=times != 0.)
    elif gradType == "space":
        np.divide(times, dists, out=nodeGrads, where=dists != 0.)
    else: raise ValueError("Wrong gradType")
    
    if not np.isnan(nodeGrads).all(): 
        #Direction: All vectors go out from central node and times vector defines the final sign to be entering the node or going out from it
        dirs = points[nodeConns,:] - points[[idx],:]  
        dirsVersors = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
        cvVectors = dirsVersors * np.expand_dims(nodeGrads, axis=1)
        resVector = np.nanmean(cvVectors, axis=0)
        # if np.linalg.norm(resVector) != 0.0: 
        return resVector
        # else:
        #     #Here we assigned as Nans the sink and sources
        #     return [np.nan, np.nan, np.nan]
    else:
        return [np.nan, np.nan, np.nan]


def getLocalGradsVanillaMeshPerNodePool(points, ats, maxDist, maxMem, gradType):
    #This could be used for computing gradients over time or space
    #This function creates a pool of processes and defines the chunksize of its
    #argument "interable" based on the maxMemory parameter and leaves one cpu core free 
    totNodes     = points.shape[0]
    xyzuvw       = np.zeros((totNodes, 6))
    xyzuvw[:,:3] = points
    segments     = np.arange(totNodes).astype(int)
    nNodes       = int((maxMem * 1e9) / (totNodes * 4)) #maxMem in GB
    nProcesses   = os.cpu_count()-1
    print("Processes pool:\nCpu cores: {}\nIterable chucnksize: {}\n".format(nProcesses, nNodes))
    
    with Pool(nProcesses, initializer=initPoolGradVanillaMesh, initargs=(points,ats,maxDist, gradType)) as p:
        res = list(tqdm(p.imap(getLocalGradsVanillaMeshPerNodeCorePool, segments, nNodes), total=segments.shape[0]))
    xyzuvw[:,-3:] = np.array(res)
    return xyzuvw


def getLocalGradsVanillaMeshPerNode(points, ats, maxDist, gradType):
    #This could be used for computing gradients over time or space
    #All is referred as CV as this was made for CV initially
    #The Cv is computed locally per each node as the mean of the
    #mean CVs obtained from the AT distribution in its neighbour nodes
    #This is the simplest code and more memory efficient,
    #For speed see getLocalCvVanillaMeshPerNodePool
    #Here we assigned as Nans the sink and sources

    xyzuvw = np.zeros((points.shape[0], 6))
    xyzuvw[:,:3] = points
    for i in tqdm(range(points.shape[0])):
        #Get connections
        thisPoint = points[i,:]
        dists = np.squeeze(cdist([thisPoint], points))
        nodeConns = np.where((dists > 0)&(dists <= maxDist))[0] #nodes connected
        
        #Calculate mean magnitude and direction
        dists = np.transpose(dists[nodeConns])
        times = ats[nodeConns] - ats[i]
        nodeGrads = np.empty(dists.shape); nodeGrads[:] = np.nan
        if gradType == "time":
            np.divide(dists, times, out=nodeGrads, where=times != 0.)
        elif gradType == "space":
            np.divide(times, dists, out=nodeGrads, where=dists != 0.)
        else: raise ValueError("Wrong gradType")
        
        if not np.isnan(nodeGrads).all():
            #Direction: All vectors go out from central node and times vector defines the final sign to be entering the node or going out from it
            dirs = points[nodeConns,:] - points[[i],:]  
            dirsVersors = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
            cvVectors = dirsVersors * np.expand_dims(nodeGrads, axis=1)
            resVector = np.nanmean(cvVectors, axis=0)
            # if np.linalg.norm(resVector) != 0.0:
            xyzuvw[i,-3:] = resVector
            # else:
            #     #Here we assigned as Nans the sink and sources
            #     xyzuvw[i,-3:] = [np.nan, np.nan, np.nan]
        else:
            xyzuvw[i,-3:] = [np.nan, np.nan, np.nan]

    return xyzuvw


def getLocalCvBaylyMesh(points, ats, maxDist):
    #Bayly method is not working for 3D meshes, 2D ones can be treated as images
    xyzuvw = np.zeros((points.shape[0], 6))
    xyzuvw[:,:3] = points
    for i in tqdm(range(xyzuvw.shape[0])):
        #Get connections
        thisPoint = points[i,:]
        dists = np.squeeze(cdist([thisPoint], points))
        nodeConns = np.where((dists > 0)&(dists <= maxDist))[0] #nodes connected

        locationsNeighbours = xyzuvw[nodeConns,:3]
        neighbourActivationTimes = ats[nodeConns]
        x = thisPoint[0]; y = thisPoint[1]; z = thisPoint[2]
        if not np.isnan(neighbourActivationTimes).all():
            noNanATidxs = ~np.isnan(neighbourActivationTimes)
            noNanATs = neighbourActivationTimes[noNanATidxs]
            xArr = locationsNeighbours[noNanATidxs,0]
            yArr = locationsNeighbours[noNanATidxs,1]
            zArr = locationsNeighbours[noNanATidxs,2]
            sf, cond = polyfit22_3D(xArr,yArr, zArr, noNanATs)
            coeffs = sf[0]
            # Check fitting
            varAT =  np.sum((noNanATs - np.mean(noNanATs))**2) #sum((t-mean(t)).^2);
            aprox = coeffs[0]*(xArr**2) + coeffs[1]*(yArr**2) + coeffs[2]*(zArr**2) + coeffs[3]*xArr*yArr + coeffs[4]*xArr*zArr + coeffs[5]*yArr*zArr +coeffs[6]*xArr+coeffs[7]*yArr+coeffs[8]*zArr+coeffs[9]
            resi  =  np.sqrt(sf[1]/varAT)                      #sqrt(sum((t-fit*coefs).^2)/var_t);

            # fig = plt.figure()
            # ax = fig.gca(projection='3d')


            # # ax.plot(x, y, zs= 0, zdir = 'z', c= 'r')

            # # ax.scatter(xArr,yArr, zArr, c=noNanATs, s = 20)
            # ax.scatter(xArr,yArr, zArr, c=aprox, s = 20)
            # ax.scatter(x,y,z, c='r', s=50)
            # ax.set_xlabel('x')
            # ax.set_zlabel('z')
            # ax.set_ylabel('y')
            # plt.show()


            # linearAprox = coeffs[6]*xArr + coeffs[7]*yArr + coeffs[8]*zArr + coeffs[9] 
            # resilin = np.sqrt(np.sum((noNanATs-linearAprox)**2)/varAT) #sqrt(sum((t-fit(:,1:3)*coefs(1:3)).^2)/var_t);
            # a-0,b-1,c-2,d-3,e-4,f-5,g-6,h-7,i-8,j-9
            dx = 2*coeffs[0]*x + coeffs[3]*y + coeffs[4]*z + coeffs[6]
            dy = 2*coeffs[1]*y + coeffs[3]*x + coeffs[5]*z + coeffs[7]
            dz = 2*coeffs[2]*z + coeffs[4]*x + coeffs[5]*y + coeffs[8]
            # if (dx!=0 or dy!=0) and (resi <= 0.5 and resilin <= 0.95):
            if (dx!=0 or dy!=0 or dz!=0) and (resi<=0.5): #and (cond<1000)
                xyzuvw[i, -3:] = [dx/(dx*dx+dy*dy+dz*dz), dy/(dx*dx+dy*dy+dz*dz), dz/(dx*dx+dy*dy+dz*dz)]
            else:
                xyzuvw[i, -3:] = [np.nan, np.nan, np.nan]
        else:
            xyzuvw[i, -3:] = [np.nan, np.nan, np.nan]

    return xyzuvw


def twoPointsCV(coords, atmap):
    dist = cdist(coords[np.newaxis,0,:], coords[np.newaxis,1,:])
    at1 = atmap[tuple(np.roll(coords[0,:],1))]
    at2 = atmap[tuple(np.roll(coords[1,:],1))]
    cv = dist / (at2-at1)
    return cv