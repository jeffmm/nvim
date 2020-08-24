
function! Comment()
  if (mode() == "n" )
    execute "Commentary"
  else    
    execute "'<,'>Commentary"
  endif
 endfunction
vnoremap <silent> <space>c :call Comment()
xnoremap <silent> <space>c :call Comment()<CR>
nnoremap <silent> <space>c :call Comment()<CR>

" Comments for json
autocmd FileType json setlocal commentstring=\/\/\ %s
