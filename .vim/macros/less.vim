" Vim script to work like "less"
" Heavily mangled for less arbitrary shit.
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last Change:	2006 Dec 05

" Avoid loading this file twice, allow the user to define his own script.
if exists("loaded_less")
  finish
endif
let loaded_less = 1

" If not reading from stdin, skip files that can't be read.
" Exit if there is no file at all.
if argc() > 0
  let s:i = 0
  while 1
    if filereadable(argv(s:i))
      if s:i != 0
	sleep 3
      endif
      break
    endif
    if isdirectory(argv(s:i))
      echomsg "Skipping directory " . argv(s:i)
    elseif getftime(argv(s:i)) < 0
      echomsg "Skipping non-existing file " . argv(s:i)
    else
      echomsg "Skipping unreadable file " . argv(s:i)
    endif
    echo "\n"
    let s:i = s:i + 1
    if s:i == argc()
      quit
    endif
    next
  endwhile
endif

" TODO: automatically detect syntax on stdin.
syntax on

" Don't remember file names and positions
set viminfo=

" Inhibit screen updates while searching
let s:lazyredraw = &lazyredraw
set lazyredraw

" When reading from stdin don't consider the file modified.
au VimEnter * set nomod

" Can't modify the text
" Fuck that, sometimes we want to macro-format something from stdin.
" set noma

" Give help
" Fuck that, leave my h key alone.
"noremap h :call <SID>Help()<CR>
"map H h
fun! s:Help()
  echo "<Space>   One page forward          b         One page backward"
  echo "d         Half a page forward       u         Half a page backward"
  echo "<Enter>   One line forward          k         One line backward"
  echo "G         End of file               g         Start of file"
  echo "N%        percentage in file"
  echo "\n"
  echo "/pattern  Search for pattern        ?pattern  Search backward for pattern"
  echo "n         next pattern match        N         Previous pattern match"
  echo "\n"
  echo ":n<Enter> Next file                 :p<Enter> Previous file"
  echo "\n"
  echo "q         Quit                      v         Edit file"
  let i = input("Hit Enter to continue")
endfun


" I've never used ex mode, so I'm remapping Q. Use Q for macros, q to quit.
" It doesn't force quit with changes so that you're safe if you forget that q
" isn't macro or fumble around and hit it.
noremap Q q
noremap q :q<CR>

" vim: sw=2
