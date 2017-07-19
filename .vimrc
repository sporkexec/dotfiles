" prep for vundle
set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" plugins, vundle is mandatory
Plugin 'bling/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'AndrewRadev/linediff.vim'
Plugin 'ervandew/supertab'
Plugin 'luochen1990/rainbow'
Plugin 'scrooloose/nerdcommenter'
Plugin 'scrooloose/nerdtree'
Plugin 'scrooloose/syntastic'
Plugin 'sjl/gundo.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-commentary'
Plugin 'dbext.vim'
Plugin 'AnsiEsc.vim'
Plugin 'vim-less'
Plugin 'chriskempson/base16-vim'
Plugin 'ap/vim-css-color'
Plugin 'scratch.vim'
Plugin 'vim-indent-object'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'rking/ag.vim'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'airblade/vim-gitgutter'
Plugin 'zirrostig/vim-schlepp'
Plugin 'kchmck/vim-coffee-script'

" Plugin seems to sometimes crash upon write+close
" We'll just manually set a similar filetype for the moment
"Plugin 'mustache/vim-mustache-handlebars'
au BufRead,BufNewFile *.hbs setfiletype html
let g:syntastic_ignore_files = ['\m\c\.hbs$']

" all vundle plugin calls must be above
call vundle#end()
filetype plugin indent on

" plugin config
let g:mustache_abbreviations = 1
let g:syntastic_filetype_map = { 'html.handlebars': 'handlebars' }
let g:syntastic_javascript_checkers = ['jsxhint']
let g:dbext_default_history_file = $HOME . '/.vim/dbext_sql_history.txt'
let g:airline_theme='badwolf'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:rainbow_active = 0
let g:gundo_close_on_revert = 1
let base16colorspace=256
let g:ag_working_path_mode="r" " search from project root by default
let g:ctrlp_match_window = 'bottom,order:ttb'
let g:ctrlp_switch_buffer = 0
let g:ctrlp_working_path_mode = 0
let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden --ignore .git -g ""'

" security
source ~/.vim/sensitive.vim
set modelines=0
set dir=~/.vim/swp//
set backupdir=~/.vim/backup//

" misc UI tweaks
set tabpagemax=100 " tabedit limit
set hidden

" indentation
set tabstop=2 " visual spaces per tab
set softtabstop=2 " spaces inserted/deleted per tab when editing
set shiftwidth=2
set expandtab " tabs are spaces
set autoindent
set nocindent

" visual
syntax on
set encoding=utf-8
set guifont=Monospace\ 11
set background=dark
set laststatus=2
set noshowmode
set showcmd
set cursorline " highlight current line
set ttyfast
set number
set lazyredraw " redraw only when we need to
highlight link htmlLink text |" Stop underlining <a> contents in HTML.
colorscheme base16-monokai

" search/file completion
set wildmode=longest,list,full
set wildmenu
set scrolloff=3
set hlsearch " highlight matches
set incsearch " search as characters are entered
set ignorecase " case insensitive, except...
set smartcase " ...when we search for strings with caps
set gdefault " s/search/replace/g globally by default
set showmatch " highlight matching [{()}]

" folding
set foldenable
set foldlevelstart=10 " 10 layers open by default
set foldnestmax=10
set foldmethod=indent

" disable annoying keys, force me to suck less
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
" jump to matching char
nnoremap <tab> %
vnoremap <tab> %
" sane regexps by default
nnoremap / /\v
vnoremap / /\v
" folding toggle
nnoremap <space> za
" strip trailing whitespace
nnoremap <leader>W :%s/\s\+$//<cr>:let @/=''<cr>
" highlight last inserted text
nnoremap gV `[v`]
" misc plugins
nnoremap <leader><tab> :Scratch<cr>
nnoremap <leader>R :RainbowToggle<cr>
nnoremap <leader>u :GundoToggle<cr>
" git/fugitive
nnoremap <Leader>gs :Gstatus<CR>
nnoremap <Leader>gd :Gdiff<CR>
nnoremap <Leader>gb :Gblame<CR>
nnoremap <Leader>gl :Glog<CR>
nnoremap <Leader>ga :Git add %:p<CR><CR>
" ag.vim
nnoremap <leader>a :Ag 
" nerdtree
nnoremap <leader>t :NERDTreeToggle<CR>
" ctrlp
nnoremap <leader>, :CtrlP<CR>
" buffer navigation
nnoremap <leader>. :ls<CR>:b 
nnoremap <leader>f :bnext<CR>
nnoremap <leader>b :bprev<CR>
" schlepp: move around visual blocks
vmap <c-k>    <Plug>SchleppUp
vmap <c-j>  <Plug>SchleppDown
vmap <c-h>  <Plug>SchleppLeft
vmap <c-l> <Plug>SchleppRight

" allows cursor change in tmux mode
if exists('$TMUX')
    let &t_SI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=1\x7\<Esc>\\"
    let &t_EI = "\<Esc>Ptmux;\<Esc>\<Esc>]50;CursorShape=0\x7\<Esc>\\"
else
    let &t_SI = "\<Esc>]50;CursorShape=1\x7"
    let &t_EI = "\<Esc>]50;CursorShape=0\x7"
endif

" Make tabs, trailing whitespace, and non-breaking spaces visible
exec "set listchars=tab:\uBB\uBB,trail:\uB7,nbsp:~"
set list

" Swap v and CTRL-V, because Block mode is more useful than Visual mode
nnoremap    v   <C-V>
nnoremap <C-V>     v
vnoremap    v   <C-V>
vnoremap <C-V>     v

" Make next search result stand out when jumping around
nnoremap <silent> n   n:call HLNext(0.05)<cr>
nnoremap <silent> N   N:call HLNext(0.05)<cr>
function! HLNext (blinktime)
    let [bufnum, lnum, col, off] = getpos('.')
    let matchlen = strlen(matchstr(strpart(getline('.'),col-1),@/))

    " Get search result text
    let target_pat = '\%'.lnum.'l\%>'.col.'v\%<'.(col+matchlen).'v.'
    " Get 1-cell ring around search result
    let ring_pat = (lnum > 1 ? '\%'.(lnum-1).'l\%>'.max([col-2,1]) .'v\%<'.(col+matchlen+1).'v.\|' : '')
            \ . '\%'.lnum.'l\%>'.max([col-2,1]) .'v\%<'.col.'v.'
            \ . '\|'
            \ . '\%'.lnum.'l\%>'.max([col+matchlen-1,1]) .'v\%<'.(col+matchlen+1).'v.'
            \ . '\|'
            \ . '\%'.(lnum+1).'l\%>'.max([col-2,1]) .'v\%<'.(col+matchlen+1).'v.'

    highlight CustomHlRing ctermfg=white ctermbg=white
    highlight CustomHlTarget ctermfg=cyan ctermbg=NONE cterm=bold
    let ring = matchadd('CustomHlRing', ring_pat, 101)
    let target = matchadd('CustomHlTarget', target_pat, 101)

    redraw
    exec 'sleep ' . float2nr(a:blinktime * 1000) . 'm'
    call matchdelete(ring)
    call matchdelete(target)
    redraw
endfunction
