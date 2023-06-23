# Neovim configuration

Neovim configuration and environment installation scripts.

## Easy install

The installation script supports Mac, Debian/Ubuntu, and Amazon Linux 2.

The following one-liner will install everything needed by the Neovim configuration (if you have an existing config it will be moved to `~/.config/nvim.old`)

```
bash <(curl -s https://raw.githubusercontent.com/jeffmm/nvim/master/scripts/install.sh)
```

The above script has been tested for both amd64 and arm64 architectures (warning: on arm64 architectures, neovim will be built from source, and will install the necessary dependencies for the build; this can be avoided by pre-installing neovim from your preferred source).

## Dependencies

The installation script will install the following dependencies if they are missing:

- neovim
- python3
- pip3
- nodejs (v16+)
- fzf
- ripgrep
- ranger
