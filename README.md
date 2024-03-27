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

