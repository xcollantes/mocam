#!/bin/bash
# 
# Shell script to start sync of Mo Cam image and video outputs. 
# Author: collantes.xavier@gmail.com 

# Location of video and images produced by Motion.
# By default, `/motion/`
SAVE_DIR=$1

# Location on remote cloud provider to save 
# videos and images. 
RCLONE_DEST=$2

echo "SAVE DIR: $SAVE_DIR"
echo "FILE SAVE LOCATION: $RCLONE_DEST"

mkdir -p $SAVE_DIR


while true; do
	rclone move $SAVE_DIR $RCLONE_DEST --progress --config=/mocam/rclone.conf
	sleep 5s
done
