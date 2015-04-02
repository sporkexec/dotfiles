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

" all vundle plugin calls must be above
call vundle#end()
filetype plugin indent on

" things to keep out of github
source ~/.vim/sensitive.vim

" makes airline happy IIRC
set laststatus=2

" indentation
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noexpandtab

" visual
set guifont=Monospace\ 11
syntax on
set background=dark
colorscheme base16-monokai
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
set noshowmode

" file completion
set wildmode=longest,list,full
set wildmenu

" disable arrow keys
map <up> <nop>
map <down> <nop>
map <left> <nop>
map <right> <nop>
imap <up> <nop>
imap <down> <nop>
imap <left> <nop>
imap <right> <nop>

" tabedit
hi TabLine ctermfg=White ctermbg=Black cterm=NONE
hi TabLineFill ctermfg=Black ctermbg=Black cterm=NONE
hi TabLineSel ctermfg=Black ctermbg=White cterm=NONE
set tabpagemax=100

" search
set hlsearch
set incsearch

" .less syntax highlighting
au BufNewFile,BufRead *.less set filetype=less

" .jsx
let g:syntastic_javascript_checkers = ['jsxhint']

" Stop underlining <a> contents in HTML.
highlight link htmlLink text

" Pop a shell on suspend
map <C-Z> :shell<CR>

" I can probably remember :help...
map <F1> <nop>
imap <F1> <nop>
