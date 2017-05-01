"
" General Configuration

  set nonumber                    " Visual line numbers are unecessary
  set backspace=indent,eol,start  " Allow backspace in insert mode
  set history=1000                " Store lots of :cmdline history
  set showcmd                     " Show incomplete cmds down the bottom
  set showmode                    " Show current mode down the bottom
  set gcr=a:blinkon0              " Disable cursor blink
  set visualbell                  " No sounds
  set autoread                    " Reload files changed outside vim
  set splitright                  " Open vertical splits right of current
  set splitbelow                  " Open horizontal splits below current
  set hidden                      " http://items.sjbach.com/319/configuring-vim-right
  set noswapfile
  set nobackup
  set nowb
  set scrolloff=8
  set sidescrolloff=15
  set sidescroll=1
  set hlsearch
  set ignorecase
  set smartcase
  set colorcolumn=80
  set tags=./tags;


  " Whitespace
  set autoindent
  set smartindent
  set smarttab
  set shiftwidth=2
  set softtabstop=2
  set tabstop=2
  set expandtab
  set backspace=2
  filetype plugin on
  filetype indent on
  " Auto indent pasted text
  nnoremap p p=`]<C-o>
  nnoremap P P=`]<C-o>
  vnoremap p p=`]<C-o>
  " Display tabs and trailing spaces visually
  set list listchars=tab:\ \ ,trail:·
  " Color
  syntax on
  set background=dark
  set cursorline
  colorscheme solarized
  " Automatically wrap text
  set textwidth=72
  set fo+=t


"
" Key mappings

  let mapleader="\<Space>"
  nnoremap ; :
  vnoremap ; :
  nnoremap : ;
  vnoremap : ;
  nnoremap j gj
  nnoremap k gk
  " Easier begin/end of line
  noremap H ^
  noremap L $
  vnoremap L g_
  nnoremap <Leader>ve :edit ~/.vimrc<CR>
  nnoremap <Leader>vs :source ~/.vimrc<CR>
  nnoremap <Leader>ze :edit ~/.zshrc<CR>
  nnoremap <CR> :nohlsearch<CR>
  nnoremap <Leader>w :StripWhitespace<CR>
  " Escape insert mode similar to killing processes in shell
  inoremap <C-c> <ESC>
  " Switch from insert mode when you think you're in nomral mode
  inoremap jk <ESC>
  inoremap kj <ESC>

  " Resize windows with arrow keys
  nnoremap <D-Up> <C-w>+
  nnoremap <D-Down> <C-w>-
  nnoremap <D-Left> <C-w><
  nnoremap <D-Right>  <C-w>>
  " Gitsh
  nnoremap <Leader>gs :Start gitsh<CR>
  nnoremap <Leader>d :bd<CR>
  nnoremap <Leader>p orequire 'pry'; binding.pry<ESC>

  nnoremap <Leader>rd :!bundle exec rake db:reset<CR>
  nnoremap <Leader>rt :!RAILS_ENV=test bundle exec rake db:reset<CR>

  nnoremap <Leader>cf :let @*=expand('%') \| echo 'Filename copied to clipboard!'<CR>
  nnoremap <Leader>cl :let @*=expand('%') . ':' . line('.') \| echo 'Filename & line copied to clipboard!'<CR>
  nnoremap <Leader>fd :call delete(expand('%')) \| bdelete!<CR>

  nnoremap <Leader>aa gg=G``

  nnoremap <Leader>da ggdG

  " nnoremap <Leader>db :e db/structure.sql<CR> \| :/ create table %
  nnoremap <Leader>db :call JumpToStructure(expand('%:t:r'))<CR>

  nnoremap <Leader>r :redraw! \| echo 'Screen redrawn!'<CR>

"
" Functions

  function! PersistUndo()
    " Keep undo history across sessions, by storing in file.
    " Only works all the time.
    if has('persistent_undo') && !isdirectory(expand('~').'/.vim/backups')
      silent !mkdir ~/.vim/backups > /dev/null 2>&1
      set undodir=~/.vim/backupsa//
      set undofile
    endif
  endfunction

  " Quickfix Window
  au FileType qf call AdjustWindowHeight(3, 15)
  function! AdjustWindowHeight(minheight, maxheight)
    exe max([min([line("$"), a:maxheight]), a:minheight]) . "wincmd _"
  endfunction

  function! JumpToStructure(model_name)
    execute ':e db/structure.sql'
    " execute ':/ create table ' . a:model_name
  endfunction

"
" Plugins

  nnoremap <Leader>pi :source ~/.vimrc<CR>:PlugInstall<CR>
  nnoremap <Leader>pc :source ~/.vimrc<CR>:PlugClean<CR>

  call plug#begin('~/.vim/plugged')

    Plug 'justinmk/vim-sneak'
    Plug 'yonchu/accelerated-smooth-scroll'
    Plug 'briandoll/change-inside-surroundings.vim'
    Plug 'kana/vim-textobj-user'
    Plug 'tek/vim-textobj-ruby'
    Plug 'sheerun/vim-polyglot'
          " Configure vim-ruby
          let g:ruby_indent_block_style = 'do'

    Plug 'tpope/vim-rails'
    Plug 'ngmy/vim-rubocop'
    Plug 'ntpeters/vim-better-whitespace'
    Plug 'AndrewRadev/splitjoin.vim'
    Plug 'tpope/vim-unimpaired'
    Plug 'ervandew/supertab'
    Plug 'valloric/youcompleteme'
    Plug 'tpope/vim-endwise'
    Plug 'tpope/vim-dispatch'
    Plug 'tpope/vim-commentary'
    Plug 'airblade/vim-gitgutter'
    Plug 'tpope/vim-bundler'
    Plug 'tpope/vim-rake'
    Plug 'christoomey/vim-system-copy'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'xolox/vim-misc'
    Plug 'xolox/vim-notes'
    Plug 'tpope/vim-repeat'
    Plug 'junegunn/vim-pseudocl'
    Plug 'junegunn/vim-oblique'
          let g:oblique#clear_highlight=1
          let g:oblique#incsearch_highlight_all=1

    Plug 'junegunn/vim-xmark', { 'do': 'make' }
          nnoremap <Leader>md :Xmark><CR>

    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'junegunn/fzf.vim'
          nnoremap <C-p> :FZF<CR>
          nnoremap <Leader>b :Buffers<CR>
          nnoremap <Leader>g :Ag <C-r><C-w><CR>

    Plug 'mileszs/ack.vim'

    Plug 'scrooloose/nerdtree'
          nnoremap <Leader>n :NERDTree<CR>
          nnoremap <Leader>f :NERDTreeFind<CR>
          let g:NERDTreeWinSize=40
          let NERDTreeShowHidden=1

    Plug 'Xuyuanp/nerdtree-git-plugin'

    Plug 'vim-airline/vim-airline'
    Plug 'vim-airline/vim-airline-themes'
          set laststatus=2
          let g:airline_powerline_fonts = 1
          " Default pattern is: "%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}%{airline#util#wrap(airline#extensions#branch#get_head(),0)}"
          let g:airline_section_b = "%{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}"

    Plug 'tpope/vim-surround'
          nmap <Leader># ysiw#
          nmap <Leader>" ysiw"
          nmap <Leader>' ysiw'
          nmap <Leader>] ysiw]
          nmap <Leader>) ysiw)
          nmap <Leader>} ysiw}

    Plug 'junegunn/vim-easy-align'
          " Start interactive EasyAlign in visual mode (e.g. vipga)
          xmap ga <Plug>(EasyAlign)
          " Start interactive EasyAlign for a motion/text object (e.g. gaip)
          nmap ga <Plug>(EasyAlign)

    Plug 'vim-scripts/vim-auto-save'
          let g:auto_save = 1
          " let g:auto_save_in_insert_mode = 0
          " let g:auto_save_silent = 1

    Plug 'AndrewRadev/sideways.vim'
          nnoremap <Leader>ml :SidewaysLeft<cr>
          nnoremap <Leader>mr :SidewaysRight<cr>

    Plug 'thoughtbot/vim-rspec'
          let g:rspec_command = "Dispatch rspec {spec}"
          nnoremap <Leader>t :call RunCurrentSpecFile()<CR>
          nnoremap <Leader>s :call RunNearestSpec()<CR>
          nnoremap <Leader>l :call RunLastSpec()<CR>
          " nnoremap <Leader>a :call RunAllSpecs()<CR>

    Plug 'scrooloose/syntastic'
          let g:syntastic_ruby_mri_exec = '~/.rvm/rubies/ruby-2.2.2/bin/ruby'
          nnoremap <Leader>e :Errors<CR>

    Plug 'tpope/vim-fugitive'
          nnoremap <Leader>gd :Gdiff<CR>
          nnoremap <Leader>gb :Gblame<CR>
          nnoremap <Leader>gw :Gbrowse-<CR>
          nnoremap <Leader>gr :Gread<CR>
    Plug 'junegunn/gv.vim'

    Plug 'wfleming/vim-codeclimate'
          nnoremap <Leader>cc :CodeClimateAnalyzeCurrentFile<CR>
    Plug 'junegunn/vim-peekaboo'

    Plug 'SirVer/ultisnips'
         let g:UltiSnipsSnippetsDir="~/.vim/UltiSnips"
         " make YCM compatible with UltiSnips (using supertab)
         let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
         let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
         let g:SuperTabDefaultCompletionType = '<C-n>'
         " better key bindings for UltiSnipsExpandTrigger
         let g:UltiSnipsExpandTrigger = "<tab>"
         let g:UltiSnipsJumpForwardTrigger = "<tab>"
         let g:UltiSnipsJumpBackwardTrigger = "<s-tab>"
         " configure slurper filetypes
         au BufRead,BufNewFile *.slurper setfiletype slurper
         au FileType slurper :UltiSnipsAddFiletypes slurper

  call plug#end()

