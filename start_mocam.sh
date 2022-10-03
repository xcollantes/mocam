#!/bin/bash
# 
# Shell script to start sync of Mo Cam image and video outputs. 
# Author: collantes.xavier@gmail.com 

# & to run each script in the background as opposed 
# to running sequentially.  
echo "SAVE_SOURCE: $SAVE_SOURCE" 
echo "RCLONE_DEST: $RCLONE_DEST"
echo "RCLONE_CONFIG: $RCLONE_CONFIG"

#python3 /mocam/start_sync.py --rclone_dest $RCLONE_DEST &
/mocam/start_motion.sh &

wait -n

exit $?
