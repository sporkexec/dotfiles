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

" tabedit
hi TabLine ctermfg=White ctermbg=Black cterm=NONE
hi TabLineFill ctermfg=Black ctermbg=Black cterm=NONE
hi TabLineSel ctermfg=Black ctermbg=White cterm=NONE

" search
set hlsearch
set incsearch

" .less syntax highlighting
au BufNewFile,BufRead *.less set filetype=less

" Pop a shell on suspend
:map <C-Z> :shell<CR>

" I can probably remember :help...
:map <F1> <nop>
:imap <F1> <nop>
