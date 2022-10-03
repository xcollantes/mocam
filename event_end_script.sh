#!/bin/bash
# 
# Script to run automatically after each "event". 
# 
# The full path and file name of the program/script 
# to be executed when a event ends. An event ends after 
# the event_gap has expired.
# 
# You can use Conversion Specifiers and spaces as part of 
# the command. This can be any type of program or script. 
# Remember to set the execution bit in the ACL and if 
# it is a script type program such as perl or bash also 
# Remember the shebang line (e.g. #!/user/bin/perl) as the first line of the script.
# 
# Set env variables in Dockerfile and refer to them here.  
# Example: 
#bash /mocam/test_script.sh param1 param2 $RCLONE_DEST
rclone move $SAVE_SOURCE $RCLONE_DEST --progress --config=$RCLONE_CONFIG
