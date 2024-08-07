#!/bin/bash

# 清除之前的 CMake 缓存
cd /home/yuyu/gazebo-classic/build
rm -rf CMakeCache.txt CMakeFiles

# 设置环境变量
export CMAKE_PREFIX_PATH=/usr/local/lib64/cmake:$CMAKE_PREFIX_PATH
export LD_LIBRARY_PATH=/usr/local/lib64:$LD_LIBRARY_PATH
export IGNITION_COMMON3_INCLUDE_DIR=/usr/local/include/ignition/common3
export IGNITION_COMMON3_LIBRARY=/usr/local/lib64/libignition-common3.so

# 运行 cmake 并指定源代码路径
cmake .. -DCMAKE_PREFIX_PATH=$CMAKE_PREFIX_PATH -DIGNITION_COMMON3_INCLUDE_DIR=$IGNITION_COMMON3_INCLUDE_DIR -DIGNITION_COMMON3_LIBRARY=$IGNITION_COMMON3_LIBRARY
