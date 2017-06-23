" auto-install vim-plug
if empty(glob('~/.config/nvim/autoload/plug.vim'))
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall
endif

" Install with :PlugInstall
" Clean with :PlugClean
call plug#begin('~/.config/nvim/plugged')

" Move between Vim panes and tmux splits seamlessly.
" <ctrl-h> => Left
" <ctrl-j> => Down
" <ctrl-k> => Up
" <ctrl-l> => Right
" <ctrl-\> => Previous split
Plug 'christoomey/vim-tmux-navigator'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
     nnoremap <C-p> :FZF<CR>
     nnoremap <Leader>g :Ag <C-r><C-w><CR>

Plug 'sheerun/vim-polyglot'
     let g:ruby_indent_block_style = 'do'

Plug 'tpope/vim-endwise'    " Automatic insertion of block endings

Plug 'tpope/vim-commentary' " Easily comment

Plug 'tpope/vim-fugitive'   " Git blame, diff, browse, etc
      nnoremap <Leader>gd :Gdiff<CR>
      nnoremap <Leader>gb :Gblame<CR>
      nnoremap <Leader>gw :Gbrowse-<CR>
      nnoremap <Leader>gr :Gread<CR>

Plug 'tpope/vim-rhubarb'

Plug 'junegunn/vim-easy-align'
     " Start interactive EasyAlign in visual mode (e.g. vipga)
     xmap ga <Plug>(EasyAlign)
     " Start interactive EasyAlign for a motion/text object (e.g. gaip)
     nmap ga <Plug>(EasyAlign)

Plug 'airblade/vim-gitgutter'

Plug 'vim-scripts/vim-auto-save'
     let g:auto_save = 1

Plug 'scrooloose/nerdtree'
     nnoremap <Leader>n :NERDTree<CR>
     nnoremap <Leader>f :NERDTreeFind<CR>

" TODO:
" Completion - Youcompleteme?
" Syntax - neomake?

Plug 'neomake/neomake'

Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
     let g:deoplete#enable_at_startup = 1

Plug 'frankier/neovim-colors-solarized-truecolor-only'

Plug 'junegunn/vim-xmark', { 'do': 'make' }

Plug 'wellle/targets.vim'

Plug 'michaeljsmith/vim-indent-object'

Plug 'tpope/vim-surround'

call plug#end()
