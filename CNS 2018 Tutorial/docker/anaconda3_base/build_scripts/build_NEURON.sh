#!/bin/bash

USE_CONDA=true
CONDA_ENV=''
BUILD_PATH=/home/build
INSTALL_PATH=/home/shared
NRN_VER=7.5
NRN_REL=1370

# Check scripts options
while [[ $# -gt 0 ]]; do
	case "$1" in
		--no-conda) USE_CONDA=false ;;
		-e|--conda-env) CONDA_ENV=$2; shift ;;
		-b|--build-path) BUILD_PATH=$2; shift ;;
		-i|"--install-path") INSTALL_PATH=$2; shift ;;
		-v|--nrn-version) NRN_VER=$2; shift ;;
		-r|--nrn-release) NRN_REL=$2; shift ;;
		-l|--nrn-latest) NRN_REL='';;
	esac
	shift
done

# activate conda environment if specified
if [[ ! -z ${CONDA_ENV} ]]; then
	source activate ${CONDA_ENV}
fi

if [[ ${USE_CONDA}=true ]]; then
	# install using conda
	# conda install -y -q mpi4py ncurses numpy=1.11
	conda install -y -q mpi4py
else
	# install using apt-get and pip
	apt-get install -y -q mpich2
	pip install -y -q mpi4py ncurses numpy
fi

# Download and unpack NEURON
cd ${BUILD_PATH}
NRN_BASENAME=nrn-${NRN_VER}
NRN_URL=https://www.neuron.yale.edu/ftp/neuron/versions/v${NRN_VER}
if [[ ! -z ${NRN_REL} ]]; then
	# Download specified release
	NRN_URL=${NRN_URL}/v${NRN_VER}.rel-${NRN_REL}/nrn-${NRN_VER}.rel-${NRN_REL}.tar.gz
else
	# Download latest source
	NRN_URL=${NRN_URL}/nrn-${NRN_VER}.tar.gz
fi
wget --quiet ${NRN_URL} -O ${NRN_BASENAME}.tar.gz
tar xzf ${NRN_BASENAME}.tar.gz

# Build NEURON and install with python
cd ${NRN_BASENAME}
./configure --with-paranrn --with-nrnpython --without-iv --prefix=${INSTALL_DIR}
make \
	&& make install \
	&& cd src/nrnpython \
	&& python setup.py install
