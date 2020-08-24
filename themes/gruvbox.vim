" Theme settings
if exists('+termguicolors')
    let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
    let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
    set termguicolors
endif

set background=light
" let g:gruvbox_contrast_light = 'hard'
let g:gruvbox_material_background = 'soft'
colorscheme gruvbox-material

hi Comment cterm=italic
