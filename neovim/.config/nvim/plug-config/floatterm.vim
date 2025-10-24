" let g:floaterm_wintype='normal'
" let g:floaterm_height=6

" let g:floaterm_keymap_toggle = '<F1>'
" let g:floaterm_keymap_prev   = '<F2>'
" let g:floaterm_keymap_next   = '<F3>'
let g:floaterm_keymap_new    = '<F4>'

" Floaterm
let g:floaterm_gitcommit='floaterm'
let g:floaterm_autoinsert=1
let g:floaterm_width=0.95
let g:floaterm_height=0.95
let g:floaterm_wintitle=1
let g:floaterm_autoclose=2
let g:floaterm_winblend=5

" make floaterm look like telescope
let g:floaterm_borderchars='─│─│╭╮╯╰'
let g:floaterm_title ='─floaterm: $1/$2'
hi FloatermBorder guibg=bg
" fun side-effect of setting background transparent in kitty with #262626
" set little darker here to make floaterm visually distinct
hi Floaterm guibg=#252525

" fixes neovim floaterm toggle problem with floaterm
" https://github.com/neovim/neovim/issues/14524
" https://github.com/asvetliakov/vscode-neovim/issues/632#issuecomment-837201224
map <silent> <F1> §:call FloatermFix("FloatermToggle")<CR>
tmap <silent> <F1> §:call FloatermFix("FloatermToggle")<CR>

map <silent> <F2> §:call FloatermFix("FloatermPrev")<CR>
tmap <silent> <F2> §:call FloatermFix("FloatermPrev")<CR>

map <silent> <F3> §:call FloatermFix("FloatermNext")<CR>
tmap <silent> <F3> §:call FloatermFix("FloatermNext")<CR>

map <silent> <F4> §:call FloatermFix("FloatermNew")<CR>
tmap <silent> <F4> §:call FloatermFix("FloatermNew")<CR>

function FloatermFix(func)
  set eventignore=BufWinEnter,BufEnter,BufLeave
  exe a:func
  set eventignore=
endfunction
