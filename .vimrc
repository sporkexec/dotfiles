" indentation
set tabstop=4
set softtabstop=0
set shiftwidth=4
set noexpandtab

" visual
set guifont=Monospace\ 11
syntax on
colorscheme desert

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

" tabedit labels
hi TabLine ctermfg=White ctermbg=Black cterm=NONE
hi TabLineFill ctermfg=Black ctermbg=Black cterm=NONE
hi TabLineSel ctermfg=Black ctermbg=White cterm=NONE

" .less syntax highlighting
au BufNewFile,BufRead *.less set filetype=less

