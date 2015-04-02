" prep for vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins, vundle is mandatory
Plugin 'gmarik/Vundle.vim'
Plugin 'bling/vim-airline'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'ervandew/supertab'
Plugin 'luochen1990/rainbow'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'dbext.vim'
Plugin 'AnsiEsc.vim'
Plugin 'vim-less'
Plugin 'chriskempson/base16-vim'
Plugin 'scratch.vim'
Plugin 'vim-indent-object'

" all vundle plugin calls must be above
call vundle#end()
filetype plugin indent on

" plugin config
let g:syntastic_javascript_checkers = ['jsxhint']
let g:dbext_default_history_file = $HOME . '/.vim/dbext_sql_history.txt'
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:rainbow_active = 0
let g:gundo_close_on_revert = 1
let base16colorspace=256

" security
source ~/.vim/sensitive.vim
set modelines=0

" misc UI tweaks
set tabpagemax=100 " tabedit limit

" indentation
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noexpandtab
set autoindent

" visual
syntax on
set encoding=utf-8
set guifont=Monospace\ 11
set background=dark
set laststatus=2
set noshowmode
set showcmd
set ttyfast
highlight link htmlLink text |" Stop underlining <a> contents in HTML.
colorscheme base16-monokai

" search/file completion
set wildmode=longest,list,full
set wildmenu
set scrolloff=3
set hlsearch
set incsearch
set ignorecase
set smartcase
set gdefault
set showmatch

" disable annoying keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
noremap <F1> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>
inoremap <F1> <nop>
vnoremap <F1> <nop>

" shortcuts
let mapleader = ","
inoremap jj <ESC>
nnoremap ; :
" clear searches
nnoremap <leader><space> :nohlsearch<cr>
" pop a new shell instead of suspending
nnoremap <C-Z> :shell<cr>
" jump to matching char
nnoremap <tab> %
vnoremap <tab> %
" sane regexps by default
nnoremap / /\v
vnoremap / /\v
" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>
nnoremap <leader><tab> :Scratch<cr>
nnoremap <leader>R :RainbowToggle<cr>
nnoremap <leader>u :GundoToggle<cr>
