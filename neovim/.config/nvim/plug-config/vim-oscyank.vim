" automatic yank after pressing y
autocmd TextYankPost * if (v:event.operator is 'y' || v:event.operator is 'Y') && v:event.regname is '' | execute 'OSCYankReg "' | endif

" don't echo yanks
let g:oscyank_silent = v:true
