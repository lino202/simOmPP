import numpy as np
from scipy.spatial.distance import cdist
from scipy.ndimage import label, median_filter
import matplotlib.pyplot as plt
import matplotlib.colors
from matplotlib.ticker import FormatStrFormatter
import seaborn as sns
from tqdm import tqdm
import os
import pandas as pd

def calcATFromEnsBinary(nodeStart, nodeEnd, timeStart, timeEnd, dt, resPath, nDigits, soluName, method="zero-cross"): 
    fileNumbers = np.arange(timeStart/dt, timeEnd/dt + 1 ).astype(int)
    v = np.zeros((nodeEnd - nodeStart, fileNumbers.shape[0]), dtype=np.float32) #Electra precision is single (32 bits)
    for i, fileNumber in tqdm(enumerate(fileNumbers)):
        fileName = os.path.join(resPath, '{}{}.ens'.format(soluName, str(fileNumber).zfill(nDigits)))
        with open(fileName, 'rb') as f:
            b = f.read()

        # See ensight variable file format 244 bytes before the first v value, and little endian
        # Electra save states in float32, offset is in bytes but count is items not bytes
        # https://docs.python.org/3/library/struct.html#format-characters
        v[:, i] = np.frombuffer(b, dtype='<f', offset=244+nodeStart*4, count=nodeEnd-nodeStart) 
    ats = calcATFromV(v, dt, method=method)
    return ats

def calcATFromEns(nodeStart, nodeEnd, timeStart, timeEnd, dt, resPath, nDigits, soluName, method="zero-cross"):
    v = np.zeros((nodeEnd - nodeStart, timeEnd - timeStart))
    for i in tqdm(range(timeStart, timeEnd)):
        fileName = os.path.join(resPath, '{}{}.ens'.format(soluName, str(i).zfill(nDigits)))
        df = pd.read_csv(fileName, usecols=[0], skiprows=3, dtype=np.float64)
        v[:, i-timeStart] = df["coordinates"][nodeStart:nodeEnd].to_numpy()

    ats = calcATFromV(v, dt, method=method)
    return ats

def calcATFromV(v, dt, method="zero-cross"):
    ats = np.ones(v.shape[0], dtype=np.float32) * np.nan
    if method == "upstroke":
        diff = np.diff(v, axis=1)
        upstrokeIdxs = np.argmax(diff, axis=1)  # ats
        ats = upstrokeIdxs * dt 
    elif method == "zero-cross":
        for i in tqdm(range(v.shape[0])):
            try:
                ats[i] = np.where(np.diff(np.sign(v[i])))[0][0] * dt
            except IndexError: pass
    else: raise ValueError("Wrong method")
    return ats


def calcAPDXFromEns(nodeStart, nodeEnd, timeStart, timeEnd, dt, apdType, resPath, nDigits, soluName):
    v = np.zeros((nodeEnd - nodeStart, timeEnd - timeStart))
    for i in tqdm(range(timeStart, timeEnd)):
        fileName = os.path.join(resPath, '{}{}.ens'.format(soluName, str(i).zfill(nDigits)))
        df = pd.read_csv(fileName, usecols=[0], skiprows=3, dtype=np.float64)
        v[:, i-timeStart] = df["coordinates"][nodeStart:nodeEnd].to_numpy()

    # Plot some curves
    # fig, ax = plt.subplots()
    # for i in range(10):
    #     plotIdx = random.randint(0,v.shape[0])
    #     ax.plot(v[plotIdx,:], label=plotIdx)
    # ax.legend()
    # ax.set_title("10 Vm signals")
    # plt.show()

    apds = calcAPDXFromV(v, dt, apdType)
    return apds

def calcAPDXFromEnsBinary(nodeStart, nodeEnd, timeStart, timeEnd, dt, apdType, resPath, nDigits, soluName):
    fileNumbers = np.arange(timeStart/dt, timeEnd/dt + 1 ).astype(int)
    v = np.zeros((nodeEnd - nodeStart, fileNumbers.shape[0]), dtype=np.float32) #Electra precision is single (32 bits)
    for i, fileNumber in tqdm(enumerate(fileNumbers)):
        fileName = os.path.join(resPath, '{}{}.ens'.format(soluName, str(fileNumber).zfill(nDigits)))
        with open(fileName, 'rb') as f:
            b = f.read()

        # See ensight variable file format 244 bytes before the first v value, and little endian
        # Electra save states in float32, offset is in bytes but count is items not bytes
        # https://docs.python.org/3/library/struct.html#format-characters
        v[:, i] = np.frombuffer(b, dtype='<f', offset=244+nodeStart*4, count=nodeEnd-nodeStart) 

    # Plot some curves
    # fig, ax = plt.subplots()
    # for i in range(10):
    #     plotIdx = random.randint(0,v.shape[0])
    #     ax.plot(v[plotIdx,:], label=plotIdx)
    # ax.legend()
    # ax.set_title("10 Vm signals")
    # plt.show()

    apds = calcAPDXFromV(v, dt, apdType)
    return apds

def calcAPDXFromV(v, dt, apdType):
    upstrokeIdxs = np.argmax(np.diff(v, axis=1), axis=1)
    peakIdxs = np.argmax(v, axis=1)
    peaks    = np.max(v, axis=1)
    baselinelvls = np.array([np.min(v[i,peakIdxs[i]:]) for i in range(v.shape[0])])

    Voi = baselinelvls + (1 - (apdType/100)) * (peaks - baselinelvls)
    tin = np.ones(v.shape[0]) * np.nan
    for i in tqdm(range(v.shape[0])):
        try:
            tin[i] = (v[i,peakIdxs[i]:]<Voi[i]).nonzero()[0][0] 
        except IndexError:
            pass

    tin = tin + peakIdxs 
    apds = tin - upstrokeIdxs
    apds[apds<0] = np.nan
    apds = apds * dt
    return apds

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
    import cv2
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


def plotHistAndBoxPlot(array, title, path=None):
    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}
    plt.rc('font', **font)
    
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


def plotHistAndBoxPlotSeaBorn(array, arrayName, path=None):

    # if "AT" in arrayName:
    #     binsNum = 10
    # elif "CV" in arrayName:
    #     binsNum = 60
    # else:
    binsNum = "auto"

    sns.set(style="ticks")
    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 20}

    plt.rc('font', **font)
    plt.rcParams.update({'mathtext.default':  'regular' })
    f, (ax_box, ax_hist) = plt.subplots(2, sharex=True, gridspec_kw={"height_ratios": (.15, .85)})
    sns.boxplot(x=array, ax=ax_box)
    sns.histplot(x=array, ax=ax_hist, bins=binsNum, kde=True)
    ax_box.set(yticks=[])
    ax_hist.set_ylabel("Frequencies")
    ax_hist.set_xlabel(arrayName)
    ax_hist.ticklabel_format(useOffset=False)
    ax_hist.xaxis.set_major_formatter(FormatStrFormatter('%.1f'))
    sns.despine(ax=ax_hist)
    sns.despine(ax=ax_box, left=True)
    plt.savefig(path, dpi=500) if path else plt.show(block=True)
    plt.close()


def plotColorbar(mymap, label, outName):

    font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 20}

    plt.rc('font', **font)
    plt.rcParams.update({'mathtext.default':  'regular' })

    fig = plt.figure()
    ax = fig.add_subplot(111)
    plt.imshow(mymap, vmin=np.nanmin(mymap), vmax=np.nanmax(mymap), cmap='viridis')
    plt.axis('off')
    cbar = plt.colorbar(ax=[ax], ticks=np.linspace(np.nanmin(mymap),np.nanmax(mymap),4), location="right", pad=0.02, shrink=0.9)
    # cbar.ax.tick_params(labelsize=fontsize)
    cbar.ax.facecolor = 'r'
    cbar.set_label(label) #fontfamily=fontFamily, fontsize=fontsize
    cbar.ax.ticklabel_format(useOffset=False)
    cbar.ax.yaxis.set_major_formatter(FormatStrFormatter('%.1f'))
    plt.savefig(outName, dpi=500)
    plt.close()