#!/bin/bash

echo "Setting up dependencies..."

green="\033[0;32m"
cyan="\033[0;36m"
end="\033[0m"

set -e

# install in a custom prefix rather than /usr/local. by default, this
# chooses "prefix" directory alongside "scripts" directory.
PREFIX="$(cd "$(dirname "$0")"/ && pwd)/prefix"
echo "Will install local dependencies in the following prefix: $PREFIX"
mkdir -p "$PREFIX"/{lib,include}

CMAKE_BUILD_TYPE="Debug"
if [[ "$BUILD_RELEASE" == "1" ]]; then
    CMAKE_BUILD_TYPE="Release"
fi

CPUS=1
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    CPUS=$(grep -c ^processor /proc/cpuinfo)
elif [[ "$OSTYPE" == "darwin"* ]]; then
    CPUS=$(sysctl -n hw.ncpu)
fi

wget https://www.lua.org/ftp/lua-5.4.3.tar.gz
rm -rf lua-5.4.3
tar zxf lua-5.4.3.tar.gz
rm -rf lua-5.4.3.tar.gz
cd lua-5.4.3
make -j$CPUS
make INSTALL_TOP=$PREFIX install
cd ..
