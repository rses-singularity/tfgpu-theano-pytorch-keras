#!/bin/bash

IMG_SIZE=18000
IMG_NAME="dl-python-gpu"

rm -f $IMG_NAME.img
sudo singularity create --size $IMG_SIZE $IMG_NAME.img
sudo singularity bootstrap $IMG_NAME.img Singularity
