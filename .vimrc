call pathogen#infect()
set nocompatible
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

" search
set hlsearch
set incsearch

" .less syntax highlighting
au BufNewFile,BufRead *.less set filetype=less

" Stop underlining <a> contents in HTML.
highlight link htmlLink text

" Pop a shell on suspend
:map <C-Z> :shell<CR>

" I can probably remember :help...
:map <F1> <nop>
:imap <F1> <nop>
