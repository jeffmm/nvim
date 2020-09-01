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
    autocmd BufNewFile,BufRead *.md setlocal spell
augroup END

" Highlight search results only while searching
augroup vimrc-incsearch-highlight
    autocmd!
    autocmd CmdlineEnter /,\? :set hlsearch
    autocmd CmdlineLeave /,\? :set nohlsearch
augroup END

" Transparent editing of gpg encrypted files.
augroup auto_encrypt
    au!
    " First make sure nothing is written to ~/.viminfo while editing
    " an encrypted file.
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc set viminfo=
    " We don't want a swap file, as it writes unencrypted data to disk
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc set noswapfile
    " Switch to binary mode to read the encrypted file
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc set bin
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc let ch_save = &ch|set ch=2
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc let shsave=&sh
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc let &sh='sh'
    autocmd BufReadPre,FileReadPre      *.gpg,*.asc let ch_save = &ch|set ch=2
    autocmd BufReadPost,FileReadPost    *.gpg,*.asc '[,']!gpg --decrypt --default-recipient-self 2> /dev/null
    autocmd BufReadPost,FileReadPost    *.gpg,*.asc let &sh=shsave
    " Switch to normal mode for editing
    autocmd BufReadPost,FileReadPost    *.gpg,*.asc set nobin
    autocmd BufReadPost,FileReadPost    *.gpg,*.asc let &ch = ch_save|unlet ch_save
    autocmd BufReadPost,FileReadPost    *.gpg,*.asc execute ":doautocmd BufReadPost " . expand("%:r")
    " Convert all text to encrypted text before writing
    autocmd BufWritePre,FileWritePre    *.gpg,*.asc set bin
    autocmd BufWritePre,FileWritePre    *.gpg,*.asc let shsave=&sh
    autocmd BufWritePre,FileWritePre    *.gpg,*.asc let &sh='sh'
    autocmd BufWritePre,FileWritePre    *.gpg '[,']!gpg --encrypt --default-recipient-self 2>/dev/null
    autocmd BufWritePre,FileWritePre    *.asc '[,']!gpg --encrypt --armor --default-recipient-self 2>/dev/null
    autocmd BufWritePre,FileWritePre    *.gpg,*.asc let &sh=shsave
    " Undo the encryption so we are back in the normal text, directly
    " after the file has been written.
    autocmd BufWritePost,FileWritePost  *.gpg,*.asc silent u
    autocmd BufWritePost,FileWritePost  *.gpg,*.asc set nobin
augroup END
