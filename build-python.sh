#!/bin/bash

PREFIX=$1
PY_VERSION=$2

if [ -z "$PREFIX" ]; then
  echo "You need to provide prefix"
  exit 1
fi

if [ -z "$PY_VERSION" ]; then
  PY_VERSION=2.7.13
fi

PYTHON=${PREFIX}/bin/python${PY_VERSION%.*}
PIP=${PYTHON} -m pip
CONFIGURE_OPTIONS=""

if [[ $PY_VERSION == 2.* ]]; then
    CONFIGURE_OPTIONS="--enable-unicode=ucs4"
fi

# Downloading and installing Python
cd /tmp/
curl https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tgz | tar xzf -
cd Python-${PY_VERSION}
./configure --prefix ${PREFIX} ${CONFIGURE_OPTIONS}
make && make altinstall

# Installing pip
curl https://bootstrap.pypa.io/get-pip.py | $PYTHON

# Installing Python packages which needs compilation
$PIP install \
    Pillow \
    MySQL-python \
    psycopg2 \
    lxml \
    reportlab

# Install some other usefull packages
$PIP install \
    virtualenvwrapper \
    ipython

echo "Python compilation is complete!"
