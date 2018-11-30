Build the Image
===============
1. make sure bmtk/anaconda3 image is installed on docker
```bash
  $ docker images
```
If it is not installed go to ../anaconda3_base and follow instructions there.

2. Run the following command
```bash
  $ docker build -t bmtk/jupyter .
```


Start Jupyter Hub
=================
To test with normal AWS behavior
From the root directory run 
```bash
  $ docker run -p 8000:8000 bmtk/jupyter
```

To work on it in develop/testing mode (and have it save your notebooks), from the root directory run 
```bash
  $ docker run -v $(pwd)/bmtk:/home/user/workdir/bmtk -p 8000:8000 bmtk/jupyter
```
Open a browser and go to http:127.0.0.1:8000

**NOTE**: When a docker image is done all changes, including new notebooks saved inside the image, will be deleted. The -v argument overcomes this by created a shared directory between the container and the host, so it is important to place the files within this directory. You can specify a different location by replacing $(pwd)/saved with /path/to/saved/directory.


User: user  
Password: user