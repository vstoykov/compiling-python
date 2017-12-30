#!/bin/bash

PREFIX=$1
PY_VERSION=$2
PACKAGES="${@:3}"

if [ -z "$PREFIX" ]; then
  echo "You need to provide prefix"
  exit 1
fi

if [ -z "$PY_VERSION" ]; then
  PY_VERSION=2.7.13
fi

PYTHON_DOWNLOAD_URL=https://www.python.org/ftp/python/${PY_VERSION}/Python-${PY_VERSION}.tgz
PYTHON=${PREFIX}/bin/python${PY_VERSION%.*}
CONFIGURE_OPTIONS=""

if [[ $PY_VERSION == 2.* ]]; then
    CONFIGURE_OPTIONS="--enable-unicode=ucs4"
fi

# Downloading and installing Python
cd /tmp/
echo "Downloading $PYTHON_DOWNLOAD_URL ..."
curl $PYTHON_DOWNLOAD_URL | tar xzf -
cd Python-${PY_VERSION}
./configure --prefix ${PREFIX} ${CONFIGURE_OPTIONS}
make && make altinstall

$PYTHON /usr/local/bin/get-pip.py

if [ ! -z "$PACKAGES" ]; then
    ${PYTHON} -m pip install $PACKAGES
fi

echo "Python compilation is complete!"
