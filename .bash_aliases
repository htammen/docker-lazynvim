# open ranger and close it in that directory that ranger currently is in when pressing 'q'
alias r='r --choosedir=$HOME/.rangerdir; LASTDIR=`cat $HOME/.rangerdir`; cd "$LASTDIR"'
alias c='clear'
alias cc="clear && printf '\e[3J'"
alias b='x-www-browser'
alias s='source'
alias lg='lazygit'
alias ps1='PS1="$> "'
alias os='cat /etc/os-release' # linux release info
# copy / paste to clipboard. See https://ostechnix.com/how-to-use-pbcopy-and-pbpaste-commands-on-linux/
alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

