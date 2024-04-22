# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# history file
HISTFILE="$ZDOTDIR/.zhistory"    # history filepath
HISTSIZE=10000                   # maximum events for internal history
SAVEHIST=10000                   # maximum events in history file

# environment variables
EDITOR="vim"
VISUAL="vim"

# command completion
autoload -Uz compinit
compinit

zstyle ':completion:*' menu select                  # enable arrow keys
zstyle ':completion::complete:*' gain-privileges 1  # enable for sudo cmds

# enable vi mode
bindkey -v

# plugins

# autosuggestions
source $XDG_DATA_HOME/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

# syntax highlighting
source $XDG_DATA_HOME/zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# p10k promtp
source $XDG_DATA_HOME/zsh/powerlevel10k/powerlevel10k.zsh-theme

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh
