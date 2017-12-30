#!/bin/bash

username=$1
py_version=$2
packages=${@:3}

if [ -z "$username" ]; then
  echo "Usage $0 <username> [py_version] [[packages]...]"
  exit 1
fi

if [ -z "$py_version" ]; then
    py_version=2.7.13
fi

prefix=/home/$username/.local

./build-with-docker.sh $prefix $py_version uwsgi mysqlclient $packages
