import argparse
import numpy as np
import time
import scipy.io
import cv2
import pickle
import math
import matplotlib.pyplot as plt
import os

def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--videoPath', type=str, required=True)
    parser.add_argument('--roiPath', type=str, required=True)
    parser.add_argument('--outPath', type=str, required=True)
    parser.add_argument('--fps',     type=int, default=100)
    args = parser.parse_args()

    video = scipy.io.loadmat(args.videoPath)
    video = video['wholav_images']

    img_back = scipy.io.loadmat(args.videoPath.replace('_filtered', ''))
    img_back = img_back['A'][:,:,0]
    img_back = (img_back-np.min(img_back))/(np.max(img_back)-np.min(img_back))

    with open(args.roiPath, 'rb') as f:
        roi = pickle.load(f)

    # Normalize the video and clean with final ROI
    mins = np.min(video,axis=2)
    mins = np.repeat(mins[:,:,np.newaxis],video.shape[2], axis=2)
    maxs = np.max(video,axis=2)
    maxs = np.repeat(maxs[:,:,np.newaxis],video.shape[2], axis=2)

    new_video = (video-mins)/(maxs-mins)
    new_video = np.abs(new_video-1)
    roi = np.repeat(roi[:,:,np.newaxis],video.shape[2], axis=2)

    new_video = new_video * roi
    new_video[np.isnan(new_video)] = 0
    new_video[new_video<0.65] = 0

    img_back = np.repeat(img_back[:,:,np.newaxis],video.shape[2], axis=2)

    # we make colored for habing the back image in gray and color fluorescence (COLOR_GRAY2BGR)
    new_video = np.repeat(new_video[:,:,:,np.newaxis],3, axis=3)  
    new_video[:,:,:,0] = 0
    new_video[:,:,:,2] = 0

    img_back = np.repeat(img_back[:,:,:,np.newaxis],3, axis=3)
    new_video = (new_video + img_back)/2
    new_video = (new_video * 255).astype(np.uint8)

    video=cv2.VideoWriter(os.path.join(args.outPath,'video.mp4'),cv2.VideoWriter_fourcc(*'mp4v'),fps=args.fps, frameSize=new_video[:,:,0,0].shape, isColor=True)

    for j in range(new_video.shape[2]):
        video.write(new_video[:,:,j,:])

    
    video.release()

    # samples_to_save_img = np.arange(3700,3810,10)
    # for i in samples_to_save_img:
    #     plt.figure()
    #     plt.imshow(new_video[:,:,i,:])
    #     plt.savefig(os.path.join(args.outPath, "sample_{}.png".format(i)), dpi=300)
    #     plt.close()

if __name__ == '__main__':
    startTime = time.time()
    main()
    print("Total time was {0:.2f}".format(time.time()-startTime))