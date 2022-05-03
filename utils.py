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


def getLocalCvBayly(activationMap, baylyNeighbourhood):
    # Performs local estimation of CV using Bayly's method (doi: 10.1109/10.668746).
    # IN:
    # activationMap - activation map from which a vector field is obtained.
    # baylyNeighbourhood - distance around a point that is considered when fitting the Bayly polynomial.
    # OUT:
    # xyuv - a n-by-4 matrix, where n is number of pixels and columns correspond
    # to x,y,u,v:  x,y gives indices of row and column, with u,v
    # corresponding to dx,dy. Mind that this is in row/column
    # coordinates - if plotting via quiver (in standard x-y
    # coordinates), this needs to be altered slightly, see the code
    # at the end of the function.
    ## Bayly CV estimation
    nRows = np.shape(activationMap)[0]
    nCols = np.shape(activationMap)[1]
    Z = np.zeros((nRows*nCols, 2)).astype(int)
    count = 0
    for i in range(0, nRows):
        for j in range(0, nCols):
            Z[count, 0] = j+1
            Z[count, 1] = i+1
            count = count + 1
    activationTimes = activationMap.reshape((nRows*nCols), order='F')
    xyuv = np.zeros((len(Z),4))

    for iPoint in tqdm(range(0, len(Z))):
        # for each point, find points nearby.
        thisPoint = Z[iPoint,:]
        distances = cdist([thisPoint], Z)
        whereNeighbours = np.where((distances>=0)&(distances <=baylyNeighbourhood))[1]
        locationsNeighbours = Z[whereNeighbours,:]
        neighbourActivationTimes = activationTimes[whereNeighbours]
        x = np.arange(min(locationsNeighbours[:,0]), max(locationsNeighbours[:,0])+1)
        y = np.arange(min(locationsNeighbours[:,1]), max(locationsNeighbours[:,1])+1)
        x = thisPoint[0]
        y = thisPoint[1]
        if not np.isnan(neighbourActivationTimes).all():
            noNanATidxs = ~np.isnan(neighbourActivationTimes)
            sf = polyfit22(locationsNeighbours[noNanATidxs,0],locationsNeighbours[noNanATidxs,1],neighbourActivationTimes[noNanATidxs])
            coeffs = sf[0]
            dx = coeffs[1] + 2*coeffs[3]*x + coeffs[4]*y
            dy = coeffs[2] + 2*coeffs[5]*y + coeffs[4]*x
            if dx!=0 or dy!=0:
                xyuv[iPoint, :] = [x, y, dx/(dx*dx+dy*dy), dy/(dx*dx + dy*dy)]
            else:
                xyuv[iPoint, :] = [x, y, np.nan, np.nan]
        else:
            xyuv[iPoint, :] = [x, y, np.nan, np.nan]

    xyuv[:,:2] = xyuv[:,:2] - 1
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
    return np.linalg.lstsq(a.T, np.ravel(z), rcond=None)

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