" Leader Key Maps

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'
" set timeoutlen=100

" Coc Search & refactor
nnoremap <leader>? :CocSearch <C-R>=expand("<cword>")<CR><CR>
let g:which_key_map['?'] = 'search word'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
let g:which_key_map['c'] = [ ':call Comment()'                    , 'comment' ]
let g:which_key_map['.'] = [ ':e $MYVIMRC'                        , 'open init' ]
let g:which_key_map[';'] = [ ':Commands'                          , 'commands' ]
let g:which_key_map['='] = [ '<C-W>='                             , 'balance windows' ]
" let g:which_key_map['d'] = [ '"=strftime("## %Y%m%d %A")<CR>P'    , 'insert date']
let g:which_key_map['e'] = [ ':CocCommand explorer'               , 'explorer' ]
" let g:which_key_map['f'] = [ ':Farr'                              , 'find and replace' ]
let g:which_key_map['h'] = [ '<C-W>s'                             , 'split below']
" let g:which_key_map['k'] = [ ':call <SID>show_documentation()<CR>'    , 'show documentation']
let g:which_key_map['m'] = [ ':call WindowSwap#EasyWindowSwap()'  , 'move window' ]
let g:which_key_map['p'] = [ ':Files'                             , 'search files' ]
let g:which_key_map['q'] = [ 'q'                                  , 'quit' ]
" let g:which_key_map['r'] = [ ':RnvimrToggle'                      , 'ranger' 
let g:which_key_map['u'] = [ ':UndotreeToggle'                    , 'undo tree']
let g:which_key_map['Z'] = [ 'Goyo'                               , 'zen' ]

" Group mappings

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ 'l' : [':Bracey'                 , 'start live server'],
      \ 'L' : [':BraceyStop'             , 'stop live server'],
      \ 'm' : [':MarkdownPreview'        , 'markdown preview'],
      \ 'M' : [':MarkdownPreviewStop'    , 'markdown preview stop'],
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 's' : [':let @/ = ""'            , 'remove search highlight'],
      \ 't' : [':FloatermToggle'         , 'terminal'],
      \ 'v' : [':Codi'                   , 'virtual repl on'],
      \ 'V' : [':Codi!'                  , 'virtual repl off'],
      \ 'w' : [':StripWhitespace'        , 'strip whitespace'],
      \ 'd' : ['']
      \ }

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1'],
      \ '2' : ['b2'        , 'buffer 2'],
      \ 'd' : [':Bdelete'  , 'delete-buffer'],
      \ 'f' : ['bfirst'    , 'first-buffer'],
      \ 'h' : ['Startify'  , 'home-buffer'],
      \ 'l' : ['blast'     , 'last-buffer'],
      \ 'n' : ['bnext'     , 'next-buffer'],
      \ 'p' : ['bprevious' , 'previous-buffer'],
      \ '?' : ['Buffers'   , 'fzf-buffer'],
      \ }

" f is for find and replace
let g:which_key_map.f = {
      \ 'name' : '+find&replace' ,
      \ 'b' : [':Farr --source=vimgrep'    , 'buffer'],
      \ 'p' : [':Farr --source=rgnvim'     , 'project'],
      \ }

:command! InsertDate :normal "=strftime("## %Y%m%d %A")<CR>P
:command! DocstringFull :normal o"""Short docstring<CR><CR>Extended Docstring<CR><CR>Args:<CR>var1 (type): Input variable<CR><Enter><C-D>Returns:<CR>(type): Returned variable<CR><CR><C-D>"""<ESC>
:command! DocstringShort :normal o""""""<ESC>hhi
let g:which_key_map.d = {
    \ 'name' : '+docstrings' ,
    \ 't'    : [':InsertDate', 'insert date'],
    \ 'f'    : [':DocstringFull' , 'insert full docstring'],
    \ 's'    : [':DocstringShort', 'insert short docstring'],
    \ }
"
" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'              , 'history'],
      \ ';' : [':Commands'              , 'commands'],
      \ 'a' : [':Ag'                    , 'text Ag'],
      \ 'b' : [':BLines'                , 'current buffer'],
      \ 'B' : [':Buffers'               , 'open buffers'],
      \ 'c' : [':Commits'               , 'commits'],
      \ 'C' : [':BCommits'              , 'buffer commits'],
      \ 'f' : [':Files'                 , 'files'],
      \ 'g' : [':GFiles'                , 'git files'],
      \ 'G' : [':GFiles?'               , 'modified git files'],
      \ 'h' : [':History'               , 'file history'],
      \ 'H' : [':History:'              , 'command history'],
      \ 'l' : [':Lines'                 , 'lines'] ,
      \ 'm' : [':Marks'                 , 'marks'] ,
      \ 'M' : [':Maps'                  , 'normal maps'] ,
      \ 'p' : [':Helptags'              , 'help tags'] ,
      \ 'P' : [':Tags'                  , 'project tags'],
      \ 's' : [':CocList snippets'      , 'snippets'],
      \ 'S' : [':Colors'                , 'color schemes'],
      \ 't' : [':Rg'                    , 'text Rg'],
      \ 'T' : [':BTags'                 , 'buffer tags'],
      \ 'w' : [':Windows'               , 'search windows'],
      \ 'y' : [':Filetypes'             , 'file types'],
      \ 'z' : [':FZF'                   , 'FZF'],
      \ }
      " \ 's' : [':Snippets'     , 'snippets'],

let g:which_key_map.S = {
      \ 'name' : '+Session' ,
      \ 'c' : [':SClose'          , 'Close Session']  ,
      \ 'd' : [':SDelete'         , 'Delete Session'] ,
      \ 'l' : [':SLoad'           , 'Load Session']     ,
      \ 's' : [':Startify'        , 'Start Page']     ,
      \ 'S' : [':SSave'           , 'Save Session']   ,
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git' ,
      \ 'a' : [':Git add .'                        , 'add all'],
      \ 'A' : [':Git add %'                        , 'add current'],
      \ 'b' : [':Git blame'                        , 'blame'],
      \ 'B' : [':GBrowse'                          , 'browse'],
      \ 'c' : [':Git commit'                       , 'commit'],
      \ 'd' : [':Git diff'                         , 'diff'],
      \ 'D' : [':Gdiffsplit'                       , 'diff split'],
      \ 'g' : [':GGrep'                            , 'git grep'],
      \ 'G' : [':Gstatus'                          , 'status'],
      \ 'h' : [':GitGutterLineHighlightsToggle'    , 'highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'      , 'preview hunk'],
      \ 'i' : [':Gist -b'                          , 'post gist'],
      \ 'j' : ['<Plug>(GitGutterNextHunk)'         , 'next hunk'],
      \ 'k' : ['<Plug>(GitGutterPrevHunk)'         , 'prev hunk'],
      \ 'l' : [':Git log'                          , 'log'],
      \ 'm' : ['<Plug>(git-messenger)'             , 'message'],
      \ 'p' : [':Git push'                         , 'push'],
      \ 'P' : [':Git pull'                         , 'pull'],
      \ 'r' : [':GRemove'                          , 'remove'],
      \ 's' : ['<Plug>(GitGutterStageHunk)'        , 'stage hunk'],
      \ 'S' : [':!git status'                      , 'status'],
      \ 't' : [':GitGutterSignsToggle'             , 'toggle signs'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'         , 'undo hunk'],
      \ 'v' : [':GV'                               , 'view commits'],
      \ 'V' : [':GV!'                              , 'view buffer commits'],
      \ }

let g:which_key_map.G = {
      \ 'name' : '+gist' ,
      \ 'a' : [':Gist -a'                          , 'post gist anon'],
      \ 'b' : [':Gist -b'                          , 'post gist browser'],
      \ 'd' : [':Gist -d'                          , 'delete gist'],
      \ 'e' : [':Gist -e'                          , 'edit gist'],
      \ 'l' : [':Gist -l'                          , 'list public gists'],
      \ 's' : [':Gist -ls'                         , 'list starred gists'],
      \ 'm' : [':Gist -m'                          , 'post gist all buffers'],
      \ 'p' : [':Gist -P'                          , 'post public gist '],
      \ 'P' : [':Gist -p'                          , 'post private gist '],
      \ }

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'k' : [':call <SID>show_documentation()<CR>' , 'show documentation'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : [':CocList -I symbols'                 , 'references'],
      \ 'S' : [':CocList snippets'                   , 'snippets'],
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'x' : ['<Plug>(coc-convert-snippet)'         , 'convert snippet'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }

" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ 'f' : [':FloatermNew fzf'                               , 'fzf'],
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'd' : [':FloatermNew lazydocker'                        , 'docker'],
      \ 'n' : [':FloatermNew node'                              , 'node'],
      \ 'N' : [':FloatermNew nnn'                               , 'nnn'],
      \ 'p' : [':FloatermNew python'                            , 'python'],
      \ 'm' : [':FloatermNew lazynpm'                           , 'npm'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ 't' : [':FloatermToggle'                                , 'toggle'],
      \ 'y' : [':FloatermNew ytop'                              , 'ytop'],
      \ 's' : [':FloatermNew ncdu'                              , 'ncdu'],
      \ }

" T is for terminal
let g:which_key_map.T = {
      \ 'name' : '+tabline' ,
      \ 'b' : [':XTabListBuffers'         , 'list buffers'],
      \ 'd' : [':XTabCloseBuffer'         , 'close buffer'],
      \ 'D' : [':XTabDeleteTab'           , 'close tab'],
      \ 'h' : [':XTabHideBuffer'          , 'hide buffer'],
      \ 'i' : [':XTabInfo'                , 'info'],
      \ 'l' : [':XTabLock'                , 'lock tab'],
      \ 'm' : [':XTabMode'                , 'toggle mode'],
      \ 'n' : [':tabNext'                 , 'next tab'],
      \ 'N' : [':XTabMoveBufferNext'      , 'buffer->'],
      \ 't' : [':tabnew'                  , 'new tab'],
      \ 'p' : [':tabprevious'             , 'prev tab'],
      \ 'P' : [':XTabMoveBufferPrev'      , '<-buffer'],
      \ 'x' : [':XTabPinBuffer'           , 'pin buffer'],
      \ }

" w is for managing splits
" let g:which_key_map.w =  {
      " \ 'v' : [ '<C-w>v'                             , 'split vertical'],
      " \ 's' : [ '<C-w>s'                             , 'split horizontal'],
      " \ 'n' : [ '<C-w>n'                             , 'horizontal split to new file'],
      " \ 'l' : [ '<C-w>l'                             , 'move right'],
      " \ 'h' : [ '<C-w>h'                             , 'move left'],
      " \ 'k' : [ '<C-w>k'                             , 'move up'],
      " \ 'j' : [ '<C-w>j'                             , 'move down'],
      " \ 'J' : [ '<C-w>J'                             , 'move split to bottom'],
      " \ 'K' : [ '<C-w>K'                             , 'move split to top'],
      " \ 'H' : [ '<C-w>H'                             , 'move split to left'],
      " \ 'L' : [ '<C-w>L'                             , 'move split to right'],
      " \ 'q' : [ '<C-w>q'                             , 'close split'],
      " \ }

" w is for wiki
let g:which_key_map.w = {
      \ 'name' : '+wiki' ,
      \ 'w' : [':VimRoamIndex', 'notebook index'],
      \ 'J' : [':VimRoamIndex 2', 'journal index'],
      \ 'n' : [':VimRoamNewNote', 'new wiki note'],
      \ 'i' : [':VimRoamCheckLinks', 'wiki inbox'],
      \ 's' : [':VimRoamRgText', 'search wiki text'],
      \ 't' : [':VimRoamRgTags', 'search tags'],
      \ 'f' : [':VimRoamRgFiles', 'search files'],
      \ 'b' : [':VimRoamRgBacklinks' , 'list backlinks'],
      \ 'p' : [':MarkdownPreview', 'markdown preview'],
      \ 'y' : [':VimRoamYankName', 'yank wiki link'],
      \ 'R' : [':VimRoamRenameFile', 'rename note'],
      \ 'D' : [':VimRoamDeleteFile', 'delete note'],
      \ }

" Global
" <Plug>VimRoamIndex
" <Plug>VimRoamTabIndex
" <Plug>VimRoamUISelect
" <Plug>VimRoamDiaryIndex
" <Plug>VimRoamMakeDiaryNote
" <Plug>VimRoamTabMakeDiaryNote
" <Plug>VimRoamMakeYesterdayDiaryNote
" <Plug>VimRoamMakeTomorrowDiaryNote
"
" " Local
" <Plug>VimRoam2HTML
" <Plug>VimRoam2HTMLBrowse
" <Plug>VimRoamDiaryGenerateLinks
" <Plug>VimRoamFollowLink
" <Plug>VimRoamSplitLink
" <Plug>VimRoamVSplitLink
" <Plug>VimRoamTabnewLink
" <Plug>VimRoamGoBackLink
" <Plug>VimRoamNextLink
" <Plug>VimRoamPrevLink
" <Plug>VimRoamGoto
" <Plug>VimRoamDeleteLink
" <Plug>VimRoamRenameLink
" <Plug>VimRoamAddHeaderLevel

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
