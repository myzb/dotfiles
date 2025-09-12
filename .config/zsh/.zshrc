# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.config/zsh/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
	source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
	test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
	alias ls='ls --color=auto'
	alias grep='grep --color=auto'
	alias fgrep='fgrep --color=auto'
	alias egrep='egrep --color=auto'
fi

# Plugin Manager
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light Aloxaf/fzf-tab
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions

# Snippets
zinit snippet OMZP::command-not-found

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

# Load completions
autoload -Uz compinit && compinit

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'				# case insensitive
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"				# ls-style autocomplete colors
zstyle ':completion:*' menu no							# will use fzf menu
zstyle ':completion::complete:*' gain-privileges 1				# enable for sudo cmds
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'		# colorize fzf-tab's preview with 'cd'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'	# colorize fzf-tab's preview with zoxide 'z'
zstyle ':fzf-tab:*' fzf-flags '--color=spinner:green,pointer:red,prompt:magenta,hl:blue' # fzf colors

# History
HISTFILE="$ZDOTDIR/.zhistory"		# history filepath
HISTSIZE=5000				# maximum events for internal history
SAVEHIST=$HISTSIZE			# maximum events in history file
HISTDUP=erase				# erase dupes
setopt appendhistory			# append instead of overwriting
setopt sharehistory			# share across session
setopt hist_ignore_space		# ignore commands with leading space
setopt hist_ignore_all_dups		# handing of duplicates
setopt hist_save_no_dups		# ...
setopt hist_ignore_dups
setopt hist_find_no_dups

# Help command
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help
alias help=run-help

# Shell integrations
eval "$(fzf --zsh)"			# fzf in zsh
eval "$(zoxide init --cmd cd zsh)"	# replace 'cd' with zoxide

# Keybinds
bindkey -e
bindkey '^p' history-search-backward
bindkey '^n' history-search-forward

# Keybinds for special keys
# see, https://wiki.archlinux.org/title/zsh#Configure_Zsh
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search

# create a zkbd compatible hash;
# to add other keys to this hash, see: man 5 terminfo
typeset -g -A key

key[Home]="${terminfo[khome]}"
key[End]="${terminfo[kend]}"
key[Insert]="${terminfo[kich1]}"
key[Backspace]="${terminfo[kbs]}"
key[Delete]="${terminfo[kdch1]}"
key[Up]="${terminfo[kcuu1]}"
key[Down]="${terminfo[kcud1]}"
key[Left]="${terminfo[kcub1]}"
key[Right]="${terminfo[kcuf1]}"
key[PageUp]="${terminfo[kpp]}"
key[PageDown]="${terminfo[knp]}"
key[Shift-Tab]="${terminfo[kcbt]}"

# setup key accordingly
[[ -n "${key[Home]}"      ]] && bindkey -- "${key[Home]}"       beginning-of-line
[[ -n "${key[End]}"       ]] && bindkey -- "${key[End]}"        end-of-line
[[ -n "${key[Insert]}"    ]] && bindkey -- "${key[Insert]}"     overwrite-mode
[[ -n "${key[Backspace]}" ]] && bindkey -- "${key[Backspace]}"  backward-delete-char
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
[[ -n "${key[Up]}"        ]] && bindkey -- "${key[Up]}"         up-line-or-beginning-search
[[ -n "${key[Down]}"      ]] && bindkey -- "${key[Down]}"       down-line-or-beginning-search
[[ -n "${key[Left]}"      ]] && bindkey -- "${key[Left]}"       backward-char
[[ -n "${key[Right]}"     ]] && bindkey -- "${key[Right]}"      forward-char
[[ -n "${key[PageUp]}"    ]] && bindkey -- "${key[PageUp]}"     beginning-of-buffer-or-history
[[ -n "${key[PageDown]}"  ]] && bindkey -- "${key[PageDown]}"   end-of-buffer-or-history
[[ -n "${key[Shift-Tab]}" ]] && bindkey -- "${key[Shift-Tab]}"  reverse-menu-complete

# Finally, make sure the terminal is in application mode, when zle is
# active. Only then are the values from $terminfo valid.
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
