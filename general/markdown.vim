
"Turn spellcheck on for markdown files
augroup auto_spellcheck
   autocmd!
   autocmd BufNewFile,BufRead *.md setlocal spell wrap linebreak
   autocmd BufNewFile,BufRead *.md nnoremap <buffer> j gj
   autocmd BufNewFile,BufRead *.md nnoremap <buffer> k gk
   autocmd BufNewFile,BufRead *.md xnoremap <buffer> j gj
   autocmd BufNewFile,BufRead *.md xnoremap <buffer> k gk
augroup END
