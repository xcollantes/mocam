# MoCam64

![Raspberry Pi](https://img.shields.io/badge/-RaspberryPi-C51A4A?style=for-the-badge&logo=Raspberry-Pi)

Easy setup for motion detection camera on next generation 64-bit machines.  

Intended and tested for RaspberryPi 4+. MoCam64 is an implementation of [motion-project.github.io](https://motion-project.github.io) for capturing video and images when motion is detected and [Rclone](https://rclone.org) to quickly upload captures to a cloud provider of your choice. 

## Getting started 



### 1. Setup saving video and images to a cloud provider 

If you want to upload video and images captured, create an Rclone config which MoCam64 will be able to log into your cloud provider of choice.  

See list of 60+ cloud storage providers: https://rclone.org/#providers 

Some providers include: 

![Google Drive](https://img.shields.io/badge/Google%20Drive-4285F4?style=for-the-badge&logo=googledrive&logoColor=white)
![Mega.nz](https://img.shields.io/badge/Mega-%23D90007.svg?style=for-the-badge&logo=Mega&logoColor=white)
![OneDrive](https://img.shields.io/badge/OneDrive-0078D4.svg?style=for-the-badge&logo=microsoftonedrive&logoColor=white)
![Dropbox](https://img.shields.io/badge/Dropbox-%233B4D98.svg?style=for-the-badge&logo=Dropbox&logoColor=white)
![Google Cloud](https://img.shields.io/badge/GoogleCloud-%234285F4.svg?style=for-the-badge&logo=google-cloud&logoColor=white)
![AWS](https://img.shields.io/badge/AWS-%23FF9900.svg?style=for-the-badge&logo=amazon-aws&logoColor=white)
![Azure](https://img.shields.io/badge/azure-%230072C6.svg?style=for-the-badge&logo=microsoftazure&logoColor=white)


Create `rclone.conf`
1. Install Rclone locally 
1. Run `rclone config` 




### 2. (Optional) Build Docker image 

Skip to 3 for premade Docker image found at ``

### 3. Run Docker image 

Prerequisties 
- [ ] Connected camera to machine 
- [ ] Decided where to store videos and images (you have setup Rclone if you want to use cloud provider) 
- [ ] Either built a Docker image or about to use `` 

1. Get your camera device name by running `v4l2-ctl --list-devices` on your machine. 
1. Review `motion.conf`.  

   See [motion-project.github.io](https://motion-project.github.io/motion_config.html#configfiles) for full options. 

1. Build Docker image: `docker build -t mocam --build-arg=rclone_dest=[rclone_format] .`
   - `rclone_format` is the destination in Rclone format if using cloud provider 
   - Example: `docker build -t mocam --build-arg=rclone_dest=remote-mega:/mo_cam_dir mocam`

TODO: Premade docker image 

1. Run Docker image: `docker run -d mocam`
1. See machine logs at ``

### How it works 

MoCam64 depends on Motion to capture video and images when motion is detected and Rclone to quickly upload captures to a cloud provider. 




## Common pitfalls 

**How do I get my device name?**

Run `v4l2-ctl --list-devices` to see the devices attached to your machine. 
