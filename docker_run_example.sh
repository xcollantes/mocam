#!/bin/bash
#
# Sample of how to start MoCam64.
# 
# Author: collantes.xavier@gmail.com


# --device=/dev/video0:/dev/video0
# 
# Usually a USB camera is `/dev/video0`.
# You can find the machine's device with command: 
# `v4l2-ctl --list-devices`

# docker run -d \
#            --device=[camera_device_on_container]:[camera_device_on_host] \
#            --name [container_name] \
#            MOCAM64_IMAGE

docker run -d --device=/dev/video0:/dev/video0 --name my_mocam64 mocam64_image

# -p 6001:6001 -p 6002:6002
#
# Traditionally stream ports are available for Motion.
# These are not exposed for improved security in MoCam64
# since you can find the video and image outputs in the rclone
# destination.  
