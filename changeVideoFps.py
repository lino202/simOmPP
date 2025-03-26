import argparse
import numpy as np
import cv2

def main():

    np.seterr(divide='raise', invalid='raise')
    parser = argparse.ArgumentParser(description="Options")
    parser.add_argument('--videoPath',  type=str, required=True, help='path to data')
    parser.add_argument('--videoOutPath',type=str, required=True, help='path to data')
    parser.add_argument('--fps',type=float, required=True, help='the desired fps')
    args = parser.parse_args()

    # Open the input video
    cap = cv2.VideoCapture(args.videoPath)
    
    # Get the original video's width, height, and codec
    width = int(cap.get(cv2.CAP_PROP_FRAME_WIDTH))
    height = int(cap.get(cv2.CAP_PROP_FRAME_HEIGHT))
    fourcc = cv2.VideoWriter_fourcc(*'mp4v')  # Codec for MP4 output
    
    # Create a VideoWriter object
    out = cv2.VideoWriter(args.videoOutPath, fourcc, args.fps, (width, height))
    
    while True:
        ret, frame = cap.read()
        if not ret:
            break
        out.write(frame)
    
    cap.release()
    out.release()

if __name__ == '__main__':
    main()