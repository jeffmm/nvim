-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Neovim virtual env
vim.g.python3_host_prog = vim.fn.expand("$HOME") .. "/Projects/.virtualenvs/neovim/bin/python3"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua"
package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua"

-- security
vim.opt.modelines = 0

-- set leader key to space
vim.g.mapleader = " "

-- hide buffers, not close them
vim.opt.hidden = true

-- maintain undo history between sessions
vim.opt.swapfile = false
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("data") .. "/undo"
vim.opt.errorbells = false

-- visuals
vim.opt.ruler = true --- Show the cursor position all the times
vim.opt.colorcolumn = "100" --- Get a nice visualization where lw=100
vim.opt.conceallevel = 0 --- So that I can see `` in markdown files

-- scroll bounds
vim.o.scrolloff = 13

-- ipad scrolling
vim.opt.mouse = "a"

-- fuzzy find
vim.opt.path:append("**")
-- lazy file name tab completion
vim.opt.wildmode = "list:longest,list:full"
vim.opt.wildmenu = true
vim.opt.wildignorecase = true
-- ignore files vim doesnt use
vim.opt.wildignore:append(".git,.hg,.svn")
vim.opt.wildignore:append(".aux,*.out,*.toc")
vim.opt.wildignore:append(".o,*.obj,*.exe,*.dll,*.manifest,*.rbc,*.class")
-- note that image.nvim can see certain images, so might want to change this
vim.opt.wildignore:append(".ai,*.bmp,*.gif,*.ico,*.jpg,*.jpeg,*.png,*.psd,*.webp")
vim.opt.wildignore:append(".avi,*.divx,*.mp4,*.webm,*.mov,*.m2ts,*.mkv,*.vob,*.mpg,*.mpeg")
vim.opt.wildignore:append(".mp3,*.oga,*.ogg,*.wav,*.flac")
vim.opt.wildignore:append(".eot,*.otf,*.ttf,*.woff")
vim.opt.wildignore:append(".doc,*.pdf,*.cbr,*.cbz")
vim.opt.wildignore:append(".zip,*.tar.gz,*.tar.bz2,*.rar,*.tar.xz,*.kgb")
vim.opt.wildignore:append(".swp,.lock,.DS_Store,._*")
vim.opt.wildignore:append(".,..")

-- case insensitive search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.infercase = true

-- make backspace behave in a sane manner
vim.opt.backspace = "indent,eol,start"

-- searching
vim.opt.hlsearch = true
vim.opt.incsearch = false

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

-- show matching brackets/parenthesis
vim.opt.showmatch = true

-- disable startup message
vim.opt.shortmess:append("sI")

-- cmd display (set to zero to autohide)
vim.opt.cmdheight = 1

-- gutter sizing
vim.opt.signcolumn = "auto:2"

-- syntax highlighting
vim.opt.termguicolors = true
vim.opt.synmaxcol = 512

-- show line numbers
vim.opt.number = true

-- default no line wrapping
vim.opt.wrap = false

-- set indents when wrapped
vim.opt.breakindent = true

-- highlight cursor
vim.opt.cursorline = true
-- set cursorcolumn = true

-- show invisibles
vim.opt.listchars = { tab = "  ", trail = "·", extends = "»", precedes = "«", nbsp = "░" }
vim.opt.list = true

-- split style
vim.opt.fillchars = { vert = "▒" }
vim.opt.splitbelow = true
vim.opt.splitright = true

-- custom tabline
local noname = "[unnamed]"

local function extract_filename(win)
  local b = vim.api.nvim_win_get_buf(win)
  local fullname = vim.api.nvim_buf_get_name(b)
  local mod = vim.api.nvim_buf_get_option(b, "modified") and "◈ " or ""
  if fullname ~= "" then
    local shortname = vim.fn.fnamemodify(fullname, ":~:.:gs%(.?[^/])[^/]*/%\1/%")
    if #shortname > 30 then
      shortname = vim.fn.fnamemodify(fullname, ":t")
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
    local hi = tabpage == current and "%#TabLineSel#" or "%#TabLine#"
    local hiSep = tabpage == current and "%#TabLineSelSep#" or "%#TabLineSep#"
    table.insert(tl, "%" .. i .. "T") -- mouse click target region
    table.insert(tl, hi .. " " .. getname(tabpage) .. " ")
    table.insert(tl, hiSep .. "▓▒░ " .. hi)
  end
  table.insert(tl, "%T") -- end mouse click region(s).
  table.insert(tl, "%#TabLineFill#")
  return table.concat(tl, "")
end

vim.opt.tabline = [[%!v:lua.Tabline()]]
