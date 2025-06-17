#! /bin/zsh

# Script to install neovim and its dependencies on macOS.
install_neovim()
{
  echo "Installing latest release of neovim..."
  # Download and install latest release
  curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim-macos-arm64.tar.gz
  tar xzf nvim-macos-arm64.tar.gz
  mkdir -p "$HOME/.local/bin"
  rsync -av nvim-macos-arm64/* "$HOME/.local"
  if ! grep -q "\$HOME/.local/bin" "$HOME/.zshrc"; then
    echo "export PATH=\"\$HOME/.local/bin:\$PATH\"" >>"$HOME/.zshrc"
  fi
  source "$HOME/.zshrc"
  rm -rf nvim-macos-arm64 nvim-macos-arm64.tar.gz
}

source "$HOME/.zshrc"
if command -v nvim >/dev/null 2>&1; then
  # Check neovim version >= 0.11.2
  echo "Checking neovim version..."
  if nvim --version | grep -E "v0\.11\.[2-9]" >/dev/null 2>&1 || nvim --version | grep -E "v0\.1[2-9]\." >/dev/null 2>&1; then
    echo "neovim is already installed and up to date."
  else
    install_neovim
  fi
else
  install_neovim
fi
if command -v nvm >/dev/null 2>&1; then
  echo "nvm is already installed."
else
  echo "Installing nvm..."
  curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
  nvm install 22
  nvm use 22
fi
if command -v mmdc >/dev/null 2>&1; then
  echo "mmdc is already installed."
else
  echo "Installing mmdc..."
  npm install -g @mermaid-js/mermaid-cli
fi
# Check whether neovim node package is installed globally or not
if npm list -g --depth=0 | grep -q neovim; then
  echo "neovim node package is already installed."
else
  echo "Installing neovim node package..."
  npm install -g neovim
fi
# Ensure rust is installed
if command -v cargo >/dev/null 2>&1; then
  echo "rust is already installed."
else
  echo "Installing rust..."
  curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh -s -- -y
  if ! grep -q "\$HOME/.cargo/bin" "$HOME/.zshrc"; then
    echo "export PATH=\"\$HOME/.cargo/bin:\$PATH\"" >>"$HOME/.zshrc"
    source "$HOME/.zshrc"
  fi
fi
# Ensure uv is installed
if command -v uv >/dev/null 2>&1; then
  echo "uv is already installed."
else
  echo "Installing uv..."
  cargo install --git https://github.com/astral-sh/uv uv
  if ! grep -q "\$HOME/.cargo/bin" "$HOME/.zshrc"; then
    echo "export PATH=\"\$HOME/.cargo/bin:\$PATH\"" >>"$HOME/.zshrc"
    source "$HOME/.zshrc"
  fi
fi
# Ensure uv is up to date
uv tool install --upgrade uv --force
if [ ! -d "$HOME/.config/nvim/.venv" ]; then
  echo "Creating virtual environment for neovim..."
  (
    cd "$HOME/.config/nvim" || exit 1
    uv python install python3.13
    uv venv
    source .venv/bin/activate
    uv sync
  )
else
  echo "nvim python virtual environment already exists."
fi
source "$HOME/.config/nvim/.venv/bin/activate"
if uv tool list | grep -q vectorcode; then
  echo "vectorcode is already installed."
else
  echo "Installing vectorcode..."
  uv tool install vectorcode
fi
if command -v tree-sitter >/dev/null 2>&1; then
  echo "tree-sitter is already installed."
else
  echo "Installing tree-sitter..."
  cargo install --locked tree-sitter-cli
fi
if command -v brew >/dev/null 2>&1; then
  echo "Homebrew is already installed."
else
  echo "Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi
if command -v wget >/dev/null 2>&1; then
  echo "wget is already installed."
else
  echo "Installing wget..."
  brew install wget
fi
if command -v convert >/dev/null 2>&1; then
  echo "imagemagick is already installed."
else
  echo "Installing imagemagick..."
  brew install imagemagick
fi
if command -v rg >/dev/null 2>&1; then
  echo "ripgrep is already installed."
else
  echo "Installing ripgrep..."
  brew install ripgrep
fi
if command -v tectonic >/dev/null 2>&1; then
  echo "tectonic is already installed."
else
  echo "Installing tectonic..."
  brew install tectonic
fi
if command -v lua >/dev/null 2>&1; then
  echo "lua is already installed."
else
  echo "Installing lua..."
  curl -L -R -O https://www.lua.org/ftp/lua-5.1.5.tar.gz
  tar zxf lua-5.1.5.tar.gz
  (
    cd lua-5.1.5 || exit 1
    mkdir -p "$HOME/.lua"
    make macosx INSTALL_TOP="$HOME/.lua"
    make install INSTALL_TOP="$HOME/.lua"
  )
  echo "export PATH=\"\$HOME/.lua/bin:\$PATH\"" >>"$HOME/.zshrc"
  source "$HOME/.zshrc"
  rm -rf lua-5.1.5 lua-5.1.5.tar.gz
fi
if command -v luarocks >/dev/null 2>&1; then
  echo "luarocks is already installed."
else
  echo "Installing luarocks..."
  wget https://luarocks.org/releases/luarocks-3.12.0.tar.gz
  tar zxpf luarocks-3.12.0.tar.gz
  (
    mkdir -p "$HOME/.lua"
    cd luarocks-3.12.0 || exit 1
    ./configure --lua-version=5.1 --prefix="$HOME/.lua" && make && make install
  )
  export PATH="$HOME/.lua/bin:$PATH"
  if ! grep -q "\$HOME/.lua/bin" "$HOME/.zshrc"; then
    echo "export PATH=\"\$HOME/.lua/bin:\$PATH\"" >>"$HOME/.zshrc"
  fi
  source "$HOME/.zshrc"
  rm -rf luarocks-3.12.0 luarocks-3.12.0.tar.gz
fi
