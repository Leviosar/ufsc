#!/bin/bash

SCRIPT="$(basename $0)"

message() {
    echo $SCRIPT: "$@"
}

die() {
    message "error: $1" 1>&2
    exit 1
}

usage() {
    echo "usage: $SCRIPT [-s STANDARD] [-h] executable

positional arguments:
    executable  the final executable name, e.g. for 'array_list_test.cpp'
                use 'array_list_test'

optional arguments:
    -s STD      change the C++ standard (11, 14, 17...)
    -h          show this help message and exit" 1>&2
    exit 1
}

std=14

while getopts ":s:" option; do
    case "$option" in
        s) std=$OPTARG ;;
        h) usage ;;
    esac
done

shift $((OPTIND - 1))

[[ "$#" == 1 ]] || usage

LOCAL_ARGS="libgtest.a -lpthread -I."
SYSTEM_ARGS="-lgtest -lpthread"

GTEST_GITHUB='https://github.com/google/googletest.git'

THREADS="$(($(nproc)+1))"

make-gtest-checker() {
    cat > check_gtest.cpp << EOF
#include <gtest/gtest.h>

int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
EOF
}

build() {
    g++ -o "$1" "$1".cpp "${@:2}" -std=c++$std
}

check-gtest() {
    build check_gtest "$@" 2> /dev/null
}

find-gtest() {
    make-gtest-checker
    (check-gtest $SYSTEM_ARGS && echo "system") ||
    (check-gtest $LOCAL_ARGS && echo "local") ||
    echo "none"
    rm -f check_gtest{,.cpp}
}

build-gtest() {
    [[ ! -d googletest ]] || die "A directory called googletest already exists"
    git clone $GTEST_GITHUB &&
    cd googletest/googletest &&
    mkdir build &&
    cd build &&
    cmake ../ &&
    make -j$THREADS &&
    cd ../../.. &&
    cp googletest/googletest/build/libgtest.a . &&
    cp -r googletest/googletest/include/gtest .
}

case $(find-gtest) in
    none)
        message "gtest not found, will build from source"
        build-gtest
        ;&
    local)
        ARGS=$LOCAL_ARGS
        ;;
    system)
        ARGS=$SYSTEM_ARGS
        ;;
esac

build $1 $ARGS
./$1
