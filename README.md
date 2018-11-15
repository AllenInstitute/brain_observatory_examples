# Brain Observatory Examples
Example Jupyter notebooks for the Allen Brain Observatory

This repository contains 3 sets of notebooks:

- `tutorial` contains a set of notebooks that provide a self-guided tour of
  accessing the Brain Observatory through the AllenSDK. It is expected that
  users will explore these notebooks in order.
- `workshops` contains notebooks used for any technical workshops that are run
  by the Allen Institute. These are a snapshot and record of
- `gallery` contains example notebooks that demonstrate some analysis or
  visualization using the Brain Observatory and AllenSDK. These notebooks are
  standalone entities. If it doesn't belong in the main tutorial and it is not
  from a technical workshop, it probably goes here.

```
brain_observatory_gallery
├─ tutorial/                  # Official tutorial for the Allen Brain Observatory
│  ├─ requirements.txt        # packages required to run the tutorial    
│  ├─ runtime.txt             # Python version required to run the tutorial
│  ├─ Index.ipynb    
│  ├─ 1. Intro to Brain Observatory.ipynb                              
│  └─ ...      
├─ gallery/                   # analysis files per experiment session
│  ├─ requirements.txt        # packages required to run the tutorial    
│  ├─ runtime.txt              
│  ├─ joy_plots.ipynb           
│  └─ ...                 
└─ workshops/                 # technical workshops
   ├─ 2018 Workshop Example/  # Example workshop
   │  ├─ requirements.txt         
   │  ├─ runtime.txt           
   │  ├─ 1. Intro to Brain Observatory.ipynb                              
   │  └─ ...      
   ├─ 2018 Other Example/
   └─ ...              
```              


## Running the examples

Each folder contains the necessary assets to build a Docker container for the notebooks contained therein using repo2docker...

1. install Docker
2. install repo2docker: `pip install repo2docker` (you may want to install from source)
3. build a docker container & launch a notebook server: `repo2docker ./`
