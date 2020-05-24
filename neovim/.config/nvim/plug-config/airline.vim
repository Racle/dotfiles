" vim-airline
if empty(glob("~/.zshrc-server")) 
  let g:airline_powerline_fonts = 1
endif

let g:airline#extensions#tabline#enabled = 1
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
