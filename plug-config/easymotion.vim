" EasyMotion sneak-like settings

" Disable default mappings
let g:EasyMotion_do_mapping = 0
" Case insensitive mappings
let g:EasyMotion_smartcase = 1

" Sneak-like configuration (but bidirectional!)
nmap f <Plug>(easymotion-s2)
xmap f <Plug>(easymotion-s2)
vmap f <Plug>(easymotion-s2)

map <C-j> <Plug>(easymotion-j)
map <C-k> <Plug>(easymotion-k)

" Cool prompt
let g:EasyMotion_prompt = '🔎 '
