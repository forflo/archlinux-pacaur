#!/usr/bin/env bash

dockerTag=archlinux-pacaur
dockerName=archlinux-pacaur

sudo docker stop $dockerName
sudo docker rm $dockerName

sudo docker run \
	--name $dockerName -t -d \
	-v $PWD:/mnt \
	$dockerTag


# remarks:
# --------
