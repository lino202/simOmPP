import os
import argparse
import matplotlib.pyplot as plt
import numpy as np
from PIL import Image
from skimage import filters

parser = argparse.ArgumentParser(description="Options")
parser.add_argument('--filePath',type=str, required=True, help='path to data')
args = parser.parse_args()

folder   = "/".join(args.filePath.split("/")[:-1])
dataName = args.filePath.split("/")[-1].split(".")[0]
img      = np.array(Image.open(args.filePath))
imgPixs  = img.shape[0]
if img.shape[2] != 3: raise Warning("The image should have three channels")
img = img[:,:,0] #We assume a binary image with three channels being the same
img = (img - np.min(img)) / (np.max(img) - np.min(img)) #Normalized
img = img * 255

fig, ax = plt.subplots(1, 2)
ax[0].imshow(img)
ax[1].hist(img.ravel(), bins=256)

# fig, ax = filters.try_all_threshold(img, figsize=(10, 8), verbose=False)
# I have checked different threshold filters and better seems to be Li's
thresh = filters.threshold_li(img)
li = img > thresh
localthres = img > filters.threshold_local(img, 5, 'mean', offset=-5)

#Edge Filters
prewitt = filters.prewitt(img)
prewitt = (prewitt - np.min(prewitt)) / (np.max(prewitt) - np.min(prewitt))
prewitt = prewitt * 255
laplace = filters.laplace(img)
laplace = (laplace - np.min(laplace)) / (np.max(laplace) - np.min(laplace))
laplace = laplace * 255

prewittLocThres = prewitt * localthres
prewittLocThres = (prewittLocThres - np.min(prewittLocThres)) / (np.max(prewittLocThres) - np.min(prewittLocThres))
prewittLocThres = prewittLocThres * 255

laplaceLocThres = laplace * localthres
laplaceLocThres = (laplaceLocThres - np.min(laplaceLocThres)) / (np.max(laplaceLocThres) - np.min(laplaceLocThres))
laplaceLocThres = laplaceLocThres * 255

fig, ax = plt.subplots(2,3)
ax[0,0].imshow(localthres, cmap='gray')
ax[0,1].imshow(prewitt, cmap='gray')
ax[0,2].imshow(prewittLocThres, cmap='gray')
ax[1,0].imshow(localthres, cmap='gray')
ax[1,1].imshow(laplace, cmap='gray')
ax[1,2].imshow(laplaceLocThres, cmap='gray')
plt.show()

resFolder = os.path.join(folder, "res_images")
if not os.path.exists(resFolder):
    os.mkdir(resFolder)

Image.fromarray(img.astype(np.uint8)).save(os.path.join(resFolder, "{}_img.png".format(dataName)))
Image.fromarray(li).save(os.path.join(resFolder, "{}_li.png".format(dataName)))
Image.fromarray(localthres).save(os.path.join(resFolder, "{}_localThres.png".format(dataName)))
Image.fromarray(laplace.astype(np.uint8)).save(os.path.join(resFolder, "{}_laplace.png".format(dataName)))
Image.fromarray(prewitt.astype(np.uint8)).save(os.path.join(resFolder, "{}_prewitt.png".format(dataName)))
Image.fromarray(prewittLocThres.astype(np.uint8)).save(os.path.join(resFolder, "{}_prewittlocalThres.png".format(dataName)))
