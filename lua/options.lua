-- [[ Setting options ]]
-- See `:help vim.opt`
--  For more options, you can see `:help option-list`

-- Neovim virtual env
vim.g.python3_host_prog = vim.fn.expand '$HOME' .. '/Projects/.virtualenvs/neovim/bin/python3'
-- package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?/init.lua'
-- package.path = package.path .. ';' .. vim.fn.expand '$HOME' .. '/.luarocks/share/lua/5.1/?.lua'

-- security
vim.opt.modelines = 0

-- Disable startup message
vim.opt.shortmess:append 'sI'

-- Save undo history between sessions
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath 'data' .. '/undo'

-- Absolutely not.
vim.opt.errorbells = false

-- hide buffers, not close them
vim.opt.hidden = true

-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
vim.opt.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- [[ Visuals ]]
vim.opt.ruler = true --- show the cursor position all the times
vim.opt.colorcolumn = '100' --- get a nice visualization where lw=100
vim.opt.conceallevel = 0 --- so that i can see `` in markdown files
vim.opt.number = true -- Make line numbers default
vim.opt.relativenumber = true -- relative line numbers, to help with jumping
vim.opt.cursorline = true -- Show which line your cursor is on
vim.opt.showmatch = true -- show matching brackets/parenthesis
-- Syntax highlighting
vim.opt.termguicolors = true
vim.opt.synmaxcol = 512
-- Only show signcolumn if necessary (e.g. git-gutter), max-width of two
vim.opt.signcolumn = 'auto:2'
-- Don't show the mode, since it's already in the status line
vim.opt.showmode = false
-- split style
vim.opt.fillchars = { vert = '▒' }
vim.opt.splitbelow = true
vim.opt.splitright = true

-- [[ Spacing and wrapping ]]
-- default no line wrapping
vim.opt.wrap = false
-- Enable break indent
vim.opt.breakindent = true
-- use indents of 2
vim.opt.shiftwidth = 2
-- tabs are tabs
vim.opt.expandtab = false
-- an indentation every 2 columns
vim.opt.tabstop = 2
-- let backspace delete indent
vim.opt.softtabstop = 2
-- enable auto indentation
vim.opt.autoindent = true

-- Enable mouse mode, can be useful for resizing splits for example!
vim.opt.mouse = 'a'

-- Remove modelines for security reasons
vim.opt.modelines = 0

-- Sync clipboard between OS and Neovim.
--  Schedule the setting after `UiEnter` because it can increase startup-time.
--  Remove this option if you want your OS clipboard to remain independent.
--  See `:help 'clipboard'`
vim.schedule(function()
  vim.opt.clipboard = 'unnamedplus'
end)

-- Decrease update time
vim.opt.updatetime = 250

-- Decrease mapped sequence wait time
vim.opt.timeoutlen = 300

-- Configure how new splits should be opened
vim.opt.splitright = true
vim.opt.splitbelow = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.opt.scrolloff = 10

-- make backspace behave in a sane manner
vim.opt.backspace = 'indent,eol,start'

-- [[ Searching ]]
-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term,
-- and adjust case for completion matching if necessary.
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true
vim.opt.hlsearch = true
vim.opt.incsearch = false

-- Preview substitutions live, as you type!
vim.opt.inccommand = 'split'

-- fuzzy find
vim.opt.path:append '**'
-- lazy file name tab completion
vim.opt.wildmode = 'list:longest,list:full'
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
-- ignore files vim doesnt use
vim.opt.wildignore:append '.git,.hg,.svn'
vim.opt.wildignore:append '.aux,*.out,*.toc'
vim.opt.wildignore:append '.o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class'
-- note that image.nvim can see certain images, so might want to change this
vim.opt.wildignore:append '.ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp'
vim.opt.wildignore:append '.avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg'
vim.opt.wildignore:append '.mp3,*.oga,*.ogg,*.wav,*.flac'
vim.opt.wildignore:append '.eot,*.otf,*.ttf,*.woff'
vim.opt.wildignore:append '.doc,*.pdf,*.cbr,*.cbz'
vim.opt.wildignore:append '.zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb'
vim.opt.wildignore:append '.swp,.lock,.DS_Store,._*'
vim.opt.wildignore:append '.,..'

-- [[ Custom Tabline ]]
local noname = '[unnamed]'

local function extract_filename(win)
  local b = vim.api.nvim_win_get_buf(win)
  local fullname = vim.api.nvim_buf_get_name(b)
  local mod = vim.api.nvim_buf_get_option(b, 'modified') and '◈ ' or ''
  if fullname ~= '' then
    local shortname = vim.fn.fnamemodify(fullname, ':~:.:gs%(.?[^/])[^/]*/%\1/%')
    if #shortname > 30 then
      shortname = vim.fn.fnamemodify(fullname, ':t')
    end
    return mod .. shortname
  end
end

local function get_best_window_filename(tabpage, window)
  local filename = extract_filename(window)
  if filename == nil then
    local wins = vim.api.nvim_tabpage_list_wins(tabpage)
    if #wins > 1 then
      for _, win in ipairs(wins) do
        filename = extract_filename(win)
        break
      end
    end
  end
  if filename == nil then
    return noname
  end
  return filename
end

local function is_float_win(win)
  local config = vim.api.nvim_win_get_config(win)
  return config.zindex and config.zindex > 0
end

local function getname(tabpage)
  -- vim.F.npcall(vim.api.nvim_tabpage_get_var, tabpage, "tab_title")
  local title = vim.t[tabpage].tab_title
  if title ~= nil then
    return title
  end

  local window = vim.api.nvim_tabpage_get_win(tabpage)
  -- don't replace the last filename-buffer w/ floating windows
  if is_float_win(window) then
    return vim.t[tabpage].last_buffer_filename
  end

  local filename = get_best_window_filename(tabpage, window)
  vim.t[tabpage].last_buffer_filename = filename
  return filename
end

function Tabline()
  local tl = {}
  local current = vim.api.nvim_get_current_tabpage()
  for i, tabpage in ipairs(vim.api.nvim_list_tabpages()) do
    local hi = tabpage == current and '%#TabLineSel#' or '%#TabLine#'
    local hiSep = tabpage == current and '%#TabLineSelSep#' or '%#TabLineSep#'
    table.insert(tl, '%' .. i .. 'T') -- mouse click target region
    table.insert(tl, hi .. ' ' .. getname(tabpage) .. ' ')
    table.insert(tl, hiSep .. '▓▒░ ' .. hi)
  end
  table.insert(tl, '%T') -- end mouse click region(s).
  table.insert(tl, '%#TabLineFill#')
  return table.concat(tl, '')
end

vim.opt.tabline = [[%!v:lua.Tabline()]]
