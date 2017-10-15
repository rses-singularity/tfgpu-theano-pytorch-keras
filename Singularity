Bootstrap: docker
From: nvidia/cuda:8.0-cudnn6-devel-ubuntu16.04

%environment

	#Environment variables

	#Use bash as default shell
	SHELL=/bin/bash

	#Add nvidia driver paths
	PATH="/nvbin:$PATH"
	LD_LIBRARY_PATH="/nvlib;$LD_LIBRARY_PATH"

	#Add CUDA paths
	CPATH="/usr/local/cuda/include:$CPATH"
	PATH="/usr/local/cuda/bin:$PATH"
	LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
	CUDA_HOME="/usr/local/cuda"

	#Add Anaconda path
	PATH="/usr/local/anaconda3-4.2.0/bin:$PATH"
	CPATH="/usr/local/anaconda3-4.2.0/include/python3.5m:$CPATH"
	PYTHONPATH="/usr/local/lib/python3.5/site-packages:$PYTHONPATH"

	export PATH LD_LIBRARY_PATH CPATH CUDA_HOME PYTHONPATH


%setup
	#Runs on host
	#The path to the image is $SINGULARITY_ROOTFS



%post
	#Post setup script

	#Load environment variables
	. /environment

	#Default mount paths
	mkdir /scratch /data /shared /fastdata

	#Nvidia Library mount paths
	mkdir /nvlib /nvbin

	#Updating and getting required packages
	apt-get update
	apt-get install -y wget git vim cmake


	#Download and install Anaconda
	CONDA_INSTALL_PATH="/usr/local/anaconda3-4.2.0"
	wget https://repo.continuum.io/archive/Anaconda3-4.2.0-Linux-x86_64.sh
	chmod +x Anaconda3-4.2.0-Linux-x86_64.sh
	./Anaconda3-4.2.0-Linux-x86_64.sh -b -p $CONDA_INSTALL_PATH

	#Install updated libgcc so that libstdc++ version matches with Ubuntu's
	conda install -y libgcc

	#Getting some install errors if we don't make this directory
	mkdir -p /usr/local/anaconda3-4.2.0/var/lib/dbus

	#Gets and builds opencv
	apt-get install -y build-essential cmake pkg-config
	apt-get install -y libjpeg-dev libpng-dev libtiff-dev ffmpeg
	apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
	apt-get install -y libxvidcore-dev libx264-dev
	apt-get install -y libatlas-base-dev gfortran
	wget https://github.com/opencv/opencv/archive/3.3.0.tar.gz
	tar -xf 3.3.0.tar.gz
	cd opencv-3.3.0
	mkdir build
	cd build
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D PYTHON3_INCLUDE_DIR="/usr/local/anaconda3-4.2.0/include" \
	-D PYTHON3_LIBRARY="/usr/local/anaconda3-4.2.0/include/libpython3.5m.so" \
	..
	make -j8
	make install

	#Install Theano
	conda install -y scipy nose pydot-ng theano pygpu

	#Install Tensorflow
	TF_PYTHON_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp35-cp35m-linux_x86_64.whl"
	pip install --ignore-installed --upgrade $TF_PYTHON_URL

	#Install Keras
	pip install keras

	#Install Pytorch
	conda install -y pytorch torchvision cuda80 -c soumith



%runscript
	#Executes with the singularity run command
	#delete this section to use existing docker ENTRYPOINT command


%test
	#Test that script is a success
