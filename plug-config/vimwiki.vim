" VimWiki
  let g:vimwiki_key_mappings =
    \ {
    \   'all_maps': 1,
    \   'global': 0,
    \   'headers': 0,
    \   'text_objs': 0,
    \   'table_format': 0,
    \   'table_mappings': 0,
    \   'lists': 0,
    \   'links': 1,
    \   'html': 0,
    \   'mouse': 0,
    \ }


let s:vimwiki_notebook_dir = "~/.vim/wiki/notebook"
nmap <Plug>NoVimwikiPrevLink <Plug>VimwikiPrevLink 
nmap <Plug>NoVimwikiNextLink <Plug>VimwikiNextLink 
" Filetypes enabled for
let g:vimwiki_filetypes = ['markdown']

let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': s:vimwiki_notebook_dir, 
            \ 'links_space_char': '-',
            \ 'template_path': s:vimwiki_notebook_dir . "/templates/",
            \ 'template_default': 'default',
            \ 'path_html': s:vimwiki_notebook_dir . "site_html",
            \ 'html_filename_parameterization': 1,
            \ 'custom_wiki2html': 'vimwiki_markdown',
            \ 'template_ext': '.tpl',
            \ 'syntax': 'markdown',
            \ 'ext': '.md',
            \ 'markdown_link_ext': 1,
            \ 'auto_generate_links': 1,
            \ 'exclude_files': ['**/*.md.asc'],
            \ },
            \ {'path': '~/.vim/wiki/journal',
            \ 'links_space_char': '_',
            \ 'syntax': 'markdown',
            \ 'exclude_files': ['**/*.md.asc'],
            \ 'ext': '.md.asc'}]

let g:zettel_default_mappings = 0

let g:zettel_options = [{"front_matter" : [["tags", ""]],
   \ "template" :  "~/.config/nvim/zk-template.tpl"}, {}]
"
let g:zettel_date_format = "%Y%m%d"

function s:strip_extension(param)
    return split(a:param, "\\.md")[0]
endfunction
let g:zettel_format = s:strip_extension("%title")

let g:zettel_link_format="[%title](%link.md)"

" For quickly searching old notes / creating a new note
let g:nv_search_paths = ['~/.vim/wiki/notebook']


" function! zettel#vimwiki#escape_filename(name)
  " let name = substitute(a:name, "[%.%,%?%!%:]", "", "g") " remove unwanted characters
  " let schar = vimwiki#vars#get_wikilocal('links_space_char') " ' ' by default
  " let name = substitute(name, " ", schar, "g") " change spaces to link_space_char

  " let name = tolower(name)
  " return fnameescape(name)
" endfunction


function! VimwikiLinkHandler(link)
    if vimwiki#vars#get_wikilocal('ext') ==# '.md.asc'
        return 0
    endif
    let filename = a:link
    let link_info = vimwiki#base#resolve_link(filename)
    " First check that the scheme is an inter-wiki file
    if link_info.scheme ==# 'wiki0'
        if empty(glob(link_info.filename)) 
            let title = s:strip_extension(filename)
            let name = zettel#vimwiki#new_zettel_name(title)
            " prepare_template_variables needs the file saved on disk
            execute "w"
            " make variables that will be available in the new page template
            let variables = zettel#vimwiki#prepare_template_variables(expand("%"), title)
            " replace the visually selected text with a link to the new zettel
            call zettel#vimwiki#zettel_new(title, variables)
            return 1
        endif
    endif
    return 0
endfunction

function! VimwikiNewNote()
    execute "VimwikiIndex 1"
    let title = input("New note name: ", "" . strftime("%Y%m%d%H%M"))
    execute "ZettelNew " . title
    "expand("=strftime(\"%Y%m%d%H%M\")")
endfunction

command! ZettelCreateNew call VimwikiNewNote()
"
" Search for note that link to current note
command! NVBacklinks :execute "NV (" . expand("%:t") . ")"
" Search note tags, which is any word surrounded by colons (vimwiki style tags)
command! NVTags :execute "NV :[a-zA-Z0-9]+:"
" Avoid lines with no words in the search results
command! NVSearchText :execute "NV [a-zA-Z0-9]+"

"Config for markdown files
function! s:link_file_handler(lines) abort
    if a:lines == [] || a:lines == [''] || a:lines == ['', '']
        call feedkeys('a', 'n')
        return
    endif
    let filename = split(a:lines[1], "\\.md")[0]
    let link = "[" . filename . "](" . a:lines[1] . ")"
    let @* = link
    silent! let @* = link
    silent! let @+ = link
    call feedkeys('pa', 'n')
endfunction

command! -nargs=* -bang NVInsertLink
      \ call fzf#vim#files('~/.vim/wiki/notebook', 
          \ fzf#vim#with_preview({
              \ 'sink*': function('s:link_file_handler'),
              \ 'source': join([
                   \ 'rg',
                   \ '--files',
                   \ '--follow',
                   \ '--smart-case',
                   \ '--line-number',
                   \ '--color never',
                   \ '--no-messages',
                   \ ]),
              \ 'down': '40%',
              \ },<bang>0))

autocmd BufNewFile,BufRead *.md inoremap <buffer> [] <ESC>:NVInsertLink!<CR>
command! -bang -nargs=? -complete=dir NoteFiles
    \ call fzf#vim#files(vimwiki_notebook_dir, fzf#vim#with_preview({'options': ['--layout=reverse', '--info=inline']}), <bang>0)


autocmd BufReadPre *.md :call s:vimwiki_sync_pull()
autocmd BufWritePost *.md :call s:vimwiki_sync_push()

function! s:vimwiki_sync_pull() abort
    if expand("%:p:h") ==# fnamemodify(s:vimwiki_notebook_dir, ":p:h")
        silent! execute "!git -C " . s:vimwiki_notebook_dir . " pull origin master &"
    endif
endfunction

function! s:vimwiki_sync_push() abort
    if expand("%:p:h") ==# fnamemodify(s:vimwiki_notebook_dir, ":p:h")
        silent! execute "!git -C " . s:vimwiki_notebook_dir . " add ."
        silent! execute "!git -C " . s:vimwiki_notebook_dir . " commit -m 'vimwiki autocommit' > /dev/null"
        silent! execute "!git -C " . s:vimwiki_notebook_dir . " push origin master > /dev/null &"
    endif
endfunction

" :cd %:p:h
" silent! !git pull > /dev/null
" :e!
" autocmd! BufWritePost * silent! !git add .;git commit -m "vim autocommit" > /dev/null; git push > /dev/null&
