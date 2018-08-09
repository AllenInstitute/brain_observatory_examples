FROM bmtk/anaconda3
MAINTAINER Kael Dai <kaeld@alleninstitute.org>

ENV PYTHON_VER=2.7
ENV PYTHON_ENV=python${PYTHON_VER}


RUN /bin/bash --login -c "source activate bmtk; \
    pip install tables; \
    pip install allensdk"

RUN curl -sL https://deb.nodesource.com/setup_8.x | bash -
RUN apt-get install -y nodejs; \
    npm install n -g; \
    n 8.11.2; \
    npm install -g configurable-http-proxy; \
    pip install jupyterhub oauthenticator; \
    jupyterhub --generate-config; \
    cat "c.JupyterHub.spawner_class = 'dockerspawner.SystemUserSpawner'" >> jupyterhub_config.py; \
    cat 'c.DockerSpawner.container_ip = "0.0.0.0"' >> jupyterhub_config.py; \
    git clone https://github.com/jupyterhub/dockerspawner.git; \
    cd dockerspawner; \
    pip install -r requirements.txt; \
    pip install .


RUN mkdir /home/shared/user_workdir
RUN mkdir /home/shared/user_workdir/saved;
RUN mkdir -p /home/shared/user_workdir/neuron_mechanisms/modfiles


RUN cd /home/shared; \
    git clone https://github.com/AllenInstitute/CNS_2018_Tutorial; \
    cp -r CNS_2018_Tutorial/bmtk /home/shared/user_workdir; \
    cp -r CNS_2018_Tutorial/resources /home/shared/user_workdir; \
    cp -r CNS_2018_Tutorial/BrainObservatory /home/shared/user_workdir


RUN /bin/bash --login -c "source activate bmtk; \
    cd /home/shared/user_workdir/bmtk/biophysical_notebook/components/mechanisms; \
    /home/shared/x86_64/bin/nrnivmodl modfiles"

# For testing and development, should remove
COPY ./mechanisms/modfiles/*.mod /home/shared/user_workdir/neuron_mechanisms/modfiles/
RUN /bin/bash --login -c "source activate bmtk; \
    cd /home/shared/user_workdir/neuron_mechanisms; \
    /home/shared/x86_64/bin/nrnivmodl modfiles"

# Install bmtk environment kernel
RUN conda install nb_conda
RUN /bin/bash --login -c "source activate bmtk; \
    conda install -y jupyter ipython ipykernel; \
    python -m ipykernel install --user --name bmkt --display-name 'bmtk'"

EXPOSE 8888

# Taken from /home/shared/nest/bin/nest_vars.sh, needed to run nest and pynest in jupyter
ENV NEST_INSTALL_DIR=/home/shared/nest
ENV NEST_DATA_DIR=${NEST_INSTALL_DIR}/share/nest
ENV NEST_DOC_DIR=${NEST_INSTALL_DIR}/share/doc/nest
ENV NEST_MODULE_PATH=${NEST_INSTALL_DIR}/lib/nest
ENV NEST_PYTHON_PREFIX=${NEST_INSTALL_DIR}/lib/${PYTHON_ENV}/site-packages
ENV PYTHONPATH=${NEST_PYTHON_PREFIX}:${PYTHONPATH}
ENV PATH=${NEST_INSTALL_DIR}/bin:$PATH