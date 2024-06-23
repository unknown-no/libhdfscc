#!/usr/bin/env bash

set -ex

CURRENT_DIR=$(realpath $(dirname $0))
INSTALL_DIR=${CURRENT_DIR}/.install

function Init()
{
    echo "====Init===="
    mkdir -p ${INSTALL_DIR}
    mkdir -p ${CURRENT_DIR}/build
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
