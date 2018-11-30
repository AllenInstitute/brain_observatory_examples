#!/bin/bash

USE_CONDA=true
CONDA_ENV=''
BUILD_PATH=/home/build
INSTALL_PATH=/home/shared
NEST_VER=2.12.0
SET_NEST_VARS=false

# Check scripts options
while [[ $# -gt 0 ]]; do
	case "$1" in
		--no-conda) USE_CONDA=false ;;
		-e|--conda-env) CONDA_ENV=$2; shift ;;
		-b|--build-path) BUILD_PATH=$2; shift ;;
		-i|"--install-path") INSTALL_PATH=$2; shift ;;
		-v|"--nest-version") NEST_VER=$2; shift ;;
		"--with-nest_vars") SET_NEST_VARS=true ;;
	esac
	shift
done

# activate conda environment if specified
if [[ ! -z ${CONDA_ENV} ]]; then
	echo "${CONDA_ENV}"
	source activate ${CONDA_ENV}
fi


if [[ ${USE_CONDA}=true ]]; then
	# install using conda
	conda install -y mpi4py cmake gsl libgcc
else
	# install using apt-get and pip
	apt-get install -y mpich2 cmake gcc gsl
	# pip install -y pyqt
fi

# Download and unpack NEST
cd ${BUILD_PATH}
NEST_URL=https://github.com/nest/nest-simulator/releases/download/v${NEST_VER}/nest-${NEST_VER}.tar.gz 
wget --quiet ${NEST_URL} -O nest.tar.gz
tar xfz nest.tar.gz

# Compile nest
cd nest-${NEST_VER}
mkdir build && cd build
cmake -DCMAKE_INSTALL_PREFIX:PATH=${INSTALL_PATH}/nest -Dwith-mpi=ON -Dwith-gsl=ON -Dwith-python=ON -Dwith-ltdl=ON .. \
	&& make \
	&& make install

if [[ ${SET_NEST_VARS}=true ]]; then
	# will install link to nest binary and libraries into default bashrc
	# TODO: find a better way to set bin and library paths
	echo "source ${INSTALL_PATH}/nest/bin/nest_vars.sh" >> /etc/bash.bashrc
fi
