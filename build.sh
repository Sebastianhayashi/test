#!/bin/bash

# Set environment variables for Ignition Common3
export CMAKE_PREFIX_PATH=/usr/local/lib64/cmake:$CMAKE_PREFIX_PATH
export QWT_ROOT_DIR=/usr/local/qwt-6.1.6
export QWT_INCLUDE_DIR=/usr/local/qwt-6.1.6/include
export QWT_LIBRARY_DIR=/usr/local/qwt-6.1.6/lib
export LD_LIBRARY_PATH=$QWT_LIBRARY_DIR:$LD_LIBRARY_PATH

# Source the bashrc file to ensure all environment variables are loaded
source ~/.bashrc

# Navigate to the Ignition Common3 build directory
cd /home/yuyu/gz-common/build

# Run make install and capture the output
INSTALL_LOG=$(sudo make install)

# Extract the installation paths
INCLUDE_PATH=$(echo "$INSTALL_LOG" | grep -oP '(?<=-- Up-to-date: ).*(?=/include)')
LIB_PATH=$(echo "$INSTALL_LOG" | grep -oP '(?<=-- Up-to-date: ).*(?=/lib64)')

# Set the extracted paths as environment variables
export IGNITION_COMMON3_INCLUDE_DIR="$INCLUDE_PATH/include/ignition/common3"
export IGNITION_COMMON3_LIBRARY="$LIB_PATH/lib64/libignition-common3.so"
export IGNITION_COMMON3_DIR="$LIB_PATH/lib64/cmake/ignition-common3"

# Output the environment variables for debugging
echo "IGNITION_COMMON3_INCLUDE_DIR: $IGNITION_COMMON3_INCLUDE_DIR"
echo "IGNITION_COMMON3_LIBRARY: $IGNITION_COMMON3_LIBRARY"
echo "IGNITION_COMMON3_DIR: $IGNITION_COMMON3_DIR"

# Navigate to the Gazebo source directory
cd /home/yuyu/gazebo-classic/build

# Remove previous CMake cache and build files
rm -rf CMakeCache.txt CMakeFiles

# Run CMake with specified paths
cmake -DIGNITION_COMMON3_DIR=$IGNITION_COMMON3_DIR \
      -DIGNITION_COMMON3_INCLUDE_DIR=$IGNITION_COMMON3_INCLUDE_DIR \
      -DIGNITION_COMMON3_LIBRARY=$IGNITION_COMMON3_LIBRARY \
      -DCMAKE_LIBRARY_PATH=/usr/local/lib64 \
      ..

# Check if cmake command was successful
if [ $? -eq 0 ]; then
    echo "CMake configuration successful. You can now run 'make' to build Gazebo."
else
    echo "CMake configuration failed. Please check the error messages above."
fi
