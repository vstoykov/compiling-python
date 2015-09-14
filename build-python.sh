#!/bin/bash

if [ -z "$USERNAME" ]; then
  USERNAME=$(echo `ls /home/` | awk '{ print $1 }')
  if [ -z "$USERNAME" ]; then
    echo "There is no user defined in USERNAME and there is no attached directory in /home/."
    echo "You need to provide such in order to compile user specific Python."
    exit 1
  fi
fi

if [ -z "$PY_VERSION" ]; then
  PY_VERSION=2.7.10
fi

USER_HOME=/home/${USERNAME}
PREFIX=${USER_HOME}/.local
PYTHON=${PREFIX}/bin/python${PY_VERSION%.*}
PIP=${PREFIX}/bin/pip

# Ensure user's home directory exists
mkdir -p ${USER_HOME}

# Downloading and installing Python
cd /tmp/
wget https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tar.xz
tar xf Python-${PY_VERSION}.tar.xz
cd Python-${PY_VERSION}
./configure --prefix ${PREFIX} --enable-unicode=ucs4
make && make altinstall

# Installing pip
wget https://bootstrap.pypa.io/get-pip.py
$PYTHON get-pip.py

# Installing Python packages which needs compilation
$PIP install --no-cache-dir \
    Pillow \
    MySQL-python \
    psycopg2 \
    lxml \
    reportlab

# Install some other usefull packages
$PIP install --no-cache-dir \
    virtualenvwrapper \
    ipython

# Make archive for easy transfer and installing
cd ${USER_HOME}
archive_name=Python-${PY_VERSION}-${USERNAME}.tar.gz
tar czvf $archive_name .local

echo "Python installation is complete!"
echo "You can copy the file ${archive_name} to your shared hosting"
echo "and extract it in your home directory ${USER_HOME}"
