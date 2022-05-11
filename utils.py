from dis import dis
import numpy as np
from scipy.spatial.distance import cdist
import cv2
from scipy.ndimage import label, median_filter
import matplotlib.pyplot as plt
import matplotlib.colors
from tqdm import tqdm

def isMemberIdxsRowWise(arr1, arr2, tol = 1E-6, showMem=False):
    if showMem: 
        print("Required Memory: {} GB".format(4 *(arr1.shape[0]) * (arr2.shape[0]) / 1e9))
    else:
        arr1 = np.reshape(arr1, (-1,3))
    idxs = np.min(cdist(arr2,arr1), axis=1) < tol
    return idxs.nonzero()[0]


def meanFilter(img, size=2):
    return median_filter(img, size)


def cleanMap(img, kernelSize=2):
    kernel = np.ones((kernelSize,kernelSize),np.uint8)
    median = median_filter(img, kernelSize+1)
    opening = cv2.morphologyEx(img, cv2.MORPH_OPEN, kernel)
    closing = cv2.morphologyEx(opening, cv2.MORPH_CLOSE, kernel)
    return closing


def keepBigIsland(img, show=False):

    labelArray, nFeatures = label(img)
    if show: plt.figure(); plt.imshow(labelArray, cmap='gray'); plt.show(block=False)
    elemsxLabel = np.zeros((nFeatures+1,1))
    for i in range(nFeatures):
        elemsxLabel[i+1] = len(labelArray[labelArray==i+1])
        
    maxElems = np.max(elemsxLabel)
    idxMax = np.argmax(elemsxLabel)
    secMax = np.max(elemsxLabel[elemsxLabel<maxElems])
    
    if secMax*10 < maxElems:
        labelArray[labelArray!=idxMax] = 0
        img[labelArray!=idxMax] = 0
        imgMin = img[labelArray==idxMax].min()
        imgMax = img[labelArray==idxMax].max()
        return labelArray, img, imgMin, imgMax
    else:
        raise ValueError('There is not only one huge cluster')

def calculateBoxPlotParams(data):
    median = np.median(data)
    upQuart = np.percentile(data, 75)
    lowQuart = np.percentile(data, 25)
    iqr = upQuart - lowQuart
    upWhisker = data[data<=upQuart+1.5*iqr].max()
    lowWhisker = data[data>=lowQuart-1.5*iqr].min()
    return median, lowQuart, upQuart, lowWhisker, upWhisker


def vector_to_rgb(angle, absolute, max_abs):
    """Get the rgb value for the given `angle` and the `absolute` value
    angle : float The angle in radians
    absolute : float The absolute value of the gradient
    array_like The rgb value as a tuple with values [0..1]"""
    if not np.isnan(angle):
        angle = angle % (2 * np.pi)
        if angle < 0:
            angle += 2 * np.pi
        return matplotlib.colors.hsv_to_rgb((angle / 2 / np.pi, absolute / max_abs, absolute / max_abs))
    else:
        return np.array([0,0,0])


def getLocalCvVanilla(img, maxDist):
    img = img.astype(float)
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
        influencePoints = xyuv[idxs,:2].astype(int)

        dirs = influencePoints - thisPoint  
        dirsVersors = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
        
        times = img[influencePoints[:,0], influencePoints[:,1]]
        times = times - img[thisPoint[0],thisPoint[1]]
        pixCVs = np.empty(idxs.shape)
        pixCVs[:] = np.nan
        np.divide(dists[idxs], times, out=pixCVs, where=times!=0.)
        
        if not np.isnan(pixCVs).all():
            #Velocity sign changes direction so pixCVs must not be absolute value
            pixCVvectors = dirsVersors * np.expand_dims(pixCVs, axis=1)
            resVector = np.nanmean(pixCVvectors, axis=0)  
            if np.linalg.norm(resVector) != 0.0:
                #Here I not consider sources and sinks of velocities as I wanted to do consider only the trevalling of 
                # the vector field 
                xyuv[i,-2:] = resVector
            else:
                xyuv[i,-2:] = [np.nan, np.nan]
        else:
            xyuv[i,-2:] = [np.nan, np.nan]

    return xyuv


def getLocalCvBayly(img, maxDist):
    # Performs local estimation of CV using Bayly's method (doi: 10.1109/10.668746).
    # IN:
    # img - activation map from which a vector field is obtained.
    # maxDist - distance around a point that is considered when fitting the Bayly polynomial.
    # OUT:
    # xyuv - a n-by-4 matrix, where n is number of pixels and columns correspond
    # to x,y,u,v:  x,y gives indices of row and column, with u,v
    # corresponding to dx,dy.
    img = img.astype(float)
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
        idxs = np.where((dists > 0)&(dists <= maxDist))[0]
        locationsNeighbours = xyuv[idxs,:2].astype(int)
        xArr = locationsNeighbours[:,0]; yArr = locationsNeighbours[:,1]
        x = thisPoint[0]; y = thisPoint[1]
        neighbourActivationTimes = img[xArr, yArr]
        
        if not np.isnan(neighbourActivationTimes).all():
            noNanATidxs = ~np.isnan(neighbourActivationTimes)
            noNanATs = neighbourActivationTimes[noNanATidxs]
            sf, cond = polyfit22(locationsNeighbours[noNanATidxs,0],locationsNeighbours[noNanATidxs,1], noNanATs)
            coeffs = sf[0]
            # Check fitting
            SST =  np.sum((noNanATs - np.mean(noNanATs))**2)
            SSE = sf[1]
            R2  =  1 - (SSE/SST)                      
            linearAprox = coeffs[1]*locationsNeighbours[noNanATidxs,0] + coeffs[2]*locationsNeighbours[noNanATidxs,1] + coeffs[0] 
            SSE = np.sum((noNanATs - linearAprox)**2)
            R2lin = 1 - (SSE/SST)

            dx = coeffs[1] + 2*coeffs[3]*x + coeffs[4]*y
            dy = coeffs[2] + 2*coeffs[5]*y + coeffs[4]*x
            if ((dx!=0 or dy!=0) and (R2 > 0.5)): #and (R2lin>0.05)
                xyuv[iPoint, :] = [x, y, dx/(dx*dx+dy*dy), dy/(dx*dx + dy*dy)]
            else:
                xyuv[iPoint, :] = [x, y, np.nan, np.nan]
        else:
            xyuv[iPoint, :] = [x, y, np.nan, np.nan]

    return xyuv


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

def plotHistAndBoxPlot(array, title, path=None):
    fig, axs = plt.subplots(1,2)
    plt.subplots_adjust(wspace=0.4)
    axs[0].hist(array)
    axs[1].boxplot(array)
    axs[0].set_ylabel("Frequencies")
    axs[0].set_xlabel(title)
    axs[1].set_xlabel("Samples")
    axs[1].set_ylabel(title)
    if path:
        plt.savefig(path)
    else:
        plt.show(block=True)

def getLocalCvVanillaMesh(points, ats, maxDist):

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
        nodeCVs = np.empty(dists.shape); nodeCVs[:] = np.nan
        np.divide(dists, times, out=nodeCVs, where=times != 0.)
        
        if not np.isnan(nodeCVs).all():
            #Direction: All vectors go out from central node and times vector defines the final sign to be entering the node or going out from it
            dirs = points[nodeConns,:] - points[[i],:]  
            dirsVersors = dirs / np.expand_dims(np.linalg.norm(dirs,axis=1), axis=1)
            cvVectors = dirsVersors * np.expand_dims(nodeCVs, axis=1)
            resVector = np.nanmean(cvVectors, axis=0)
            if np.linalg.norm(resVector) != 0.0:
                xyzuvw[i,-3:] = resVector
            else:
                xyzuvw[i,-3:] = [np.nan, np.nan, np.nan]
        else:
            xyzuvw[i,-3:] = [np.nan, np.nan, np.nan]

    return xyzuvw



def getLocalCvBaylyMesh(points, ats, maxDist):

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