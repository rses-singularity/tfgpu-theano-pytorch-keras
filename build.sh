#!/bin/bash

IMG_NAME="dl-python-gpu"

case "$1" in
  "-h")
    echo "By default builds a production image. Use -s to build a sandbox image and -r afterwards to convert to production image"
    ;;
  "-s")
    echo "Building $IMG_NAME.sbx sandbox"
    if [ -d "$IMG_NAME.sbx" ]; then
      sudo rm -rf "$IMG_NAME.sbx"
    fi
    sudo singularity build -s "$IMG_NAME.sbx" Singularity
    ;;
  "-r")
    
    if [ -d "$IMG_NAME.sbx" ]; then
      echo "Converting $IMG_NAME.sbx to $IMG_NAME.simg"
      sudo singularity build "$IMG_NAME.simg" "$IMG_NAME.sbx"
    else
      echo "Sandbox image does not exist"
    fi
    
    ;;
  *)
    echo "Building $IMG_NAME.simg"
    if [ -f "$IMG_NAME.simg" ]; then
      sudo rm -f $IMG_NAME.simg
    fi
    sudo singularity build $IMG_NAME.simg Singularity
    ;;
esac







