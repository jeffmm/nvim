#!/bin/bash

set -o nounset    # error when referencing undefined variable
# set -o errexit    # exit when command fails

installreqs() { \
    installreqmac() { \
        brew install ripgrep fzf
    }

    installreqdeb() { \
        [ ! -f /etc/timezone ] && $SUDO echo America/Denver >> /etc/timezone
        $SUDO apt-get update -y && $SUDO apt-get install -y curl git software-properties-common
        # Try to install fzf and rg, and if it fails install from conda if available
        $SUDO apt-get install -y fzf 
        $SUDO apt-get install -y ripgrep
        if [ "$(command -v conda)" ]; then
            [ "$(command -v fzf)" ] || conda install -c conda-forge fzf -y
            [ "$(command -v ripgrep)" ] || conda install -c conda-forge ripgrep -y
        fi
        DEBIAN_FRONTEND=noninteractive TZ="US/Mountain" $SUDO apt-get install -y tzdata
    }

    installreqamz() { \
        [ ! -f /etc/timezone ] && $SUDO echo America/Denver >> /etc/timezone
        $SUDO yum update -y && $SUDO yum install -y curl git tar wget make which perl
    }

    echo "Installing requirements..."
    case $OS in
        mac) installreqmac ;;
        deb) installreqdeb ;;
        amz) installreqamz ;;
        *) echo "unknown OS $OS" ;;
    esac
}


installnode() { \
    installnodemac() { \
        brew install lua node yarn
        # Don't install node packages with sudo on mac
        npm i -g neovim
    }

    installnodedeb() { \
        if command -v sudo &> /dev/null; then
            curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
        else
            curl -fsSL https://deb.nodesource.com/setup_16.x | bash -
        fi
        $SUDO apt-get install -y nodejs
        $SUDO npm i -g neovim
    }

    installnodeamz() { \
        if command -v sudo &> /dev/null; then
            curl -fsSL https://rpm.nodesource.com/setup_16.x | sudo -E bash -
        else
            curl -fsSL https://rpm.nodesource.com/setup_16.x | bash -
        fi
        $SUDO yum install -y nodejs
        $SUDO npm i -g neovim
    }

    echo "Installing node..."
    case $OS in
        mac) installnodemac ;;
        deb) installnodedeb ;;
        amz) installnodeamz ;;
        *) echo "unknown OS $OS" ;;
    esac
}


installcocextensions() { \
    cocinstall() { \
        npm install coc-explorer coc-snippets coc-json coc-actions bash-language-server \
                --global-style --ignore-scripts --no-bin-links --no-package-lock --only=prod
    }

    # Install extensions
    echo "Installing coc extensions..."
    mkdir -p ~/.config/coc/extensions
    cd ~/.config/coc/extensions || (echo "failed to create coc extensions dir" && return)
    [ ! -f package.json ] && echo '{"dependencies":{}}'> package.json
    # Change extension names to the extensions you need
    if [ "$OS" == "mac" ]; then
        cocinstall ""
    else
        $SUDO cocinstall
    fi
}

installpip() { \
    installpipmac() { \
        brew install python@3.11 && brew link --overwrite python@3.11
    }

    installpipdeb() { \
        $SUDO add-apt-repository -y ppa:deadsnakes/ppa
        $SUDO apt-get install -y python3.11
        curl -sS https://bootstrap.pypa.io/get-pip.py | python3.11
        $SUDO ln -s "$(which python3.11)" /usr/local/bin/python3
        $SUDO ln -s "$(which python3.11)" /usr/local/bin/python
    }

    installpipamz() { \
        $SUDO amazon-linux-extras enable python3.8
        $SUDO yum install -y python38
        curl -sS https://bootstrap.pypa.io/get-pip.py | python3.8
        $SUDO ln -s "$(which python3.8)" /usr/local/bin/python3
        $SUDO ln -s "$(which python3.8)" /usr/local/bin/python
    }

    echo "Installing pip..."
    case $OS in
        mac) installpipmac ;;
        deb) installpipdeb ;;
        amz) installpipamz ;;
        *) echo "unknown OS $OS" ;;
    esac
}

installpippackages() { \
    echo "Installing pip packages..."
    pip3 install --upgrade pip
    pip3 install --upgrade black flake8 isort neovim ranger-fm
}

cloneconfig() { \
    echo "Cloning Vim configuration"
    git clone --depth=1 https://github.com/jeffmm/nvim.git ~/.config/nvim
}

moveoldnvim() { \
    echo "Moving your current neovim config to nvim.old"
    mkdir -p "$HOME/.config/nvim.old"
    mv "$HOME/.config/nvim" "$HOME/.config/nvim.old/nvim-$(date +%Y%m%d%H%M%S)"
}

moveoldcoc() { \
    echo "Moving your current coc config to coc.old"
    mkdir -p "$HOME/.config/coc.old"
    mv "$HOME/.config/coc" "$HOME/.config/coc.old/coc-$(date +%Y%m%d%H%M%S)"
}

installplugins() { \
    mv "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/init.vim.tmp"
    mv "$HOME/.config/nvim/scripts/init.vim" "$HOME/.config/nvim/init.vim"
    echo "Installing plugins..."
    nvim --headless +PlugInstall +qall > /dev/null 2>&1
    mv "$HOME/.config/nvim/init.vim" "$HOME/.config/nvim/scripts/init.vim"
    mv "$HOME/.config/nvim/init.vim.tmp" "$HOME/.config/nvim/init.vim"
}

installnvim() { \
    installnvimsource() { \
        # Build from source
        $SUDO "$1" install -y ninja-build gettext libtool libtool-bin autoconf automake cmake g++ pkg-config unzip curl doxygen
        git clone -b stable https://github.com/neovim/neovim
        cd neovim && make CMAKE_BUILD_TYPE=RelWithDebInfo
        $SUDO make install && cd .. && rm -rf neovim
    }

    installnvimdeb() { \
        if uname -a | grep -q "aarch64"; then
            installnvimsource apt-get
        else
            # Try building from appimage
            curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
            chmod u+x nvim.appimage
            (./nvim.appimage --appimage-extract && $SUDO mv -f squashfs-root /usr/local/src/nvim ) \
                || installnvimsource
                        [ -f /usr/local/src/nvim/AppRun ] && ln -s /usr/local/src/nvim/AppRun /usr/local/bin/nvim
                        rm -rf ./nvim.appimage
        fi
    }

    installnvimmac() { \
        brew install neovim
    }


    echo "Installing Neovim..."
    case $OS in
        mac) installnvimmac ;;
        deb) installnvimdeb ;;
        amz) 
            $SUDO yum install -y cmake3
            installnvimsource yum
            ;;
        *) echo "unknown OS $OS" ;;
    esac
}

installfont() { \
    installfontdeb() { \
        $SUDO apt-get install -y fonts-hack-ttf
    }

    installfontmac() { \
        brew tap homebrew/cask-fonts
        brew install font-hack-nerd-font
    }
    echo "Installing font..."
    case "$OS" in
        mac) installfontmac ;;
        deb) installfontdeb ;;
        amz) echo "no fonts installed" ;;
        *) echo "unknown OS $OS" ;;
    esac
}

initcocsettings() { \
    # initialize coc-settings.json if it doesn't already exist
    if [ ! -f "$HOME/.config/nvim/coc-settings.json" ]; then
        cp "$HOME/.config/nvim/scripts/coc-settings-template.json" "$HOME/.config/nvim/coc-settings.json"
        perl -pi -e "s~__PYTHON3__~$(which python3)~g" "$HOME/.config/nvim/coc-settings.json"
        perl -pi -e "s~__FLAKE8__~$(which flake8)~g" "$HOME/.config/nvim/coc-settings.json"
        perl -pi -e "s~__BLACK__~$(which black)~g" "$HOME/.config/nvim/coc-settings.json"
        perl -pi -e "s~__ISORT__~$(which isort)~g" "$HOME/.config/nvim/coc-settings.json"
    fi
}


# Welcome
echo "Installing Vim environment"

# Check OS
case $(uname) in
    "Darwin")
        OS="mac"
        ;;
    "Linux")
        if grep -q "ID_LIKE=debian" /etc/os-release; then
            OS="deb"
        elif grep -q "ID=debian" /etc/os-release; then
            OS="deb"
        elif grep -q "Amazon Linux" /etc/os-release; then
            OS="amz"
        else
            echo "OS not supported"
            exit
        fi
        ;;
    *)
        echo "OS not supported"
        exit
        ;;
esac

if command -v sudo &> /dev/null; then
    SUDO=sudo
else
    SUDO=""
fi

installreqs

# install pip
if command -v pip3 &> /dev/null; then echo "pip installed, moving on..."; else installpip; fi

# install node and neovim support
if command -v npm &> /dev/null; then echo "node installed, moving on..."; else installnode; fi

# install pip packages
installpippackages

# move old nvim directory if it exists
[ -d "$HOME/.config/nvim" ] && moveoldnvim

# move old nvim directory if it exists
[ -d "$HOME/.config/coc" ] && moveoldcoc

# clone config down
cloneconfig

# install neovim
if command -v nvim &> /dev/null; then echo "neovim installed, moving on..."; else installnvim; fi

# initialize coc-settings.json if it doesn't already exist
initcocsettings

# install plugins
installplugins

# install CoC extensions
installcocextensions

# echo "I recommend you also install and activate a font from here: https://github.com/ryanoasis/nerd-fonts"
installfont
