#!/bin/sh -ex

mkdir build && cd build
cmake .. -G Ninja \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_C_COMPILER_LAUNCHER=ccache \
    -DCMAKE_CXX_COMPILER_LAUNCHER=ccache \
    -DALLOW_EXTERNAL_SPIRV_TOOLS=1 \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=OFF \
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=ON \
    -DENABLE_QT_TRANSLATION=OFF \
    -DENABLE_QT_UPDATER=OFF \
    -DENABLE_SCRIPTING=OFF \
    -DENABLE_TESTS=OFF \
    -DENABLE_WEB_SERVICE=OFF \
    -DQt5_DIR="C:\Qt\Qt\Qt-5.15.19\lib\cmake\Qt5" \
    -DUSE_SYSTEM_QT=ON \
    -DUSE_SYSTEM_SDL2=ON
ninja
ninja bundle

ccache -s -v

ctest -VV -C Release || echo "::error ::Test error occurred on Windows build"
