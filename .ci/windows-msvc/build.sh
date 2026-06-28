#!/bin/sh -ex

mkdir build && cd build
cmake .. \
    -DCMAKE_BUILD_TYPE=Release \
    -G Ninja \
    -DCITRA_BUNDLE_LIBRARIES=OFF \
    -DCITRA_ENABLE_COMPATIBILITY_REPORTING=${ENABLE_COMPATIBILITY_REPORTING:-"OFF"} \
    -DCITRA_USE_BUNDLED_QT=OFF \
    -DCITRA_USE_CCACHE=ON \
    -DCMAKE_TOOLCHAIN_FILE="$(pwd)/../CMakeModules/MSVCCache.cmake" \
    -DENABLE_COMPATIBILITY_LIST_DOWNLOAD=ON \
    -DENABLE_MF=ON \
    -DENABLE_QT_TRANSLATION=OFF \
    -DENABLE_SDL2=OFF \
    -DENABLE_WEB_SERVICE=OFF \
    -DOPENSSL_DLL_DIR="C:\Program Files\OpenSSL\bin" \
    -DQt5_DIR="C:\Qt\Qt\Qt-5.15.19\lib\cmake\Qt5"

ninja
# show the caching efficiency
buildcache -s

ctest -VV -C Release || echo "::error ::Test error occurred on Windows MSVC build"
