" https://github.com/ChristianChiarulli/nvim/blob/master/keys/which-key.vim
" to prettify, use <leader>T,
" to fix commas before tabularize, %s/,\s*'/,'/g

" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
"set timeoutlen=500

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" c is for coc actions
let g:which_key_map.c = {
      \ 'name' : '+coc',
      \ 'c' : [':CocCommand','command list'],
      \ 's' : [':CocCommand snippets.editSnippets','edit snippets'],
      \ }




" l is for language server protocol
let g:which_key_map.l = {
      \ }



" custom menu after opening package.json
function WhichKeyPackageInfo()
  if(expand('%:t') != "package.json")
    return
  endif

  nmap <leader>Pi :lua require('package-info').install()<CR>
  nmap <leader>Pd :lua require('package-info').delete()<CR>
  nmap <leader>Pc :lua require('package-info').change_version()<CR>
  let g:which_key_map.P = {
        \ 'name' : '+Package',
        \ 'i' : 'Install',
        \ 'd' : 'Delete',
        \ 'c' : 'Change version',
        \ }
  call which_key#register('<Space>', "g:which_key_map")
endfunction

nmap <leader>mm :lua require('codewindow').toggle_minimap()<CR>

let g:which_key_map.m = {
      \ 'name' : '+Minimap',
      \ 'm' : 'Toggle codewindow',
      \ }

" custom debug menu for golang
function WhichKeyDebug()
  " dbc => debugBreakPoint
  let g:which_key_map.d = {
        \ 'name' : '+Debug',
        \ 'd' : [':GoDebugStart', "GoDebugStart"],
        \ 'j' : [':GoDebugStep', "GoDebugStep"],
        \ 'l' : [':GoDebugStepOut', "GoDebugStepOut"],
        \ 'b' : {
        \ 'p' : [':GoDebugBreakpoint', "GoDebugBreakpoint"],
        \ },
        \ 'r' : [':GoDebugRestart', "GoDebugRestart"],
        \ '_' : [':GoDebugStop', "GoDebugStop"],
        \ }
  call which_key#register('<Space>', "g:which_key_map")
endfunction

autocmd FileType go call WhichKeyDebug()
autocmd FileType json call WhichKeyPackageInfo()

" Register which key map
call which_key#register('<Space>', "g:which_key_map")
