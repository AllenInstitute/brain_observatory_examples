#!/bin/bash

if [[ -x "$(command -v wget)" ]]; then
	wget "https://github.com/AllenInstitute/bmtk/archive/release/workshop2018.tar.gz" -O bmtk.tar.gz
elif [[ -x "$(command -v curl)" ]]; then
	curl "https://github.com/AllenInstitute/bmtk/archive/release/workshop2018.tar.gz" -o bmtk.tar.gz
else
	echo "ERROR: could not find wget or curl. Please download "
	echo "   https://github.com/AllenInstitute/bmtk/archive/release/workshop2018.tar.gz"
	echo "into this directory."
fi
