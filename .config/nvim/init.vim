" enable mouse in all modes
set mouse=a

" Leader (leader needs to be set before mappings are defined using leader)
let mapleader="\<Space>"

" Plugins
" {{{
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

Plug 'christoomey/vim-sort-motion'

" Fuzzy Finder
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
     nnoremap <C-p> :FZF<CR>
     nnoremap <Leader>g :Ag <C-r><C-w><CR>

" Plug 'sheerun/vim-polyglot'
"      let g:ruby_indent_block_style = 'do'
"      let g:vim_markdown_folding_disabled = 1

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
     let g:auto_save_in_insert_mode = 0  " do not save while in insert mode

" FIXME: Remove if using :Lexplore works enough
nnoremap <Leader>n :Lexplore<CR>
" Plug 'scrooloose/nerdtree'
"      nnoremap <Leader>n :NERDTree<CR>
"      nnoremap <Leader>f :NERDTreeFind<CR>

" This is slow on large files why?!?!
" Plug 'w0rp/ale'

Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  let g:go_fmt_command = 'goimports'
     " let g:go_auto_type_info = 1

Plug 'vim-ruby/vim-ruby'

" Plug 'shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
" Plug 'zchee/deoplete-go', { 'do': 'make' }
" Plug 'takkii/Bignyanco' " Some kind of ruby completion
" Plug 'fishbullet/deoplete-ruby'
"      let g:deoplete#enable_at_startup = 1
"      inoremap <expr><tab> pumvisible() ? "\<C-n>" : "\<tab>"
"      inoremap <expr><s-tab> pumvisible() ? "\<C-p>" : "\<s-tab>"
     " let g:deoplete#sources#go#gocode_binary = '~/go/bin/gocode'

Plug 'lifepillar/vim-mucomplete'
  set completeopt+=menuone
  set completeopt+=noselect

Plug 'stamblerre/gocode', { 'rtp': 'vim', 'do': '~/.config/nvim/plugged/gocode/vim/symlink.sh' }

Plug 'sebdah/vim-delve'

Plug 'wellle/targets.vim'

Plug 'michaeljsmith/vim-indent-object'

" Plug 'tpope/vim-surround'
Plug 'machakann/vim-sandwich'

" Why is this so slow?!?!?!
" Plug 'chrisbra/Colorizer'
"      :let g:colorizer_auto_color = 1

Plug 'tpope/vim-projectionist'

Plug 'dracula/vim', { 'as': 'dracula' }

Plug 'tpope/vim-eunuch'

Plug 'SirVer/ultisnips'

Plug 'ruby-formatter/rufo-vim'

Plug 'AndrewRadev/splitjoin.vim'

" HTML Plugins
Plug 'alvan/vim-closetag'
Plug 'mattn/emmet-vim'

call plug#end()
" }}}

" Languages
" {{{
" Generic static analysis
" autocmd! BufWritePost * Neomake

" Ruby
autocmd Filetype ruby nnoremap <Leader>p orequire 'pry'; binding.pry<ESC>
autocmd Filetype ruby nnoremap <Leader>r orequire 'pry-remote'; binding.pry_remote<ESC>

" Elixir
autocmd Filetype elixir nnoremap <Leader>p orequire IEx; IEx.pry<ESC>

" Python
autocmd Filetype python nnoremap <Leader>p ofrom IPython import embed; embed()<ESC>

" Go
autocmd FileType go setlocal noexpandtab
autocmd FileType go setlocal tabstop=2
autocmd FileType go setlocal shiftwidth=2
autocmd FileType go nnoremap <Leader>e oif err != nil {<ENTER>return nil, err<ENTER>}<ESC>

" Make
autocmd FileType make setlocal noexpandtab

" Cron
autocmd filetype crontab setlocal nobackup nowritebackup

" R
autocmd FileType r setlocal commentstring=#\ %s
" }}}

" Mappings
" {{{
" Easy config reloading
command! Reload source $MYVIMRC
command! Config edit $MYVIMRC

" Switch ; & :
" Quicker access to command mode
nnoremap ; :
vnoremap ; :
nnoremap : ;
vnoremap : ;

" Clear search highlighting
nnoremap <CR> :nohlsearch<CR>

" Jump to beginning/end of line
noremap H ^
noremap L $

" Easier indent/dedent
nnoremap > >>
nnoremap < <<

" Easier saving
nnoremap <C-s> :update<CR>
inoremap <C-s> <C-o>:update<CR>

" Allow saving of files as sudo when I forgot to start vim using sudo.
cmap w!! w !sudo tee > /dev/null %

" Copy/run tests by filename or line number
if system('uname -s') == "Darwin\n"
  nnoremap <Leader>cf :let @*=expand('%') \| echo 'Filename copied to clipboard!'<CR>
  nnoremap <Leader>cfa :let @*=expand('%:p') \| echo 'Filename copied to clipboard!'<CR>
  nnoremap <Leader>cl :let @*=expand('%') . ':' . line('.') \| echo 'Filename & line copied to clipboard!'<CR>
else
  nnoremap <Leader>cf :let @+=expand('%') \| echo 'Filename copied to clipboard!'<CR>
  nnoremap <Leader>cl :let @+=expand('%') . ':' . line('.') \| echo 'Filename & line copied to clipboard!'<CR>
endif

nnoremap <Leader>ta :call Test('all', v:count1)<CR> \| :echo 'Testing all the things'<CR>
nnoremap <Leader>tf :call Test('file', v:count1)<CR> \| :echo 'Testing ' . expand('%')<CR>
nnoremap <Leader>tl :call Test('line', v:count1)<CR> \| :echo 'Testing ' . expand('%') . ':' . line('.')<CR>
command! -nargs=* Testall :call Test("all", <f-args>)
command! -nargs=* Testfile :call Test("file", <f-args>)
command! -nargs=* Testline :call Test("line", <f-args>)

function! Test(...)
  let mode = get(a:, 1, 'file')
  let window = get(a:, 2, 1)
  let cmd = ''

  if mode == 'all'
    let cmd = 'run-tests'
  elseif mode == 'file'
    let cmd = 'run-tests\ ' . expand('%')
  elseif mode == 'line'
    let cmd = 'run-tests\ ' . expand('%') . ':' . line('.')
  else
    " TODO: Better error?
    echoerr "Error!"
  endif

  let full_cmd = '!tmux send-keys -t ' . window . ' ' . cmd . '\ ' . ' Enter'

  silent exec full_cmd
endfunction

" Jump files instead of locations
" Hmn, I think this is not the previously viewed file
" nnoremap <C-o> :bnext<CR>
" nnoremap <C-i> :bprevious<CR>
"
" This conflicts with jumplist out, find better binding
" nnoremap <C-i> :edit ~/scratch.md<CR>

" let g:UltiSnipsExpandTrigger="<tab>"
" let g:UltiSnipsJumpForwardTrigger="<tab>"
" let g:UltiSnipsJumpBackwardTrigger="<s-tab>"


" }}}

" Options
" {{{
" Start scrolling before cursor reaches edge of screen
set scrolloff=10
" Show trailing tabs and spaces
set list listchars=tab:\▸\ ,trail:·

" Automatically wrap text
set textwidth=100
set fo+=t

" Expand tabs to spaces
set tabstop=4
set shiftwidth=2
set expandtab

" Use system clipboard for yanking
if system('uname -s') == "Darwin\n"
  set clipboard=unnamed
else
  set clipboard=unnamedplus
endif

" Turn off swap files
set noswapfile

" Persistent undo
set undofile

" Spell checking on
set spell

" Folding by marker `{{{` and `}}}`
set foldmethod=marker
nmap z] zo]z
nmap z[ zo[z

" }}}

" Color
" {{{
let g:dracula_colorterm = 0
colorscheme dracula

" obvious trailing whitespace
" http://vim.wikia.com/wiki/Highlight_unwanted_spaces
highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" colorcolumn
set colorcolumn=100
highlight ColorColumn ctermbg=Black

" Fix color of warning, without this it's barely visible
" highlight NeomakeWarningMessage ctermfg=227
" let g:neomake_warning_sign={'text': '⚠', 'texthl': 'NeomakeWarningMessage'}
" }}}

autocmd FileType ruby setlocal omnifunc=LanguageClient#complete
nnoremap <F5> :call LanguageClient_contextMenu()<CR>
nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

command! -bang -nargs=+ -complete=dir Rag call fzf#vim#ag_raw(<q-args>, {'options': '--delimiter : --nth 4..'}, <bang>0)

" https://stackoverflow.com/questions/4256697/vim-search-and-highlight-but-do-not-jump
noremap * :keepjumps normal! mi*`i<CR>

call deoplete#custom#option('auto_complete', v:false)

inoremap <silent><expr> <TAB>
\ pumvisible() ? "\<C-n>" :
\ <SID>check_back_space() ? "\<TAB>" :
\ deoplete#mappings#manual_complete()
function! s:check_back_space() abort "{{{
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
