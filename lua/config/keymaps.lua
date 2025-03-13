-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here
-- delete lazy keymaps

-- better up/down
-- map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })
-- map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
-- map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
-- vim.keymap.del("n", "<C-h>") -- "<C-w>h", { desc = "Go to left window", remap = true })
-- vim.keymap.del("n", "<C-j>") -- "<C-w>j", { desc = "Go to lower window", remap = true })
-- vim.keymap.del("n", "<C-k>") -- "<C-w>k", { desc = "Go to upper window", remap = true })
-- vim.keymap.del("n", "<C-l>") -- "<C-w>l", { desc = "Go to right window", remap = true })
--
-- Resize window using <ctrl> arrow keys
-- vim.keymap.del("n", "<C-Up>") -- "<cmd>resize +2<cr>", { desc = "Increase window height" })
-- vim.keymap.del("n", "<C-Down>") -- "<cmd>resize -2<cr>", { desc = "Decrease window height" })
-- vim.keymap.del("n", "<C-Left>") -- "<cmd>vertical resize -2<cr>", { desc = "Decrease window width" })
-- vim.keymap.del("n", "<C-Right>") -- "<cmd>vertical resize +2<cr>", { desc = "Increase window width" })
--
-- Move Lines
-- vim.keymap.del("n", "<A-j>") -- "<cmd>m .+1<cr>==", { desc = "Move down" })
-- vim.keymap.del("n", "<A-k>") -- "<cmd>m .-2<cr>==", { desc = "Move up" })
-- vim.keymap.del("i", "<A-j>") -- "<esc><cmd>m .+1<cr>==gi", { desc = "Move down" })
-- vim.keymap.del("i", "<A-k>") -- "<esc><cmd>m .-2<cr>==gi", { desc = "Move up" })
-- vim.keymap.del("v", "<A-j>") -- ":m '>+1<cr>gv=gv", { desc = "Move down" })
-- vim.keymap.del("v", "<A-k>") -- ":m '<-2<cr>gv=gv", { desc = "Move up" })
--
-- buffers
-- vim.keymap.del("n", "<S-h>") -- "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- vim.keymap.del("n", "<S-l>") -- "<cmd>bnext<cr>", { desc = "Next buffer" })
-- vim.keymap.del("n", "[b") -- "<cmd>bprevious<cr>", { desc = "Prev buffer" })
-- vim.keymap.del("n", "]b") -- "<cmd>bnext<cr>", { desc = "Next buffer" })
-- vim.keymap.del("n", "<leader>bb") -- "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- vim.keymap.del("n", "<leader>`") -- "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
--
-- Clear search with <esc>
-- map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- map(
--   "n",
--   "<leader>ur",
--   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--   { desc = "Redraw / clear hlsearch / diff update" }
-- )

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next search result" })
-- map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next search result" })
-- map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev search result" })
-- map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
-- map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev search result" })
--
-- Add undo break-points
-- map("i", ",", ",<c-g>u")
-- map("i", ".", ".<c-g>u")
-- map("i", ";", ";<c-g>u")

-- save file
-- map({ "i", "x", "n", "s" }, "<C-s>", "<cmd>w<cr><esc>", { desc = "Save file" })

--keywordprg
-- map("n", "<leader>K", "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
-- map("v", "<", "<gv")
-- map("v", ">", ">gv")

-- lazy
-- map("n", "<leader>l", "<cmd>lazy<cr>", { desc = "lazy" })
-- unmap("n", "<leader>l") -- "<cmd>lazy<cr>", { desc = "lazy" })

-- new file
-- map("n", "<leader>fn", "<cmd>enew<cr>", { desc = "New File" })

-- map("n", "<leader>xl", "<cmd>lopen<cr>", { desc = "Location List" })
-- map("n", "<leader>xq", "<cmd>copen<cr>", { desc = "Quickfix List" })

-- map("n", "[q", vim.cmd.cprev, { desc = "Previous quickfix" })
-- map("n", "]q", vim.cmd.cnext, { desc = "Next quickfix" })

-- formatting
-- map({ "n", "v" }, "<leader>cf", function()
--   Util.format({ force = true })
-- end, { desc = "Format" })

-- diagnostic
-- local diagnostic_goto = function(next, severity)
--   local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
--   severity = severity and vim.diagnostic.severity[severity] or nil
--   return function()
--     go({ severity = severity })
--   end
-- end
-- map("n", "<leader>cd", vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- map("n", "]d", diagnostic_goto(true), { desc = "Next Diagnostic" })
-- map("n", "[d", diagnostic_goto(false), { desc = "Prev Diagnostic" })
-- map("n", "]e", diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- map("n", "[e", diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
-- map("n", "]w", diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
-- map("n", "[w", diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
-- map("n", "<leader>uf", function() Util.format.toggle() end, { desc = "Toggle auto format (global)" })
-- map("n", "<leader>uF", function() Util.format.toggle(true) end, { desc = "Toggle auto format (buffer)" })
-- map("n", "<leader>us", function() Util.toggle("spell") end, { desc = "Toggle Spelling" })
-- map("n", "<leader>uw", function() Util.toggle("wrap") end, { desc = "Toggle Word Wrap" })
-- map("n", "<leader>uL", function() Util.toggle("relativenumber") end, { desc = "Toggle Relative Line Numbers" })
-- map("n", "<leader>ul", function() Util.toggle.number() end, { desc = "Toggle Line Numbers" })
-- map("n", "<leader>ud", function() Util.toggle.diagnostics() end, { desc = "Toggle Diagnostics" })
-- local conceallevel = vim.o.conceallevel > 0 and vim.o.conceallevel or 3
-- map("n", "<leader>uc", function() Util.toggle("conceallevel", false, {0, conceallevel}) end, { desc = "Toggle Conceal" })
-- if vim.lsp.buf.inlay_hint or vim.lsp.inlay_hint then
--   map( "n", "<leader>uh", function() Util.toggle.inlay_hints() end, { desc = "Toggle Inlay Hints" })
-- end
-- map("n", "<leader>uT", function() if vim.b.ts_highlight then vim.treesitter.stop() else vim.treesitter.start() end end, { desc = "Toggle Treesitter Highlight" })

-- lazygit
-- vim.keymap.del("n", "<leader>gg") --, function() Util.terminal({ "lazygit" }, { cwd = Util.root(), esc_esc = false, ctrl_hjkl = false }) end, { desc = "Lazygit (root dir)" })
-- vim.keymap.del("n", "<leader>gG") -- , function() Util.terminal({ "lazygit" }, {esc_esc = false, ctrl_hjkl = false}) end, { desc = "Lazygit (cwd)" })
--
-- quit
-- map("n", "<leader>qq", "<cmd>qa<cr>", { desc = "Quit all" })

-- highlights under cursor
-- map("n", "<leader>ui", vim.show_pos, { desc = "Inspect Pos" })

-- LazyVim Changelog
-- map("n", "<leader>L", function() Util.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
-- local lazyterm = function() Util.terminal(nil, { cwd = Util.root() }) end
-- map("n", "<leader>ft", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<leader>fT", function() Util.terminal() end, { desc = "Terminal (cwd)" })
-- map("n", "<c-/>", lazyterm, { desc = "Terminal (root dir)" })
-- map("n", "<c-_>", lazyterm, { desc = "which_key_ignore" })

-- Terminal Mappings
-- map("t", "<esc><esc>", "<c-\\><c-n>", { desc = "Enter Normal Mode" })
-- map("t", "<C-h>", "<cmd>wincmd h<cr>", { desc = "Go to left window" })
-- map("t", "<C-j>", "<cmd>wincmd j<cr>", { desc = "Go to lower window" })
-- map("t", "<C-k>", "<cmd>wincmd k<cr>", { desc = "Go to upper window" })
-- map("t", "<C-l>", "<cmd>wincmd l<cr>", { desc = "Go to right window" })
-- map("t", "<C-/>", "<cmd>close<cr>", { desc = "Hide Terminal" })
-- map("t", "<c-_>", "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
-- vim.keymap.del("n", "<leader>wd") -- "<C-W>c", { desc = "Delete window", remap = true })
-- vim.keymap.del("n", "<leader>ww") -- "<C-W>p", { desc = "Other window", remap = true })
-- vim.keymap.del("n", "<leader>w-") -- "<C-W>s", { desc = "Split window below", remap = true })
-- vim.keymap.del("n", "<leader>w|") -- "<C-W>v", { desc = "Split window right", remap = true })
-- vim.keymap.del("n", "<leader>-") --"<C-W>s", { desc = "Split window below", remap = true })
-- vim.keymap.del("n", "<leader>|") --"<C-W>v", { desc = "Split window right", remap = true })

-- tabs
-- map("n", "<leader><tab>l", "<cmd>tablast<cr>", { desc = "Last Tab" })
-- map("n", "<leader><tab>f", "<cmd>tabfirst<cr>", { desc = "First Tab" })
-- map("n", "<leader><tab><tab>", "<cmd>tabnew<cr>", { desc = "New Tab" })
-- map("n", "<leader><tab>]", "<cmd>tabnext<cr>", { desc = "Next Tab" })
-- map("n", "<leader><tab>d", "<cmd>tabclose<cr>", { desc = "Close Tab" })
-- map("n", "<leader><tab>[", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- buffers
-- vim.keymap.set("n", "<c-n>", ":bn<cr>", { desc = "next buffer" })
-- vim.keymap.set("n", "<c-p>", ":bp<cr>", { desc = "prev buffer" })
-- vim.keymap.set("n", "<c-x>", ":bd<cr>", { desc = "exit buffer" })

-- vim.keymap.set("n", "J", "10gj")
-- vim.keymap.set("n", "K", "10gk")
-- vim.keymap.set("v", "J", "10gj")
-- vim.keymap.set("v", "K", "10gk")

-- remove highlighting
-- vim.keymap.set("n", "<esc><esc>", ":nohlsearch<cr>", { desc = "remove highlighting", silent = true })

-- vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "scroll down" })
-- vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "scroll up" })

-- focus highlight searches
-- vim.keymap.set("n", "n", "nzzzv", { desc = "next match" })
-- vim.keymap.set("n", "N", "Nzzzv", { desc = "prev match" })
--
--
--
-- This file is automatically loaded by lazyvim.config.init

-- DO NOT USE `LazyVim.safe_keymap_set` IN YOUR OWN CONFIG!!
-- use `vim.keymap.set` instead
-- local map = LazyVim.safe_keymap_set
local unmap = vim.keymap.del
local map = vim.keymap.set

-- better up/down
-- unmap({ "n", "x" }, "j")      -- "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- unmap({ "n", "x" }, "<Down>") -- "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
-- unmap({ "n", "x" }, "k")      -- "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
-- unmap({ "n", "x" }, "<Up>")   -- "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using the <ctrl> hjkl keys
unmap("n", "<C-h>") -- , "<C-w>h", { desc = "Go to Left Window", remap = true })
unmap("n", "<C-j>") -- , "<C-w>j", { desc = "Go to Lower Window", remap = true })
unmap("n", "<C-k>") -- , "<C-w>k", { desc = "Go to Upper Window", remap = true })
unmap("n", "<C-l>") -- , "<C-w>l", { desc = "Go to Right Window", remap = true })

-- Resize window using <ctrl> arrow keys
unmap("n", "<C-Up>")    --, "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
unmap("n", "<C-Down>")  -- , "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
unmap("n", "<C-Left>")  -- , "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
unmap("n", "<C-Right>") -- , "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- Move Lines
unmap("n", "<A-j>") --, "<cmd>execute 'move .+' . v:count1<cr>==", { desc = "Move Down" })
unmap("n", "<A-k>") -- , "<cmd>execute 'move .-' . (v:count1 + 1)<cr>==", { desc = "Move Up" })
unmap("i", "<A-j>") -- , "<esc><cmd>m .+1<cr>==gi", { desc = "Move Down" })
unmap("i", "<A-k>") -- , "<esc><cmd>m .-2<cr>==gi", { desc = "Move Up" })
unmap("v", "<A-j>") -- , ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
unmap("v", "<A-k>") -- , ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- buffers
unmap("n", "<S-h>")      -- , "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
unmap("n", "<S-l>")      -- , "<cmd>bnext<cr>", { desc = "Next Buffer" })
unmap("n", "[b")         -- , "<cmd>bprevious<cr>", { desc = "Prev Buffer" })
unmap("n", "]b")         -- , "<cmd>bnext<cr>", { desc = "Next Buffer" })
unmap("n", "<leader>bb") -- , "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
unmap("n", "<leader>`")  -- , "<cmd>e #<cr>", { desc = "Switch to Other Buffer" })
-- unmap("n", "<leader>bd") -- , function()
-- Snacks.bufdelete()
-- end, { desc = "Delete Buffer" })
unmap("n", "<leader>bo") -- , function()
-- Snacks.bufdelete.other()
-- end, { desc = "Delete Other Buffers" })
unmap("n", "<leader>bD") -- , "<cmd>:bd<cr>", { desc = "Delete Buffer and Window" })

-- Clear search with <esc>
-- unmap({ "i", "n" }, "<esc>") -- "<cmd>noh<cr><esc>", { desc = "Escape and Clear hlsearch" })

-- Clear search, diff update and redraw
-- taken from runtime/lua/_editor.lua
-- unmap("n", "<leader>ur")
--   "<Cmd>nohlsearch<Bar>diffupdate<Bar>normal! <C-L><CR>",
--   { desc = "Redraw / Clear hlsearch / Diff Update" }
-- )

-- https://github.com/mhinz/vim-galore#saner-behavior-of-n-and-n
-- unmap("n", "n") -- , "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" })
-- unmap("x", "n") -- , "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- unmap("o", "n") -- , "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" })
-- unmap("n", "N") -- , "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" })
-- unmap("x", "N") -- , "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })
-- unmap("o", "N") -- , "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" })

-- Add undo break-points
unmap("i", ",") -- , ",<c-g>u")
unmap("i", ".") -- , ".<c-g>u")
unmap("i", ";") -- , ";<c-g>u")

-- save file
unmap({ "i", "x", "n", "s" }, "<C-s>") -- , "<cmd>w<cr><esc>", { desc = "Save File" })

--keywordprg
-- unmap("n", "<leader>K") -- , "<cmd>norm! K<cr>", { desc = "Keywordprg" })

-- better indenting
-- unmap("v", "<") -- , "<gv")
-- unmap("v", ">") -- , ">gv")

-- commenting
unmap({"n", "x", "o"}, "gc") -- , "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
unmap("n", "gcc") -- , "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
unmap("n", "gco") -- , "o<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Below" })
unmap("n", "gcO") -- , "O<esc>Vcx<esc><cmd>normal gcc<cr>fxa<bs>", { desc = "Add Comment Above" })

-- lazy
unmap("n", "<leader>l")  -- "<cmd>Lazy<cr>", { desc = "Lazy" })
map("n", "<leader>L", "<cmd>Lazy<cr>", { desc = "Lazy" })


-- new file
-- unmap("n", "<leader>fn") -- , "<cmd>enew<cr>", { desc = "New File" })

-- unmap("n", "<leader>xl") -- , "<cmd>lopen<cr>", { desc = "Location List" })
-- unmap("n", "<leader>xq") -- , "<cmd>copen<cr>", { desc = "Quickfix List" })

-- unmap("n", "[q")         -- , vim.cmd.cprev, { desc = "Previous Quickfix" })
-- unmap("n", "]q")         -- , vim.cmd.cnext, { desc = "Next Quickfix" })

-- formatting
-- unmap({ "n", "v" }, "<leader>cf") -- , function()
--   LazyVim.format({ force = true })
-- end, { desc = "Format" })

-- diagnostic
local diagnostic_goto = function(next, severity)
	local go = next and vim.diagnostic.goto_next or vim.diagnostic.goto_prev
	severity = severity and vim.diagnostic.severity[severity] or nil
	return function()
		go({ severity = severity })
	end
end
-- unmap("n", "<leader>cd") -- , vim.diagnostic.open_float, { desc = "Line Diagnostics" })
-- unmap("n", "]d")         -- , diagnostic_goto(true), { desc = "Next Diagnostic" })
-- unmap("n", "[d")         -- , diagnostic_goto(false), { desc = "Prev Diagnostic" })
-- unmap("n", "]e")         -- , diagnostic_goto(true, "ERROR"), { desc = "Next Error" })
-- unmap("n", "[e")         -- , diagnostic_goto(false, "ERROR"), { desc = "Prev Error" })
-- unmap("n", "]w")         -- , diagnostic_goto(true, "WARN"), { desc = "Next Warning" })
-- unmap("n", "[w")         -- , diagnostic_goto(false, "WARN"), { desc = "Prev Warning" })

-- stylua: ignore start

-- toggle options
-- LazyVim.format.snacks_toggle():map("<leader>uf")
-- LazyVim.format.snacks_toggle(true):map("<leader>uF")
-- Snacks.toggle.option("spell", { name = "Spelling"}):map("<leader>us")
-- Snacks.toggle.option("wrap", {name = "Wrap"}):map("<leader>uw")
-- Snacks.toggle.option("relativenumber", { name = "Relative Number"}):map("<leader>uL")
-- Snacks.toggle.diagnostics():map("<leader>ud")
-- Snacks.toggle.line_number():map("<leader>ul")
-- Snacks.toggle.option("conceallevel", {off = 0, on = vim.o.conceallevel > 0 and vim.o.conceallevel or 2, name = "Conceal Level"}):map("<leader>uc")
-- Snacks.toggle.option("showtabline", {off = 0, on = vim.o.showtabline > 0 and vim.o.showtabline or 2, name = "Tabline"}):map("<leader>uA")
-- Snacks.toggle.treesitter():map("<leader>uT")
-- Snacks.toggle.option("background", { off = "light", on = "dark" , name = "Dark Background"}):map("<leader>ub")
-- if vim.lsp.inlay_hint then
--   Snacks.toggle.inlay_hints():map("<leader>uh")
-- end
--
-- lazygit
-- if vim.fn.executable("lazygit") == 1 then
	-- unmap("n", "<leader>gg") -- , function() Snacks.lazygit( { cwd = LazyVim.root.git() }) end, { desc = "Lazygit (Root Dir)" })
	-- unmap("n", "<leader>gG") -- , function() Snacks.lazygit() end, { desc = "Lazygit (cwd)" })
	-- unmap("n", "<leader>gf") -- , function() Snacks.lazygit.log_file() end, { desc = "Lazygit Current File History" })
	-- unmap("n", "<leader>gl") -- , function() Snacks.lazygit.log({ cwd = LazyVim.root.git() }) end, { desc = "Lazygit Log" })
	-- unmap("n", "<leader>gL") -- , function() Snacks.lazygit.log() end, { desc = "Lazygit Log (cwd)" })
-- end

-- unmap("n", "<leader>gb")          -- , function() Snacks.git.blame_line() end, { desc = "Git Blame Line" })
-- unmap({ "n", "x" }, "<leader>gB") -- , function() Snacks.gitbrowse() end, { desc = "Git Browse (open)" })
-- unmap({ "n", "x" }, "<leader>gY") -- , function()
--   Snacks.gitbrowse({ open = function(url) vim.fn.setreg("+", url) end, notify = false })
-- end, { desc = "Git Browse (copy)" })
--
-- quit
unmap("n", "<leader>qq") -- , "<cmd>qa<cr>", { desc = "Quit All" })

-- highlights under cursor
-- unmap("n", "<leader>ui") -- , vim.show_pos, { desc = "Inspect Pos" })
-- unmap("n", "<leader>uI") -- , "<cmd>InspectTree<cr>", { desc = "Inspect Tree" })

-- LazyVim Changelog
unmap("n", "<leader>L") -- , function() LazyVim.news.changelog() end, { desc = "LazyVim Changelog" })

-- floating terminal
-- unmap("n", "<leader>fT") -- , function() Snacks.terminal() end, { desc = "Terminal (cwd)" })
-- unmap("n", "<leader>ft") -- , function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- unmap("n", "<c-/>")      -- ,      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "Terminal (Root Dir)" })
-- unmap("n", "<c-_>")      -- ,      function() Snacks.terminal(nil, { cwd = LazyVim.root() }) end, { desc = "which_key_ignore" })

-- Terminal Mappings
-- unmap("t", "<C-/>") -- , "<cmd>close<cr>", { desc = "Hide Terminal" })
-- unmap("t", "<c-_>") -- , "<cmd>close<cr>", { desc = "which_key_ignore" })

-- windows
unmap("n", "<leader>-")  -- , "<C-W>s", { desc = "Split Window Below", remap = true })
unmap("n", "<leader>|")  -- , "<C-W>v", { desc = "Split Window Right", remap = true })
unmap("n", "<leader>wd") -- , "<C-W>c", { desc = "Delete Window", remap = true })
-- LazyVim.ui.maximize():map("<leader>wm")

-- tabs
unmap("n", "<leader><tab>l")     -- , "<cmd>tablast<cr>", { desc = "Last Tab" })
unmap("n", "<leader><tab>o")     -- , "<cmd>tabonly<cr>", { desc = "Close Other Tabs" })
unmap("n", "<leader><tab>f")     -- , "<cmd>tabfirst<cr>", { desc = "First Tab" })
unmap("n", "<leader><tab><tab>") -- , "<cmd>tabnew<cr>", { desc = "New Tab" })
unmap("n", "<leader><tab>]")     -- , "<cmd>tabnext<cr>", { desc = "Next Tab" })
unmap("n", "<leader><tab>d")     -- , "<cmd>tabclose<cr>", { desc = "Close Tab" })
unmap("n", "<leader><tab>[")     -- , "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- native snippets. only needed on < 0.11, as 0.11 creates these by default
-- if vim.fn.has("nvim-0.11") == 0 then
	-- unmap("s", "<Tab>") -- , function()
	-- return vim.snippet.active({ direction = 1 }) and "<cmd>lua vim.snippet.jump(1)<cr>" or "<Tab>"
	-- end, { expr = true, desc = "Jump Next" })
	-- unmap({ "i", "s" }, "<S-Tab>") -- , function()
	--   return vim.snippet.active({ direction = -1 }) and "<cmd>lua vim.snippet.jump(-1)<cr>" or "<S-Tab>"
	-- end, { expr = true, desc = "Jump Previous" })
-- end


map("n", "<C-h>", "^")
map("n", "<C-l>", "$")
map("v", "<C-h>", "^")
map("v", "<C-l>", "$")

-- the worst place in the universe
map("n", "Q", "<nop>")

-- move to text buffer
map("n", "<TAB>", ":bnext<CR>", { silent = true })
map("n", "<S-TAB>", ":bprevious<CR>", { silent = true })

-- better indenting
map("v", "<", "<gv")
map("v", ">", ">gv")

-- move blocks
map("v", "J", ":m '>+1<CR>gv=gv", { desc = "move block up" })
map("v", "K", ":m '<-2<CR>gv=gv", { desc = "move block down" })
-- scrolling
map("n", "<C-j>", "<C-d>", { desc = "scroll down" })
map("n", "<C-k>", "<C-u>", { desc = "scroll up" })
map("v", "<C-j>", "<C-d>", { desc = "scroll down" })
map("v", "<C-k>", "<C-u>", { desc = "scroll up" })
