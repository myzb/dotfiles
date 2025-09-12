# dotfiles

## Requirements
```
pacman -S stow git
````

## Installing
```
git clone https://github.com/myzb/dotfiles.git
cd dotfiles
stow -t ~/ .
```
### alacritty
```
pacman -S alacritty
```

### zsh
```
pacman -S zsh zoxide fzf man
```

### tmux
```
pacman -S tmux
```

### neovim
```
pacman -S neovim ttf-jetbrains-mono-nerd fd ripgrep npm tree-sitter-cli
```

#### Setup

Treesitter parsers
```
:TSInstall lua vim vimdoc c markdown markdown_inline rst make cmake
```
Language servers
```
:MasonInstall lua-language-server cmake-language-server clangd
```
