#!/bin/bash

username=$1
py_version=$2
uid=$(id -u)
gid=$(id -g)

if [ -z "$username" ]; then
  echo "Usage $0 <username> [py_version]"
  exit 1
fi

user_home=/home/$username
build_dir=/tmp/python-user-build/$username

# Ensure that the build directory exists
mkdir -p $build_dir

# Clean the build directory from previous builds
rm -f $build_dir/Python-*.tar.gz
rm -rf $build_dir/.local

docker run --rm -it --user="$uid:$gid" -v $build_dir:$user_home:z vstoykov/compiling-python $username $py_version

# Move resulting file to current directory
mv -i $build_dir/Python-*.tar.gz ./
