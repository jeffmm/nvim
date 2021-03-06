" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

call plug#begin('~/.config/nvim/autoload/plugged')
  " Repeat stuff
  Plug 'tpope/vim-repeat'
  " Surround
  Plug 'tpope/vim-surround'
  " Better Comments
  Plug 'tpope/vim-commentary'
  " Have the file system follow you around
  Plug 'airblade/vim-rooter'
  " Note taking
  " Plug 'jeffmm/vimroam'
  Plug 'vimwiki/vimwiki', {'branch': 'dev'}
  Plug '~/Projects/vim-roam'
  " Plug 'michal-h21/vim-zettel'
  " Text Navigation
  Plug 'easymotion/vim-easymotion'
  " Better Syntax Support
  " let g:polyglot_disabled = ['csv']

  " Plug 'sheerun/vim-polyglot'
  " Cool Icons
  Plug 'ryanoasis/vim-devicons'
  " Auto pairs for '(' '[' '{'
  " Plug 'jiangmiao/auto-pairs'
  " Auto pairs for html/xml tags
  " Plug 'alvan/vim-closetag'
  " Themes
  Plug 'gruvbox-community/gruvbox'
  Plug 'sainnhe/gruvbox-material'
  " Intellisense
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Status line and tab line
  Plug 'vim-airline/vim-airline'
  Plug 'mg979/vim-xtabline'
  Plug 'kevinhwang91/rnvimr'
  " FZF
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Plug 'alok/notational-fzf-vim'
  " Git
  Plug 'airblade/vim-gitgutter'
  Plug 'tpope/vim-fugitive'
  Plug 'junegunn/gv.vim'
  Plug 'rhysd/git-messenger.vim'
  " Terminal
  Plug 'voldikss/vim-floaterm'
  " Start Screen
  Plug 'mhinz/vim-startify'
  " See what keys do when pressing leader
  Plug 'liuchengxu/vim-which-key'
  " Zen mode
  Plug 'junegunn/goyo.vim'
  Plug 'junegunn/limelight.vim'
  " Snippets
  Plug 'honza/vim-snippets'
  " Interactive code
  Plug 'metakirby5/codi.vim'
  " Debugging
  " Plug 'puremourning/vimspector'
  Plug 'vim-vdebug/vdebug'
  " undo time travel
  Plug 'mbbill/undotree'
  " Find and replace
  Plug 'brooth/far.vim'
  " Smooth scroll
  " Plug 'psliwka/vim-smoothie'
  " Swap windows
  Plug 'wesQ3/vim-windowswap'
  " Markdown Preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
  " Easily create Gists
  Plug 'mattn/webapi-vim'
  Plug 'mattn/vim-gist'
  " Easily delete buffers
  Plug 'moll/vim-bbye'

call plug#end()

" Automatically install missing plugins on startup
autocmd VimEnter *
  \  if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \|   PlugInstall --sync | q
  \| endif
