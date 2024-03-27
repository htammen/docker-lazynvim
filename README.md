# docker-lazynvim

This repository lets you build a Docker image with which you can run [lazyvim](https://www.lazyvim.org/) AND 
edit your [SAP CAP](https://cap.cloud.sap) in a manner similar to VSCode.  
In your Docker container which you create from the image you can not only leverage a preinstalled 
lazyvim editor but also the [cds-lsp](https://www.npmjs.com/package/@sap/cds-lsp) language server as well as some others (typescript, json, lua).  

Go ahead, clone this repository, build the Docker image and run a container that automatically starts 
lazyvim.

# Build Docker image
`docker build -t lazynvim ./`

# Run Docker container
`cd` into the folder where your CAP project is located and run 

`docker run -it -v $PWD:$PWD -w $PWD --name mycontainername lazynvim`

- The container starts with lazyvim and installs all configured plugins. This will take a bit of time.
- After installation press "q" to exit the lazyvim dialog and start editing your files.
  use keyboard <space><space> e.g. to open the (git)files in your working directory.
- The current working dir of the host is mapped to the current working dir in the container. 
  - That said you can edit your files on the host (your local pc) and run the neovim app in the docker container.

Another example to run the container:  

`docker run -it -v $PWD:/home/$USER/workspace -w /home/$USER/workspace --name mycontainername lazynvim`  

This does the same as the command above but gives you a folder `home/<your username at the host>/workspace` to edit you files.

## I don't use docker run --rm
As you can see in the before mentioned `docker run` commands, I don't use the `--rm` option. This is because the first start of 
the container takes a few seconds (~30) until I'm able to work with lazyvim.  
Following calls of `docker start` are very fast.  

I have a container for every project I work on. In the project root directory I have the following two shell scripts that I use to 
`run` (create) and `start` the container.

lv-docker-run
```
#!/bin/bash

# run a new docker container from image lazynvim.
# This container has a running lazynvim instance installed with cds and typescript language server activated.
#
docker run -it --workdir=/home/$USER/workspace -v $PWD:/home/$USER/workspace/ --name "lv_${PWD##*/}" lazynvim
```

lv-docker-start

```
#! /bin/bash

# This script starts a docker container with name lznv_eeg in interactive mode
docker start -i "lv_${PWD##*/}"
```

The `lv_${PWD##*/}` thing creates a string that begins with 'lv_' and adds the name of the current directory to it, not 
the complete path, but the last part of the path.  
Cause my project directories are usually named after the name of the project I directly see in the `docker ps --all` output
for which projects I already have containers.

