" vim-airline
if empty(glob("~/.zshrc-server"))
  let g:airline_powerline_fonts = 1
endif

" Just show the file name
let g:airline#extensions#tabline#fnamemod = ':t'
