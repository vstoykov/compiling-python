# Compiling Python

This is collection of scripts for automatic python compilation.


## build-python.sh

Generic script to build Python and install some usefull packages inside

Usage:
```
./build-python.sh <prefix> [version]
```

## build-with-docker.sh

Use Docker image created with `build-python.sh` inside to build Python for CenotOS 6.
(Docker image is created from the Dockerfile. You can simply run `make` to create the 
image locally if youo do not trust Docker).
This script will create tar.gz archive that can be extracted at the given during
compilation prefix.

Produced Python is not intended for global instal in a systm but instead
it is build for using in a shared hosting. For that reason there is a Docker file
for creating a DockerHub image with CenotOS 6 and compiling Python inside a container.

Usage:
```
./build-with-docker.sh <prefix> [version]
```
Example:

If you want to create a Python that will run on your shared hosting you need to run:
```
./build-with-docker.sh /home/<username>/.local [version]
```

When you extract the resulting archive into that directory on your shared hosting then
you can run you cgi scripts with this version of Python
