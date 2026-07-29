# Copyright 2023-2026 DreamWorks Animation LLC
# SPDX-License-Identifier: Apache-2.0 

# Install Ubuntu 24.04 packages for building MoonRay
# source this script in bash

install_qt=1
install_cuda=1
install_cgroup=1
for i in "$@" 
do
case ${i,,} in
    --noqt|-noqt)
        install_qt=0
    ;;
    --nocuda|-nocuda)
        install_cuda=0
    ;;
    --nocgroup|-nocgroup)
        install_cgroup=0
    ;;
    *)
        echo "Unknown option: $i"
        return 1
    ;;
esac
done

apt-get update

apt-get install -y \
    build-essential \
    cmake \
    git \
    git-lfs \
    bison \
    flex \
    wget \
    patch \
    lsb-release \
    extra-cmake-modules \
    python3 \
    python3-dev \
    python3-numpy \
    python3-jinja2 \
    pybind11-dev

apt-get install -y \
    libgif-dev \
    libmng-dev \
    libtiff-dev \
    libjpeg-dev \
    libatomic1 \
    uuid-dev \
    libssl-dev \
    libcurl4-openssl-dev \
    libfreetype-dev \
    zlib1g-dev \
    libblosc-dev \
    libboost-chrono-dev \
    libboost-date-time-dev \
    libboost-filesystem-dev \
    libboost-python-dev \
    libboost-program-options-dev \
    libboost-regex-dev \
    libboost-thread-dev \
    libboost-system-dev \
    libboost-dev \
    lua5.4 \
    liblua5.4-dev \
    libopenvdb-dev \
    libtbb-dev \
    liblog4cplus-dev \
    libcppunit-dev \
    libmicrohttpd-dev \
    libsquish-dev \
    libturbojpeg0-dev \
    libdcmtk-dev \
    libheif-dev \
    libraw-dev \
    libptexenc-dev \
    libopencv-dev \
    libopenjp2-7-dev \
    libnsl-dev

apt-get install -y \
    libopengl-dev \
    libglx-dev \
    libglvnd-dev \
    libwayland-dev \
    libxkbcommon-dev \
    wayland-protocols \
    libxrandr-dev \
    libxinerama-dev \
    libxcursor-dev \
    libxi-dev

mkdir -p /opt/MoonRay/installs/{bin,lib,include}

if [ $install_cgroup -eq 1 ]
then
    apt-get install -y libcgroup-dev
fi

if [ $install_qt -eq 1 ]
then
    apt-get install -y qtbase5-dev qtscript5-dev libqt5opengl5-dev
fi

if [ $install_cuda -eq 1 ]
then
    apt-get install -y nvidia-cuda-toolkit nvidia-cuda-dev
    export PATH=/usr/local/cuda/bin:${PATH}
    export LD_LIBRARY_PATH=/usr/local/cuda/lib64:${LD_LIBRARY_PATH}
fi
