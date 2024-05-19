typeset -U path PATH

# set PATH so it includes user's private bin if it exists
if [ -d ~/bin ]; then
    path=(~/bin $path)
fi

# set PATH so it includes user's private bin if it exists
if [ -d ~/.local/bin ]; then
    path=(~/.local/bin $path)
fi

export PATH
