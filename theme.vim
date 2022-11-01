"
" THEME SETTINGS
"
" Syntax highlighting
let g:python_highlight_all=1

" Change this when you know where i3 will be
aug i3config_ft_detection
  au!
  au BufNewFile,BufRead ~/.config/i3/config set filetype=i3config
aug end

" GRUVBOX SETTINGS
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

"
" AIRLINE SETTINGS
"
" Disable tabline close button
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#show_tab_type = 0
let g:airline#extensions#tabline#show_tab_nr = 0
let g:airline#extensions#tabline#fnamecollapse = 1

let g:airline_extensions = ['branch', 'hunks', 'coc']

let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#coc#enabled = 1

" Just show the file name
let g:airline#extensions#tabline#fnamemod = ':t'

" enable powerline fonts
let g:airline_powerline_fonts = 1
let g:airline_left_sep = ''
let g:airline_right_sep = ''
let g:airline_right_alt_sep = ''

let g:airline#extensions#tabline#formatter = 'unique_tail'

let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'z', 'warning', 'error']]
" let g:airline_skip_empty_sections = 1

silent! let g:airline_section_c = airline#section#create([''])

" Switch to your current theme
let g:airline_theme = 'gruvbox_material'

" Sections
let g:airline_section_y = ''
let g:webdevicons_enable_airline_tabline = 1
