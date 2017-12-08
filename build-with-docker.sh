#!/bin/bash

prefix=$1
py_version=$2
uid=$(id -u)
gid=$(id -g)

if [ -z "$prefix" ]; then
  echo "Usage $0 <prefix> [py_version]"
  exit 1
fi

build_dir=`mktemp -d --tmpdir python-custom-build-XXXX`

docker run --rm --user="$uid:$gid" -v $build_dir:$prefix:z vstoykov/compiling-python $prefix $py_version

# Make archive for easy transfer and installing
archive=$(pwd)/Python-${py_version}${prefix//\//-}.tar.gz
cd $build_dir
tar czvf $archive .

echo "You can extract $(basename $archive) in $prefix"

# Cleanup build directory
rm -rf $build_dir
