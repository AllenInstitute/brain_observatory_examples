FROM continuumio/anaconda3
MAINTAINER Kael Dai <kaeld@alleninstitute.org>


# TODO: look into getting ARCH from 'arch' command
ARG ARCH=x86_64
ARG PY_VER=2.7

RUN apt-get update && apt-get install -y -qq \ 
		automake \ 
		libtool \
		build-essential \
		libncurses5-dev

# Place for source code and scripts
ENV BUILD_DIR=/home/build
RUN mkdir -p ${BUILD_DIR}

# Place for binaries and libraries
ENV INSTALL_DIR=/home/shared
RUN mkdir -p ${INSTALL_DIR}

WORKDIR ${BUILD_DIR}
COPY build_scripts/*.sh ./
RUN chmod +x *.sh

RUN conda create -y -q --name bmtk python=${PY_VER} pandas h5py


# Install NEURON 
RUN ./build_NEURON.sh --build-path ${BUILD_DIR} --install-path ${INSTALL_DIR} --conda-env bmtk --nrn-latest
ENV PATH="${PATH}:${INSTALL_DIR}/$ARCH/bin"


# Install NEST
RUN ./build_NEST.sh --build-path ${BUILD_DIR} --install-path ${INSTALL_DIR} --with-nest_vars --conda-env bmtk --pythons ${PY_VER}


# Install Dipde
RUN ./build_DiPDE.sh --conda-env bmtk


# Install Tensorflow
# RUN ./build_Tensorflow.sh --conda-env bmtk


# Installs bmtk develop
RUN /bin/bash --login -c "source activate bmtk; \
	git clone --branch release/workshop2018 https://github.com/AllenInstitute/bmtk.git; \
	cd bmtk; \
    python setup.py install"

