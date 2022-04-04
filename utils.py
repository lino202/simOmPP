import numpy as np
from scipy.spatial.distance import cdist
import cv2
from scipy.ndimage import label, median_filter
import matplotlib.pyplot as plt

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
    if show:
        plt.figure()
        plt.imshow(labelArray, cmap='gray')
        plt.show(block=False)
    
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