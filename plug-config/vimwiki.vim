" VimWiki
  let g:vimwiki_key_mappings =
    \ {
    \   'all_maps': 1,
    \   'global': 0,
    \   'headers': 0,
    \   'text_objs': 0,
    \   'table_format': 0,
    \   'table_mappings': 0,
    \   'lists': 1,
    \   'links': 1,
    \   'html': 0,
    \   'mouse': 0,
    \ }


let s:vimwiki_dir = "~/.vim/wiki/"
let s:vimwiki_notebook_dir = s:vimwiki_dir . "/notebook"
let s:vimwiki_journal_dir = s:vimwiki_dir . "/journal"

nmap <Plug>NoVimwikiPrevLink <Plug>VimwikiPrevLink 
nmap <Plug>NoVimwikiNextLink <Plug>VimwikiNextLink 

" Filetypes enabled for
let g:vimwiki_filetypes = ['markdown']
let g:vimwiki_markdown_link_ext = 1
let g:vimwiki_global_ext = 0
let g:vimwiki_list = [{'path': s:vimwiki_notebook_dir, 
            \ 'links_space_char': '-',
            \ 'template_path': s:vimwiki_dir . "/templates",
            \ 'template_default': 'default',
            \ 'path_html': s:vimwiki_dir . "/site_html",
            \ 'html_filename_parameterization': 1,
            \ 'custom_wiki2html': 'vimwiki_markdown',
            \ 'template_ext': '.tpl',
            \ 'syntax': 'markdown',
            \ 'ext': '.md',
            \ 'markdown_link_ext': 1,
            \ 'exclude_files': ['**/*.md.asc'],
            \ },
            \ {'path': s:vimwiki_journal_dir,
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
endfunction

command! ZettelCreateNew call VimwikiNewNote()

if has('win64') || has('win32')
  let s:null_path = 'NUL'
  let s:command = ''
else
  let s:null_path = '/dev/null'
  let s:command = 'command'
endif

let s:python_executable = executable('pypy3') ? 'pypy3' : get(g:, 'python3_host_prog', 'python3')
let s:highlight_path_expr = join([s:python_executable , 
            \ '-S',expand('<sfile>:p:h:h') . '/print_lines.py' , 
            \ '{2} {1} $FZF_PREVIEW_LINES', '2>' . s:null_path,])


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


function! RgText(fullscreen, search, dir, )
  call fzf#vim#grep(
  \   'rg --column --line-number --smart-case --no-heading --color=always ' . shellescape(a:search) . ' ' . fnameescape(a:dir), 1,
  \   a:fullscreen ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'down': '40%', 'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   a:fullscreen)
endfunction


" command! -bang -nargs=* RgWikiText :call RgText(<bang>0, '[a-zA-Z0-9]', s:vimwiki_notebook_dir)
" command! -bang -nargs=* RgWikiTags :call RgText(<bang>0, ':[a-zA-Z0-9]+:', s:vimwiki_notebook_dir)

" command! NVBacklinks :execute "NV (" . expand("%:t") . ")"
" command! NVTags :execute "NV :[a-zA-Z0-9]+:"
" Search for note that link to current note
command! -nargs=* -bang RgWikiBacklinks :call RgText(<bang>0, 
            \ '(' . expand("%:t") . ')', s:vimwiki_notebook_dir)
" Search note tags, which is any word surrounded by colons (vimwiki style tags)
command! -nargs=* -bang RgWikiTags :call RgText(<bang>0,
            \ ':[a-zA-Z0-9]+:', s:vimwiki_notebook_dir)
" Search for text in wiki files
command! -nargs=* -bang RgWikiText :call RgText(<bang>0,
            \ '[a-zA-Z0-9]+', s:vimwiki_notebook_dir)
" Search for filenames in wiki
command! -nargs=* -bang RgWikiFiles :call RgFiles(<bang>0, 
            \ s:vimwiki_notebook_dir, "*.md")


command! -nargs=* -bang InsertWikiLink
      \ call fzf#vim#files(s:vimwiki_notebook_dir, 
      \ {
              \ 'sink*': function('s:link_file_handler'),
              \ 'source': join([
                   \ 'rg',
                   \ '--files',
                   \ '--follow',
                   \ '--smart-case',
                   \ '--line-number',
                   \ '--color never',
                   \ '--no-messages',
                   \ '*.md',
                   \ ]),
              \ 'down': '40%',
              \ 'options': [
                  \ '--layout=reverse', '--inline-info',
                    \ '--preview=' . 'cat {}']
              \ },<bang>0)

function! s:vimwiki_sync_pull(path) abort
    if expand("%:p:h") ==# fnamemodify(a:path, ":p:h")
        let s:git_pull_update = system("!git -C " . fnamemodify(a:path, ":p:h") . " pull origin master 2> /dev/null | wc -l")
        :echo s:git_pull_update
        if s:git_pull_update > 1
            :edit
        endif
    endif
endfunction

autocmd BufNewFile,BufRead *.md inoremap <buffer> [] <ESC>:InsertWikiLink<CR>
autocmd BufReadPre *.md call s:vimwiki_sync_pull(s:vimwiki_notebook_dir)"
" autocmd BufWritePost *.md :call s:vimwiki_sync_push(s:vimwiki_notebook_dir)
" autocmd BufReadPre *.md.asc :call s:vimwiki_sync_pull(s:vimwiki_journal_dir)
" autocmd BufWritePost *.md.asc :call s:vimwiki_sync_push(s:vimwiki_journal_dir)

function! s:vimwiki_sync_push(path) abort
    if expand("%:p:h") ==# fnamemodify(a:path, ":p:h")
        silent! execute "!git -C " . a:path . " add ."
        silent! execute "!git -C " . a:path . " commit -m 'vimwiki autocommit' > /dev/null"
        silent! execute "!git -C " . a:path . " push origin master > /dev/null &"
    endif
endfunction
