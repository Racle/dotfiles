let g:go_def_mode='gopls'
let g:go_info_mode='gopls'
" let g:go_def_mapping_enabled = 0
let g:go_list_type='quickfix'

let g:go_metalinter_autosave=1
" let g:go_metalinter_autosave_enabled=['golint', 'govet']
" let g:go_metalinter_autosave_enabled=['govet']


let g:go_code_completion_enabled = 0


function GoToReferrers()
  nnoremap gr :GoReferrers<CR>
endfunction

autocmd FileType go call GoToReferrers()
