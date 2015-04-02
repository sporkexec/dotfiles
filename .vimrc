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
Plugin 'scrooloose/syntastic'
Plugin 'dbext.vim'
Plugin 'AnsiEsc.vim'
Plugin 'vim-less'
Plugin 'molokai'
Plugin 'vim-indent-object'

" all vundle plugin calls must be above
call vundle#end()
filetype plugin indent on

" things to keep out of github
source ~/.vim/sensitive.vim

" indentation
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noexpandtab

" visual
set guifont=Monospace\ 11
syntax on
set background=dark
colorscheme molokai
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set laststatus=2
set noshowmode

" file completion
set wildmode=longest,list,full
set wildmenu

" disable arrow keys
noremap <up> <nop>
noremap <down> <nop>
noremap <left> <nop>
noremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

" tabedit limit
set tabpagemax=100

" search
set hlsearch
set incsearch

" .less syntax highlighting
au BufNewFile,BufRead *.less set filetype=less

" .jsx
let g:syntastic_javascript_checkers = ['jsxhint']

" don't clutter home with this
let g:dbext_default_history_file = $HOME . '/.vim/dbext_sql_history.txt'

" Stop underlining <a> contents in HTML.
highlight link htmlLink text

" Pop a shell on suspend
noremap <C-Z> :shell<CR>

" I can probably remember :help...
noremap <F1> <nop>
inoremap <F1> <nop>
