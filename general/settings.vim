syntax enable                           " Enables syntax highlighing
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set noerrorbells                        " Never ever
set encoding=utf-8                      " The encoding displayed
set pumheight=10                        " Makes popup menu smaller
set fileencoding=utf-8                  " The encoding written to file
set ruler              			        " Show the cursor position all the time
set cmdheight=2                         " More space for displaying messages
set mouse=a                             " Enable your mouse
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set tabstop=4 softtabstop=4             " Insert 4 spaces for a tab
set shiftwidth=4                        " Change the number of space characters inserted for indentation
set smarttab                            " Makes tabbing smarter
set expandtab                           " Converts tabs to spaces
set smartindent                         " Makes indenting smart
set autoindent                          " Good auto indent
set laststatus=2                        " Always display the status line
set relativenumber                      " Line numbers
set cursorline                          " Enable highlighting of the current line
set background=light                    " tell vim what the background color looks like
set showtabline=2                       " Always show tabs
set nobackup                            " This is recommended by coc
set nowritebackup                       " This is recommended by coc
set noswapfile                          " No swap files
set undodir=~/.vim/undodir              " Undo directory for undotree
set undofile                            " Write an undo file for undotruee
set shortmess+=c                        " Don't pass messages to |ins-completion-menu|.
set signcolumn=yes                      " Always show the signcolumn, otherwise it would shift the text each time
set updatetime=50                       " Faster completion
set timeoutlen=100                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set incsearch                           " Allow finding search results
set nohlsearch                          " Don't highlight search results by default
set colorcolumn=88                      " Get a nice visualization where lw=88
highlight ColorColumn ctermbg=0 guibg=lightgrey
set guifont=Hack\ Nerd\ Font
set iskeyword+=-                      	" treat dash separated words as a word text object
autocmd FileType * setlocal formatoptions-=cor  " Properly wrap comments

if has('python3')
    set pyx=3
endif

"Turn spellcheck on for markdown files
augroup auto_spellcheck
   autocmd!
   autocmd BufNewFile,BufRead *.md setlocal spell wrap linebreak
   autocmd BufNewFile,BufRead *.md :CocDisable
   autocmd BufNewFile,BufRead *.md nmap j gj
   autocmd BufNewFile,BufRead *.md nmap k gk
   autocmd BufNewFile,BufRead *.md xmap j gj
   autocmd BufNewFile,BufRead *.md xmap k gk
augroup END

" Highlight search results only while searching
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END
