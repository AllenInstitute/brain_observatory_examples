#!/bin/bash

USE_CONDA=true
CONDA_ENV=''
BUILD_PATH=/home/build
INSTALL_PATH=/home/shared
PYTHON_VER='python2.7'
PACKAGE_STR=''

# Check scripts options
while [[ $# -gt 0 ]]; do
	case "$1" in
		--no-conda) USE_CONDA=false ;;
		-e|--conda-env) CONDA_ENV=$2; shift ;;
		-b|--build-path) BUILD_PATH=$2; shift ;;
		-i|"--install-path") INSTALL_PATH=$2; shift ;;
		-p|--python-ver) PACKAGE_STR=PYTHON_VER; shift ;;
	esac
	shift
done

# activate conda environment if specified
if [[ ! -z ${CONDA_ENV} ]]; then
	source activate ${CONDA_ENV}
fi

if [[ ${PYTHON_VER} == "3*" ]]; then
	PACKAGE_STR='=py36_3'
fi

if [[ ${USE_CONDA}=true ]]; then
	# install using conda
	conda install -y -c nicholasc dipde=0.2.1${PACKAGE_STR}
else
	# TODO: get and build latest version of Dipde from source
	echo "ERROR: At the moment DiPDE can only be installed through conda"
	exit 1
fi
