# Vim configuration

Vim environment and configuration using neovim, based on the config by [ChristianChiarulli](https://github.com/ChristianChiarulli/nvim).

## Easy install

The following will install this config if you have an existing config it will move it to `~/.config/nvim.old`

This script only supports Mac, Ubuntu and Arch

```
bash <(curl -s https://raw.githubusercontent.com/jeffmm/nvim/master/utils/install.sh)
```

## Manual install

### Install Neovim

- On Mac

  ```
  brew install neovim
  ```

- Ubuntu

  ```
  sudo apt install neovim
  ```

### Clone this repo to your config folder

```
git clone https://github.com/jeffmm/nvim.git ~/.config/nvim
```

### Install python & node support

```
pip install pynvim
npm i -g neovim
```

### Install neovim-remote

This will install `nvr` to `~/.local/bin` so you will need to add the following to your `bashrc` or `zshrc`

```
pip install neovim-remote
export PATH=$HOME/.local/bin:$PATH
```

### Install clipboard support

- On mac pbcopy should be builtin

- On Ubuntu

  ```
  sudo apt install xsel
  ```

### Install python & node support using virtual environments

Make sure to add these paths somewhere in your config

```
let g:python3_host_prog = expand("<path to python with pynvim installed>")
let g:node_host_prog = expand("<path to node with neovim installed>")
```

### List of useful programs you should install

- ranger
- ueberzug (if not on mac)
- ripgrep
- the_silver_searcher
- fd
- universal-ctags
- lazygit
- lazydocker

Explanations and installation instruction can be found on my blog

### FAR config
```
:UpdateRemotePlugins
```

### Gists config

To use **vim-gists** you will need to configure the following:

```
git config --global github.user <username>
```
