#!/bin/bash
# 
# Shell script to start sync of Mo Cam image and video outputs. 
# Author: collantes.xavier@gmail.com 


# Location on remote cloud provider to save 
# videos and images. 
RCLONE_DEST=$1

# & to run each script in the background as opposed 
# to running sequentially.  
/mocam/start_sync.sh /motion/ $RCLONE_DEST &
/mocam/start_motion.sh &

wait -n

exit $?
