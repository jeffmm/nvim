#!/bin/bash

set -o nounset    # error when referencing undefined variable
# set -o errexit    # exit when command fails

installreqmac() { \
  brew install ripgrep fzf ranger || echo "dependencies installed"
}

installreqdeb() { \
  $SUDO apt-get update -y && $SUDO apt-get install -y curl git ranger
  # Try to install each of these, and if missing, install with conda if it exists
  $SUDO apt-get install -y fzf 
  $SUDO apt-get install -y ripgrep
  if [ $(command -v conda) ]; then
      [ $(command -v fzf) ] || conda install -c conda-forge fzf
      [ $(command -v ripgrep) ] || conda install -c conda-forge ripgrep
  fi
  [ ! -f /etc/timezone ] && $SUDO echo America/Denver >> /etc/timezone
}

installreqs() { \
  [ "$(uname)" == "Darwin" ] && installreqmac
  [ $(command -v apt-get) ] && installreqdeb
}

installnodemac() { \
  brew install lua node yarn || echo "node dependencies installed"
}

installnodedeb() { \
  if $(command -v sudo); then
    curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
  else
    curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
  fi
  $SUDO apt-get install -y nodejs
}

installcocextensions() { \
  # Install extensions
  mkdir -p ~/.config/coc/extensions
  cd ~/.config/coc/extensions
  [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
  # Change extension names to the extensions you need
  if [ "$(uname)" == "Darwin" ]; then
    npm install coc-explorer coc-snippets coc-json coc-actions bash-language-server \
           --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  else
    $SUDO npm install coc-explorer coc-snippets coc-json coc-actions bash-language-server \
           --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
  fi
}

installnode() { \
  echo "Installing node..."
  [ "$(uname)" == "Darwin" ] && installnodemac
  [ $(command -v apt-get) ] && installnodedeb
  if [ "$(uname)" == "Darwin" ]; then
    npm i -g neovim
  else
    $SUDO npm i -g neovim
  fi
}

installpipmac() { \
  $SUDO curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
  python3 get-pip.py
  rm get-pip.py
}

installpipdeb() { \
  $SUDO apt-get install -y python3-pip > /dev/null
}

installpip() { \
  echo "Installing pip..."
  [ "$(uname)" == "Darwin" ] && installpipmac
  [ $(command -v apt-get) ] && installpipdeb
}

installpippackages() { \
  echo "Installing pip packages..."
  pip3 install --upgrade pip
  pip3 install black flake8 isort pynvim
}

cloneconfig() { \
  echo "Cloning Vim configuration"
  git clone --depth=1 https://github.com/jeffmm/nvim.git ~/.config/nvim
}

moveoldnvim() { \
  echo "Moving your config to nvim.old"
  mv $HOME/.config/nvim $HOME/.config/nvim.old
}

moveoldcoc() { \
  echo "Moving your coc to coc.old"
  mv $HOME/.config/coc $HOME/.config/coc.old
}

installplugins() { \
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/init.vim.tmp
  mv $HOME/.config/nvim/scripts/init.vim $HOME/.config/nvim/init.vim
  echo "Installing plugins..."
  nvim --headless +PlugInstall +qall > /dev/null 2>&1
  mv $HOME/.config/nvim/init.vim $HOME/.config/nvim/scripts/init.vim
  mv $HOME/.config/nvim/init.vim.tmp $HOME/.config/nvim/init.vim
}

installnvimsource() { \
  # Build from source
  $SUDO apt-get install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
  git clone -b stable https://github.com/neovim/neovim
  cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
  $SUDO make install && cd .. && rm -rf neovim
}

installnvimdeb() { \
  if [ $(dpkg --print-architecture | grep "amd") ]; then
    # Try building from appimage
    curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
    chmod u+x nvim.appimage
    ./nvim.appimage --appimage-extract \
        && $SUDO mv -f squashfs-root /usr/local/src/nvim \
        || installnvimsource
    [ -f /usr/local/src/nvim/AppRun ] && ln -s /usr/local/src/nvim/AppRun /usr/local/bin/nvim
    rm -rf ./nvim.appimage
  else
    installnvimsource
  fi
}

installnvimmac() { \
  brew install neovim || echo "neovim installed"
}

installnvim() { \
  echo "Installing Neovim..."
  [ "$(uname)" == "Darwin" ] && installnvimmac
  [ $(command -v apt-get) ] && installnvimdeb
}

installfontdeb() { \
  # mkdir -p ~/.local/share/fonts
  # cd ~/.local/share/fonts && curl -fLo "Droid Sans Mono for Powerline Nerd Font Complete.otf" https://github.com/ryanoasis/nerd-fonts/raw/HEAD/patched-fonts/DroidSansMono/complete/Droid%20Sans%20Mono%20Nerd%20Font%20Complete.otf
  $SUDO apt-get install -y fonts-hack-ttf
}

installfontmac() { \
  brew install --cask font-hack-nerd-font || echo "font installed"
}

installfont() { \
  echo "Installing font..."
  [ "$(uname)" == "Darwin" ] && installfontmac
  [ $(command -v apt-get) ] && installfontdeb
}

# Welcome
echo "Installing Vim environment"

[ ! "$(uname)" == "Darwin" ] && [ ! $(command -v apt-get) ] && echo "OS not supported" && exit

if [ $(command -v sudo) ]; then
    SUDO=sudo
else
    SUDO=""
fi

installreqs

# install pip
[ $(command -v pip3) ] && echo "pip installed, moving on..." || installpip

# install node and neovim support
[ $(command -v node) ] && echo "node installed, moving on..." || installnode

# install pynvim
installpippackages

# move old nvim directory if it exists
[ -d "$HOME/.config/nvim" ] && moveoldnvim

# move old nvim directory if it exists
[ -d "$HOME/.config/coc" ] && moveoldcoc

# clone config down
cloneconfig

# install neovim
echo "Checking for neovim"
[ $(command -v nvim) ] && echo "neovim installed, moving on..." || installnvim

# install plugins
installplugins

# install CoC extensions
installcocextensions

# echo "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"
installfont

# echo "I also recommend you add 'set preview_images_method ueberzug' to ~/.config/ranger/rc.conf"
# [ $(command -v apt-get) ] && mkdir -p ~/.config/ranger && echo "set preview_images_method ueberzug" >> ~/.config/ranger/rc.conf
