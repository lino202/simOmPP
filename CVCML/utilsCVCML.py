import numpy as np
import matplotlib.pyplot as plt
import matplotlib.colors
from tqdm import tqdm
from scipy.spatial.distance import cdist

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

    Parameters
    ----------
    angle : float
        The angle in radians
    absolute : float
        The absolute value of the gradient
    
    Returns
    -------
    array_like
        The rgb value as a tuple with values [0..1]
    """
    # normalize angle
    if not np.isnan(angle):
        angle = angle % (2 * np.pi)
        if angle < 0:
            angle += 2 * np.pi

        return matplotlib.colors.hsv_to_rgb((angle / 2 / np.pi, absolute / max_abs, absolute / max_abs))
    else:
        return np.array([0,0,0])


def getLocalCV(activationMap, baylyNeighbourhood):
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