" vim-airline
if empty(glob("~/.zshrc-server"))
  let g:airline_powerline_fonts = 1
endif

" let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 1
" Just show the file name
let g:airline#extensions#tabline#fnamemod = ':t'
