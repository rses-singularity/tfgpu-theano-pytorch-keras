#!/bin/bash

IMG_NAME="dl-python-gpu"

rm -f $IMG_NAME.simg
sudo singularity build $IMG_NAME.simg Singularity
