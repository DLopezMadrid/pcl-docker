# PCL-docker image
## Links
[GitHub repo](https://github.com/DLopezMadrid/pcl-docker)  
[Docker Hub image repo](https://hub.docker.com/repository/docker/dlopezmadrid/pcl-docker)


## Overview
This image is based on Ubuntu 18.04 and has the following packages installed:
- CUDA-10.2.89
- nvidia-docker
- CMake-3.10.2
- VTK-8.2.0
- PCL-1.11.0
- OpenCV-4.4.0
- Eigen
- Flann
- Boost
- gdb
- openssh
- Sublime Text
- zsh

Default user is `pcl` and password is `pcl` too.  
It starts an ssh server and exposes it in port 2222 of the host.

The idea is that the docker image will contain all the required software and libraries to develop on PCL and then we will connect from an IDE (CLion in my case) running in the host that will do "remote" compiling. It even allows to launch GUI applications from the container using `xhost`

You will need to have the nvidia GPU drivers and nvidia [CUDA drivers](https://linuxconfig.org/how-to-install-cuda-on-ubuntu-20-04-focal-fossa-linux) in your host to take full advantage of this image 

The image is based on [tkkhuu's one](https://github.com/tkkhuu/camera_lidar_calibration.git) with some additions to make CLion remote development work

## Clion configuration
Follow the steps [here](https://austinmorlan.com/posts/docker_clion_development/).  
Note: CMake will be installed on `/usr/local/bin/cmake` instead of on the default location


## Docker image
Clone [the repo](https://github.com/DLopezMadrid/pcl-docker) and go to its folder  
```
$ git clone https://github.com/DLopezMadrid/pcl-docker
$ cd pcl-docker
```
After that, you can either choose to build the image by yourself or pull it from docker hub

### Pull from docker-hub (Option A)
```
$ docker pull dlopezmadrid/pcl-docker:latest
```


### Build it for yourself (Option B)
Build the image with 
```
$ ./build_image.sh
```
### Using the image
Once the image is ready, you can create a container called pcl-docker with
```
$ ./setup_container.sh  
```
Once the container is created, there is no need to create it again unless it is deleted

Start the container with 
```
$ ./start_container.sh
```


## Build a PCL Project

Start the container with
```
$ ./start_container.sh
```
Then run these commands within the container
```
$ cd docker_dir/example_project/cloud_viewer
$ mkdir build && cd build
$ cmake ..
$ make
```
You can run the project then with
```
$ ./cloud_viewer
```
You may need to zoom out to see the example point clouds

## Other stuff

### Run a command from the container and detach it
- Run the command with &
- Press ctrl+z
- Run `bg`
- Run `disown`

### Check that the container is seeing the nvidia GPU
```
$ nvidia-smi
```

### Check that the host has nvidia & CUDA drivers installed
```
$ nvidia-smi
$ nvcc --version
```

### Solve the `bad x server connection` issue
`$DISPLAY` is not set properly in the container
In the host, run:
```
$ echo $DISPLAY
```
You should see something like `:0` or `:1`. Then inside the docker run with the right output from before:
```
$ export DISPLAY=:0
```
