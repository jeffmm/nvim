-- [[ Setting options ]]
-- See `:help vim.o`
-- NOTE: You can change these options as you wish!
--  For more options, you can see `:help option-list`
-- Neovim virtual env
vim.g.python3_host_prog = vim.fn.expand("$HOME") .. "/.config/nvim/venv/neovim/bin/python3"
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
-- package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

-- Make line numbers default
vim.o.number = true
-- You can also add relative line numbers, to help with jumping.
--  Experiment for yourself to see if you like it!
vim.o.relativenumber = true

-- Enable mouse mode, can be useful for resizing splits for example!
-- Also necessary for ipad scrolling apparently.
vim.o.mouse = "a"

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

-- Set to `false` to globally disable all snacks animations
vim.g.snacks_animate = true

-- use that instead of inline suggestions
-- vim.g.ai_cmp = true

-- for detecting the LSP root
vim.g.root_lsp_ignore = { "copilot" }

vim.o.completeopt = "menu,menuone,noselect"

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.o.clipboard = "unnamedplus"
end)

-- set indents when wrapped
vim.o.breakindent = true

-- Save undo history
vim.o.undofile = true
vim.o.swapfile = false
vim.o.undodir = vim.fn.stdpath("data") .. "/undo"
vim.o.errorbells = false

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = "yes"

-- Decrease update time
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
vim.o.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.fillchars = { vert = "▒" }
vim.o.splitright = true
vim.o.splitbelow = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.oopt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.opt.list = true
vim.opt.listchars = { tab = "» ", trail = "·", extends = "»", precedes = "«", nbsp = "␣" } -- nbsp = "░" }

-- Preview substitutions live, as you type!
vim.o.inccommand = "split"

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 13

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true

-- security
vim.o.modelines = 0

-- hide buffers, not close them
vim.o.hidden = true

-- maintain undo history between sessions

-- misc visuals
vim.o.ruler = true --- Show the cursor position all the times
vim.o.colorcolumn = "100" --- Get a nice visualization where lw=100
vim.o.conceallevel = 0 --- So that I can see `` in markdown files

-- fuzzy find
-- vim.opt.path:append("**")

-- lazy file name tab completion
vim.o.wildmode = "list:longest,list:full"
vim.o.wildmenu = true
vim.o.wildignorecase = true

-- ignore files vim doesnt use
vim.opt.wildignore:append(".git,.hg,.svn")
vim.opt.wildignore:append(".aux,*.out,*.toc")
vim.opt.wildignore:append(".o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class")
vim.opt.wildignore:append(".avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg")
vim.opt.wildignore:append(".mp3,*.oga,*.ogg,*.wav,*.flac")
vim.opt.wildignore:append(".eot,*.otf,*.ttf,*.woff")
vim.opt.wildignore:append(".doc,*.pdf,*.cbr,*.cbz")
vim.opt.wildignore:append(".zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb")
vim.opt.wildignore:append(".swp,.lock,.DS_Store,._*")
vim.opt.wildignore:append(".,..")
-- note that image.nvim can see certain images, so might want to change this
-- vim.o.wildignore:append(".ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp")

-- case insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.infercase = true

-- make backspace behave in a sane manner
vim.o.backspace = "indent,eol,start"

-- searching
vim.o.hlsearch = true
vim.o.incsearch = false

-- use indents of 2
vim.o.shiftwidth = 2

-- tabs are spaces
vim.o.expandtab = true

-- an indentation every 2 columns
vim.o.tabstop = 2

-- let backspace delete indent
vim.o.softtabstop = 2

-- enable smooth scrolling
vim.o.smoothscroll = true

-- enable auto indentation
vim.o.autoindent = true

vim.o.jumpoptions = "view"
vim.o.laststatus = 3 -- global statusline
vim.o.linebreak = true -- Wrap lines at convenient points

-- show matching brackets/parenthesis
vim.o.showmatch = true

-- disable startup message
vim.opt.shortmess:append("sI")

-- cmd display (set to zero to autohide)
vim.o.cmdheight = 1

-- gutter sizing
vim.o.signcolumn = "auto:2"

vim.o.pumblend = 10 -- Popup blend
vim.o.pumheight = 10 -- Maximum number of entries in a popup

-- syntax highlighting
vim.o.termguicolors = true
vim.o.synmaxcol = 512

-- default no line wrapping
vim.o.wrap = false

-- set indents when wrapped
vim.o.breakindent = true

-- highlight cursor
vim.o.cursorline = true

-- vim: ts=2 sts=2 sw=2 et
