" automatic yank after pressing y
autocmd TextYankPost * if v:event.operator is 'y' && v:event.regname is '' | execute 'OSCYankRegister "' | endif

" don't echo yanks
let g:oscyank_silent = v:true
