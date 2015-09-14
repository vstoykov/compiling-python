#!/bin/bash

username=$1

if [ -z "$username" ]; then
  echo "You need to provide username"
  exit 1
fi

user_home=/home/$username

docker run --rm -v $user_home:$user_home -it vstoykov/compiling-python
