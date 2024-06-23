#!/usr/bin/env bash

set -ex

CURRENT_DIR=$(realpath $(dirname $0))

cd ${CURRENT_DIR}

# rm -rf build
mkdir -p build

# cmake -S . -B build -DSANITIZE=address
cmake -S . -B build

cmake --build build
