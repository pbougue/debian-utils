#!/bin/sh

cd debugClang
cmake -DCMAKE_BUILD_TYPE=Debug -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ../../../sources/navitia/source/

