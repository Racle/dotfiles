let g:coc_global_extensions = [
  \ 'coc-phpls',
  \ 'coc-json',
  \ 'coc-css',
  \ 'coc-html',
  \ 'coc-go',
  \ 'coc-snippets',
  \ 'coc-docker',
  \ 'coc-yaml',
  \ 'coc-homeassistant',
  \ 'coc-gitignore',
  \ 'coc-spell-checker',
  \ 'coc-tsserver',
  \ 'coc-sumneko-lua',
  \ 'coc-calc'
  \ ]
  " \ 'coc-pairs',

" coc settings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> gö <Plug>(coc-diagnostic-prev)
nmap <silent> gä <Plug>(coc-diagnostic-next)

" Use <C-j> for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<C-j>'
" Use <C-k> for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<C-k>'

" run goimports on save
let g:go_fmt_command = "goimports"

let g:coc_disable_transparent_cursor=1

" Use tab for trigger completion with characters ahead and navigate.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" close autocomplete menu and return to insert mode
" Github copilot doesn't work if autocomplete menu is showing
inoremap <silent><expr> §
     \ pumvisible() ? "\<ESC>a" :
     \ "\<ESC>"

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" use <c-space> to show function parameters
nmap <silent><c-space> :call CocActionAsync('showSignatureHelp')<CR>

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  imap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
      \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Explorer
let g:coc_explorer_global_presets = {
\   'floating': {
\      'position': 'floating',
\   },
\   'floatingLeftside': {
\      'position': 'floating',
\      'floating-position': 'left-center',
\      'floating-width': 30,
\   },
\   'floatingRightside': {
\      'position': 'floating',
\      'floating-position': 'right-center',
\      'floating-width': 30,
\   },
\   'simplify': {
\     'file.child.template': '[selection | clip | 1] [indent][icon | 1] [filename omitCenter 1]'
\   }
\ }
