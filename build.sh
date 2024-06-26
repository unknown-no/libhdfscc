#!/usr/bin/env bash

set -ex

CURRENT_DIR=$(realpath $(dirname $0))
INSTALL_DIR=${CURRENT_DIR}/.install

function buildAbseil()
{
    if [ -f ${INSTALL_DIR}/lib/cmake/absl/abslConfig.cmake ]; then
        echo "File abslConfig.cmake exists, skip build abseil-cpp"
        return 0
    fi

    AbseilSrcDir=${CURRENT_DIR}/contrib/abseil-cpp
    mkdir -p ${AbseilSrcDir}/build
    cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} -S ${AbseilSrcDir} -B ${AbseilSrcDir}/build
    cmake --build ${AbseilSrcDir}/build --target install
}

function buildProtobuf()
{
    if [ -f ${INSTALL_DIR}/lib/cmake/protobuf/protobuf-config.cmake ]; then
        echo "File protobuf-config.cmake exists, skip build protobuf"
        return 0
    fi

    ProtobufSrcDir=${CURRENT_DIR}/contrib/protobuf
    mkdir -p ${ProtobufSrcDir}/build
    cmake -DCMAKE_CXX_STANDARD=17 -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR} \
          -Dprotobuf_ABSL_PROVIDER=package -DCMAKE_PREFIX_PATH=${INSTALL_DIR} \
          -Dprotobuf_BUILD_TESTS=OFF \
          -S ${ProtobufSrcDir} -B ${ProtobufSrcDir}/build
    cmake --build ${ProtobufSrcDir}/build --target install
}

function Init()
{
    echo "====Init===="
    mkdir -p ${INSTALL_DIR}
    mkdir -p ${CURRENT_DIR}/build

    buildAbseil
    buildProtobuf
}

function Build()
{
    cd ${CURRENT_DIR}

    # cmake -S . -B build -DSANITIZE=address
    cmake -S . -B build -DUSE_KRB5=1 -DKRB5_LIBRARY=krb5
    cmake --build build
}

function Done()
{
    echo "====Done===="
}

Init
Build
Done
