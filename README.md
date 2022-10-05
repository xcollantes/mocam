# MoCam

Easy setup for motion detection camera compatible with next generation 64-bit machines.  

MoCam is an implementation of [motion-project.github.io](https://motion-project.github.io) for capturing video and images when motion is detected and [Rclone](https://rclone.org) to quickly upload captures to a cloud provider of your choice. 

## Getting started 

### 1. Clone this repo onto the machine with camera connected 

```shell
git clone https://github.com/xcollantes/mocam.git
```

### 2. Setup saving video and images to a cloud provider 

Create an `rclone.conf` file to be able to upload captured media to a cloud provider of your choice.  See list of 60+ cloud storage providers: https://rclone.org/#providers 

Some providers include: 

![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)
![Mega.nz](https://img.shields.io/badge/Mega-%23D90007.svg?style=for-the-badge&logo=Mega&logoColor=white)
![OneDrive](https://img.shields.io/badge/OneDrive-0078D4.svg?style=for-the-badge&logo=microsoftonedrive&logoColor=white)
![Dropbox](https://img.shields.io/badge/Dropbox-%233B4D98.svg?style=for-the-badge&logo=Dropbox&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)

1. Install Rclone locally: `sudo -v ; curl https://rclone.org/install.sh | sudo bash` 
1. Run `rclone config` and follow the prompt to generate an `rclone.conf`
1. Generated config can be found in `~/.config/rclone/rclone.conf`.  Copy or move file to `mocam/` repo directory like so: `mocam/rclone.conf`. 

(https://rclone.org/install) 

### 3. Build Docker image 

1. Review `motion.conf`.  The default settings are calibrated for a USB camera on a RPI4.  

   See [motion-project.github.io](https://motion-project.github.io/motion_config.html#configfiles) for full options. 

1. Build Docker image: 

```shell
docker build -t mocam . 
```

### 4. Run Docker image 

Make sure you have the following: 
1. Connect camera to machine 
1. Get your camera device name by running `v4l2-ctl --list-devices` on your machine. 
1. Run command: 

```shell
docker run --rm --device=MY_DEVICE_NAME --env RCLONE_DEST=MY_RCLONE_PROFILE:/MY_DIR MY_IMAGE_NAME
```

- `--rm` Remove the container if stopped. 
- `--device` Docker flag to let container use the host machine's camera. 
- `MY_DEVICE_NAME`
- `--env` Set ENV variables.  
- `RCLONE_DEST` Rclone destination location with format as `MY_RCLONE_PROFILE:/MY_DIR`. 
- `MY_RCLONE_PROFILE` Rclone profile name as founc in the `rclone.conf` file created. 
- `MY_DIR` Folder in the cloud provider you setup.  This can be a path with nested folders.   
- `MY_IMAGE_NAME` Docker image name set in Docker build step.  

Example: 

```shell
docker run --rm --device=/dev/video0 --env RCLONE_DEST=remote-mega:/mo_cam mocam
```

1. See machine logs at `/motion/log/motion.log` if enabled in the `motion.conf`.  You will also see the logs from the container by using `docker logs CONTAINER_HASH`  

### How it works 

MoCam depends on Motion to capture video and images when motion is detected and Rclone to quickly upload captures to a cloud provider. 

## Common pitfalls 

**How do I get my device name?**

Run `v4l2-ctl --list-devices` to see the devices attached to your machine. 

**Processor compatibility: arm64**

Since this was tested on RPI4 which is uses arm64 processor, by default the Docker base image is `python:bullseye` which works with arm64 processor.  

Previously, [`raspberrypi4-64-debian`](https://hub.docker.com/r/balenalib/raspberrypi4-64-debian) was used as the base image which worked with no issue.  

Choose a base image which matches the processor of the machine.  

![Raspberry Pi](https://img.shields.io/badge/-RaspberryPi-C51A4A?style=for-the-badge&logo=Raspberry-Pi)

## motion.conf calibration 

Depending on the camera's environment, the camera, the procesing power of the machine, and the network the camera is on, the Motion config might need to be adjusted.  The settings and their values are most explained at https://motion-project.github.io/motion_config.html.  

Below are the calibration notes I took for my setup: 

My goals in order of priority: 
1. capture accuracy (does the camera capture the subject fully?) 
2. image quality (is the subject's face visible?) 
3. network conservation (can the videos upload to the cloud in under 2 seconds?) 

- `framrate` setting is MAX and seems to fluctuate 
- I'm using `event_gap` of 1 for testing so upload occurs right away 
