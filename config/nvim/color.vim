" colorscheme flattened_dark
" (needs to come after loading plugins)
colorscheme spartan
set background=dark

" obvious trailing whitespace
" TODO: This doesn't work when the config is reloaded, investigate
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

" colorcolumn
set colorcolumn=80
highlight ColorColumn ctermbg=Black

" Fix color of warning, without this it's barely visible
highlight NeomakeWarningMessage ctermfg=227
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMessage'}

