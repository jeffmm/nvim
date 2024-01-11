nnoremap <silent><expr> m  :MagmaEvaluateOperator<CR>
nnoremap <silent>       mm :MagmaEvaluateLine<CR>
xnoremap <silent>       mm  :<C-u>MagmaEvaluateVisual<CR>
nnoremap <silent>       mc :MagmaReevaluateCell<CR>
nnoremap <silent>       md :MagmaDelete<CR>
nnoremap <silent>       mo :MagmaShowOutput<CR>

let g:magma_automatically_open_output = v:false
let g:magma_image_provider = "kitty"

" function! MagmaInitPython()
  " call MagmaInit(python4)
  " execute ":MagmaEvaluateArgument a=5"
" endfunction

" :command MagmaInitPython :call MagmaInitPython()
