#!/bin/bash

# Set environment variables for Ignition Common3
export CMAKE_PREFIX_PATH=/usr/local/lib64/cmake:$CMAKE_PREFIX_PATH
export QWT_ROOT_DIR=/usr/local/qwt-6.1.6
export QWT_INCLUDE_DIR=/usr/local/qwt-6.1.6/include
export QWT_LIBRARY_DIR=/usr/local/qwt-6.1.6/lib
export LD_LIBRARY_PATH=$QWT_LIBRARY_DIR:$LD_LIBRARY_PATH
export IGNITION_COMMON3_INCLUDE_DIR=/usr/local/include/ignition/common3
export IGNITION_COMMON3_LIBRARY=/usr/local/lib64/libignition-common3.so
export IGNITION_COMMON3_DIR=/usr/local/lib64/cmake/ignition-common3

# Source the bashrc file to ensure all environment variables are loaded
source ~/.bashrc

# Navigate to the Gazebo source directory
cd /home/yuyu/gazebo-classic/build

# Remove previous CMake cache and build files
rm -rf CMakeCache.txt CMakeFiles

# Run CMake with specified paths
cmake -DIGNITION_COMMON3_DIR=/usr/local/lib64/cmake/ignition-common3 \
      -DIGNITION_COMMON3_INCLUDE_DIR=/usr/local/include/ignition/common3 \
      -DIGNITION_COMMON3_LIBRARY=/usr/local/lib64/libignition-common3.so \
      ..

# Check if cmake command was successful
if [ $? -eq 0 ]; then
    echo "CMake configuration successful. You can now run 'make' to build Gazebo."
else
    echo "CMake configuration failed. Please check the error messages above."
fi
