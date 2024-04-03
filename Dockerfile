FROM alpine:edge

MAINTAINER Helmut Tammen <h.tammen@tammen-it-solutions.de>

LABEL de.tammenit.lazynvim.name="Lazynvim" de.tammenit.lazynvim.version=0.0.1

# install linux packages 
RUN apk add xclip wget unzip gzip git lazygit neovim neovim-doc ripgrep fd nodejs npm jq sudo alpine-sdk --update

# copy some bash stuff
ADD .bashrc /root/.bashrc
ADD .bash_aliases /root/.bash_aliases
RUN source /root/.bashrc && \
    source /root/.bash_aliases

# install lazyvim on top of neovim 
RUN git clone https://github.com/LazyVim/starter /root/.config/nvim && \
    source /root/.bash_aliases && \
    echo 'require("config.cds")' >> /root/.config/nvim/init.lua

# copy some lazyvim config adjustments
ADD vim_notify.lua /root/.config/nvim/lua/plugins/vim_notify.lua
ADD mason-nvim.lua /root/.config/nvim/lua/plugins/mason-nvim.lua
ADD cds.lua /root/.config/nvim/lua/config/cds.lua
ADD rest.lua /root/.config/nvim/lua/plugins/rest.lua
ADD keymaps.lua /root/.config/nvim/lua/config/keymaps.lua

# copy the files for tree-sitter-cds (syntax highlighting)
ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/locals.scm /root/.config/nvim/queries/cds/locals.scm
ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/folds.scm /root/.config/nvim/queries/cds/folds.scm
ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/highlights.scm /root/.config/nvim/queries/cds/highlights.scm
ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/indents.scm /root/.config/nvim/queries/cds/indents.scm
ADD https://github.com/cap-js-community/tree-sitter-cds/raw/main/nvim/injections.scm /root/.config/nvim/queries/cds/injections.scm


# start neovim with lazyvim flavor
ENTRYPOINT ["nvim"]
