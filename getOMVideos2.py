import argparse
import numpy as np
import time
import scipy.io
import cv2
import pickle
import math
import matplotlib.pyplot as plt
from matplotlib import cm
import hdf5storage
import os

# Normalize and convert background to RGB
def to_rgb_from_gray(gray):
    norm = (gray - gray.min()) / (gray.max() - gray.min() + 1e-6)
    rgb = np.stack([norm] * 3, axis=-1)
    return (rgb * 255).astype(np.uint8)

# Apply blue-red colormap to a grayscale frame
def apply_colormap(gray):
    norm = (gray - gray.min()) / (gray.max() - gray.min() + 1e-6)
    colormap = plt.get_cmap('coolwarm')
    colored = colormap(norm)[..., :3]  # Drop alpha channel
    return (colored * 255).astype(np.uint8)

def main():

    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--videoPath', type=str, required=True)
    parser.add_argument('--roiPath', type=str, required=True)
    parser.add_argument('--outPath', type=str, required=True)
    parser.add_argument('--threshold', type=float, required=True, help='Value between 0 and 1 defining the baseline')
    parser.add_argument('--sampleStart', type=int, required=True, help='select this different to 0 to drop some values', default=-1)
    parser.add_argument('--sampleEnd', type=int, required=True, help='select this different to -1 to drop some values', default=-1)
    parser.add_argument('--sampleStartImages', type=int, default=-1)
    parser.add_argument('--sampleEndImages', type=int, default=-1)
    parser.add_argument('--fps',     type=int, default=100)
    args = parser.parse_args()

    try:
        video = scipy.io.loadmat(args.videoPath)
    except NotImplementedError:
        video = hdf5storage.loadmat(args.videoPath)
    video = video['wholav_images']
    if args.sampleStart!=-1 and args.sampleEnd!=-1:
        video = video[:,:,args.sampleStart:args.sampleEnd]

    try:
        img_back = scipy.io.loadmat(args.videoPath.replace('_filtered', ''))
    except NotImplementedError:
        img_back = hdf5storage.loadmat(args.videoPath.replace('_filtered', ''))
    img_back = img_back['A'][:,:,0]

    if '.pkl' in args.roiPath:
        with open(args.roiPath, 'rb') as f:
            roi = pickle.load(f)
    elif '.txt' in args.roiPath:
        roi = np.loadtxt(args.roiPath, delimiter=",", dtype=int)
    else:
        raise ValueError('Wrong roi file extension/type')

    # Normalize the video and clean with final ROI
    mins = np.min(video,axis=2)
    mins = np.repeat(mins[:,:,np.newaxis],video.shape[2], axis=2)
    maxs = np.max(video,axis=2)
    maxs = np.repeat(maxs[:,:,np.newaxis],video.shape[2], axis=2)

    video = np.divide(video-mins, maxs-mins, where=(maxs-mins)!=0)
    video = np.abs(video-1)
    video[video<args.threshold] = 0

    # Convert background to RGB
    background_rgb = to_rgb_from_gray(img_back)

    # Setup video writer
    N, _, num_frames = video.shape
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')
    out = cv2.VideoWriter(os.path.join(args.outPath,'video.mp4'), fourcc, args.fps, (N, N))

    # Process each frame
    roi_rgb = roi[:, :, np.newaxis] 
    samples_to_save_img = np.arange(args.sampleStartImages,args.sampleEndImages,10)
    plt.imsave(os.path.join(args.outPath, "background_img.png"), background_rgb, dpi=400)
    for i in range(num_frames):
        frame = video[:, :, i]
        color_frame = apply_colormap(frame)*roi_rgb.astype(np.uint8)

        # Blend with background (adjust alpha for visibility)
        # blended = cv2.addWeighted(background_rgb, 0.5, color_frame, 0.5, 0)

        # Apply white-outside-ROI,   this erases the background that is not in the ROI so not so good
        # white_frame = np.full_like(blended, 255)
        # blended_masked = np.where(roi_rgb, blended, white_frame)

        # Save images at specified intervals
        if i in samples_to_save_img:
            plt.imsave(os.path.join(args.outPath, "sample_{}.png".format(i)), color_frame, dpi=400)


        out.write(cv2.cvtColor(color_frame, cv2.COLOR_RGB2BGR))

    out.release()

if __name__ == '__main__':
    startTime = time.time()
    main()
    print("Total time was {0:.2f}".format(time.time()-startTime))