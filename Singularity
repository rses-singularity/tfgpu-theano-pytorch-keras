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

	#Python 3.5 paths
	CPATH="/usr/include/python3.5m:$CPATH"
	PYTHONPATH="/usr/local/lib/python3.5/dist-packages:$PYTHONPATH"

	export PATH LD_LIBRARY_PATH CPATH CUDA_HOME PYTHONPATH


%setup
	#Runs on host
	#The path to the image is $SINGULARITY_ROOTFS

	mkdir $SINGULARITY_ROOTFS/build
	mount --no-mtab --bind . "$SINGULARITY_ROOTFS/build"


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
	apt-get install -y wget git vim cmake cmake-curses-gui python3.5-dev


	#Gets and builds opencv
	apt-get install -y build-essential cmake pkg-config libgtk-3-dev
	apt-get install -y libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev ffmpeg
	apt-get install -y libavcodec-dev libavformat-dev libswscale-dev libv4l-dev
	apt-get install -y libxvidcore-dev libx264-dev
	apt-get install -y libatlas-base-dev gfortran

	#Make python 3.5m the default one
	cd /usr/bin
	rm /usr/bin/python
	ln -s python3.5m python

	#Install pip for python 3
	cd /build
	wget https://bootstrap.pypa.io/get-pip.py
	python get-pip.py

	#Installed required global packages
	pip install numpy

	#Builds in the build directory
	cd /build

	wget https://github.com/opencv/opencv/archive/3.3.0.tar.gz
	tar -xf 3.3.0.tar.gz
	cd opencv-3.3.0
	mkdir build
	cd build
	cmake -D CMAKE_BUILD_TYPE=RELEASE \
	-D CMAKE_INSTALL_PREFIX=/usr/local \
	-D BUILD_opencv_python3=yes \
	-D PYTHON_DEFAULT_EXECUTABLE="/usr/bin/python3.5m" \
	-D CUDA_ARCH_BIN="3.0 3.5 3.7 5.0 5.2 6.0 6.1" \
	..
	make -j8
	make install
	ldconfig

	#Install Theano
	#pip install scipy nose pydot-ng pygpu pycuda Theano
	#Install libgpuarray needed by theano
	#cd /build
	#git clone https://github.com/Theano/libgpuarray.git
	#cd libgpuarray
	#git checkout tags/v0.6.2 -b v0.6.2
	#mkdir Build
	#cd Build
	#cmake .. -DCMAKE_BUILD_TYPE=Release
	#make
	#make install


	#Install Tensorflow
	TF_PYTHON_URL="https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow_gpu-1.3.0-cp35-cp35m-linux_x86_64.whl"
	pip install --ignore-installed --upgrade $TF_PYTHON_URL

	#Install Keras
	pip install keras

	#Install Pytorch
	pip install http://download.pytorch.org/whl/cu80/torch-0.2.0.post3-cp35-cp35m-manylinux1_x86_64.whl
	pip install torchvision

%runscript
	#Executes with the singularity run command
	#delete this section to use existing docker ENTRYPOINT command


%test
	#Test that script is a success
