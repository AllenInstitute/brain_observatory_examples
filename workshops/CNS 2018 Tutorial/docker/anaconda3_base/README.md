Build image
==============

Docker needs to build the image (Dockerfile). To do so:

1. Run the docker build command to turn the image into a container
```bash
  $ docker build -t bmtk/anaconda3 .
```

The -t parameter is used for the name the container. Feel free to change it as you please.

2. Check image is installed in the docker service by running the following command
```bash
  $ docker images
```

If build was successfull you should see a bmtk/anaconda3 image


Run the image
=============

1. Log into the docker image by running the command
```bash
  $ docker run -i -t bmtk/anaconda3 /bin/bash
```

Once in side the terminal, you will have access to nest and NEURON, and the modelingsdk with all dependencies will be installed into python. 

The Modeling SDK examples are located in /home/build/modelingsdk/docs/examples.
