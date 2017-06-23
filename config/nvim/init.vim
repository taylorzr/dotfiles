source ~/dotfiles/config/nvim/options.vim
source ~/dotfiles/config/nvim/mapping.vim
source ~/dotfiles/config/nvim/plugins.vim
source ~/dotfiles/config/nvim/languages.vim

colorscheme solarized

autocmd! BufWritePost * Neomake

" Fix color of warning, without this it's barely visible
:highlight NeomakeWarningMessage ctermfg=227
let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMessage'}
