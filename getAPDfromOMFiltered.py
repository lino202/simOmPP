import os
import argparse
import scipy.io
import matplotlib.pyplot as plt
import matplotlib.animation as animation
import numpy as np
from roipoly import RoiPoly
from utils import plotHistAndBoxPlotSeaBorn

font = {'family' : "Times New Roman",
        'weight' : 'normal',
        'size'   : 15}

plt.rc('font', **font)
parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
parser.add_argument('--startFrame',type=int, required=True)
parser.add_argument('--endFrame',type=int, required=True)
parser.add_argument('--reverse',action='store_true')
parser.add_argument('--apdtype',type=int, required=True)
parser.add_argument('--fps',type=int, required=True)
parser.add_argument('--outPath', type=str, required=True)
args = parser.parse_args()

video = scipy.io.loadmat(args.filePath)['wholav_images']
plt.figure()
plt.plot(np.arange(0,video.shape[2]),video[int(video.shape[0]/2),int(video.shape[1]/2),:])
plt.show()

#Cropping time--------------------------------------------------------------------
video = video[:,:,args.startFrame:args.endFrame]
minV = np.min(video)
maxV = np.max(video)
videoNorm = (video - minV) / (maxV - minV)
if args.reverse:
    videoNorm = np.abs(videoNorm - 1) 
plt.figure()
plt.plot(np.arange(0,videoNorm.shape[2]),videoNorm[int(videoNorm.shape[0]/2),int(videoNorm.shape[1]/2),:])
plt.show()

#Cropping Space--------------------------------------------------------------------
img0 = videoNorm[:,:,0]
plt.figure(); plt.imshow(img0)
my_roi = RoiPoly(color='r') # draw new ROI in red color
try:
    mask = my_roi.get_mask(img0)
except IndexError:
    pass
v = np.zeros(videoNorm.shape)
for i in range(video.shape[2]):
    v[:,:,i] = videoNorm[:,:,i] * mask.astype(int)
plt.figure()
plt.imshow(v[:,:,0])
plt.show()

#Compute APD--------------------------------------------------------------------
diff = np.diff(v, axis=2)
upstrokeIdxs = np.argmax(diff, axis=2)

peakIdxs = np.argmax(v, axis=2)
peaks    = np.max(v, axis=2)
baselinelvls = np.zeros((v.shape[0],v.shape[1]))
for i in range(v.shape[0]):
    for j in range(v.shape[1]):
        baselinelvls[i,j] = np.min(v[i,j,peakIdxs[i,j]:])

Voi = baselinelvls + (1 - (args.apdtype/100)) * (peaks - baselinelvls)
tin = np.ones((v.shape[0],v.shape[1])) * np.nan
for i in range(v.shape[0]):
    for j in range(v.shape[1]):
        try:
            tin[i,j] = (v[i,j,peakIdxs[i,j]:]<Voi[i,j]).nonzero()[0][0] 
        except IndexError:
            pass
tin = tin + peakIdxs
# APD = np.ones(v.shape[0]) * np.nan
# if (tin[~np.isnan(tin)] >= upstrokeIdxs[~np.isnan(tin)]).all():
#     APD[~np.isnan(tin)] = tin[~np.isnan(tin)] - upstrokeIdxs[~np.isnan(tin)] 
# else: 
#     raise ValueError("Max derivate time greater than x repolarization")
    
apd = tin - upstrokeIdxs
apd[apd<0] = np.nan
apd = apd / args.fps * 1000 #make ms

plt.figure()
plt.imshow(apd)
plt.show()


plotHistAndBoxPlotSeaBorn(apd[~np.isnan(apd)], "APD{} [ms]".format(args.apdtype), path=args.outPath)


