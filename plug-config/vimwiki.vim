" VimWiki
let s:vimroam_dir = "~/.vim/vimroam/"
let s:vimroam_note_dir = s:vimroam_dir . "/wiki"
let s:vimroam_journal_dir = "~/.vim/journal"

" Filetypes enabled for
let g:vimroam_list = [{'path': s:vimroam_note_dir},
            \ {'path': s:vimroam_journal_dir, 'ext': '.md.asc'}]

function! s:vimroam_sync_pull(path) abort
    if expand("%:p:h") ==# fnamemodify(a:path, ":p:h")
        let s:git_pull_update = system("!git -C " . fnamemodify(a:path, ":p:h") . " pull origin master 2> /dev/null | wc -l")
        :echo s:git_pull_update
        if s:git_pull_update > 1
            :edit
        endif
    endif
endfunction

autocmd BufReadPre *.md call s:vimroam_sync_pull(s:vimroam_note_dir)"
" autocmd BufWritePost *.md :call s:vimroam_sync_push(s:vimroam_note_dir)
" autocmd BufReadPre *.md.asc :call s:vimroam_sync_pull(s:vimroam_journal_dir)
" autocmd BufWritePost *.md.asc :call s:vimroam_sync_push(s:vimroam_journal_dir)

function! s:vimroam_sync_push(path) abort
    if expand("%:p:h") ==# fnamemodify(a:path, ":p:h")
        silent! execute "!git -C " . a:path . " add ."
        silent! execute "!git -C " . a:path . " commit -m 'vimroam autocommit' > /dev/null"
        silent! execute "!git -C " . a:path . " push origin master > /dev/null &"
    endif
endfunction
