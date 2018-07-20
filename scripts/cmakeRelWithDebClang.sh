#!/bin/sh

cd relWithDebClang
cmake -DCMAKE_BUILD_TYPE=RelWithDebInfo -DBoost_NO_BOOST_CMAKE=TRUE -DBoost_NO_SYSTEM_PATHS=TRUE -DBOOST_ROOT:PATHNAME=/usr/local/include -DBoost_LIBRARY_DIRS:FILEPATH=/usr/local/lib -DCMAKE_C_COMPILER=clang -DCMAKE_CXX_COMPILER=clang++ ../../../sources/navitia/source/

