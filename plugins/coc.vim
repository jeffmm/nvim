"
" COC SETTINGS
" 
let g:coc_global_extensions = [
   \ 'coc-snippets',
   \ 'coc-actions',
   \ 'coc-sh',
   \ 'coc-lists',
   \ 'coc-emoji',
   \ 'coc-eslint',
   \ 'coc-prettier',
   \ 'coc-tsserver',
   \ 'coc-tslint',
   \ 'coc-tslint-plugin',
   \ 'coc-css',
   \ 'coc-cssmodules',
   \ 'coc-html',
   \ 'coc-json',
   \ 'coc-pyright',
   \ 'coc-yaml',
   \ 'coc-java',
   \ 'coc-go',
   \ 'coc-sourcekit',
   \ 'coc-stylelint',
   \ 'coc-styled-components',
   \ 'coc-vimlsp',
   \ 'coc-explorer',
   \ 'coc-xml',
   \ 'coc-highlight',
   \ 'coc-yank'
   \ ]
"
" Better display for messages
set cmdheight=2
" Smaller updatetime for CursorHold & CursorHoldI
set updatetime=300
" don't give |ins-completion-menu| messages.
set shortmess+=c
" always show signcolumns
set signcolumn=yes

map <silent> <leader>k :call <SID>show_documentation()<CR>

" Use leader-k for show documentation in preview window
function! s:show_documentation()
 if &filetype == 'vim'
   execute 'h '.expand('<cword>')
 else
   call CocAction('doHover')
 endif
endfunction

" Use tab and shift-tab to navigate autocompletion tolower
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
inoremap <expr> <cr> coc#pum#visible() ? coc#pum#confirm() : "\<CR>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 30,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 30,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }

" Use tab for trigger completion with characters ahead and navigate.
" inoremap <silent><expr> <TAB>
     " \ pumvisible() ? "\<C-n>" :
     " \ <SID>check_back_space() ? "\<TAB>" :
     " \ coc#refresh()
" inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

" function! s:check_back_space() abort
 " let col = col('.') - 1
 " return !col || getline('.')[col - 1]  =~# '\s'
" endfunction

" Fix for broken isort-on-save
au BufWritePre *.py :silent call CocAction('runCommand', 'editor.action.organizeImport')

""" SNIPPETS """
" Use <C-l> for trigger snippet expand.
imap <C-l> <Plug>(coc-snippets-expand)

" Use <C-j> for select text for visual placeholder of snippet.
vmap <C-x> <Plug>(coc-snippets-select)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'

" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'

" Use <C-j> for both expand and jump (make expand higher priority.)
" imap <C-j> <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
