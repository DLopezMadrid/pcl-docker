# allow x server connection
XSOCK=/tmp/.X11-unix
XAUTH=/tmp/.docker.xauth
touch $XAUTH
xauth nlist $DISPLAY | sed -e 's/^..../ffff/' | xauth -f $XAUTH nmerge -
xhost +local:root
# to set up the right environment variables in CLion
echo "Set \$DISPLAY parameter to $DISPLAY" 

docker start pcl-docker
docker attach pcl-docker

# disallow x server connection
xhost -local:root
