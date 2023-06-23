"
" WIKI SETTINGS
let g:wiki_root = '~/.vim/wiki'
let g:wiki_filetypes = ['md']
let g:wiki_link_extension = '.md'"
let g:wiki_global_load = 0
let g:wiki_link_target_type = 'md'

" Function for creating link url
function WikiMapLink(text) abort
    return substitute(tolower(a:text), '\s\+', '-', 'g')
endfunction
let g:wiki_map_link_create = 'WikiMapLink'

let g:wiki_templates = [
      \ { 'match_func': {x -> v:true},
      \   'source_filename': '/Users/jeff/.config/nvim/wiki/.template.md'},
      \]

" Functions for new note template
function! WikiPathToLink(ctx, filename) abort
    " The origin name will be given with surrounding apostrophes
    " If it's empty, don't give a backlink
    if a:filename ==# "''"
        return ""
    endif
    let l:linkname = substitute(a:filename, "'", "", "g")
    let l:linkurl = substitute(fnamemodify(l:linkname, ":p"), 
        \ fnamemodify(expand(g:wiki_root), ":p"), "", "")
    return wiki#link#template(l:linkurl, fnamemodify(expand(l:linkname), ':t'))
endfunction

function! WikiNameToTitle(ctx, text) abort
    let l:title = substitute(a:text, "-", " ", "g")
    let l:title = join(map(split(l:title), {_, x -> toupper(x[0]) . strpart(x, 1)}))
    return l:title
endfunction

function! WikiRemoveDateDashes(ctx, date) abort
    return substitute(a:date, "-", "", "g")
endfunction

let g:wiki_export = {
    \ 'args' : '',
    \ 'from_format' : 'markdown',
    \ 'ext' : 'pdf',
    \ 'link_ext_replace': v:false,
    \ 'view' : v:true,
    \ 'output': "../wiki_pdf/",
    \}


