let g:firenvim_config = {
    \ 'localSettings': {
        \ 'https://github\.com/': {
            \ 'takeover': 'never',
        \ },
        \ '.*': {
            \ 'takeover': 'never',
        \ },
    \ }
\ }

set laststatus=0
set guifont=Hack:h9
au BufEnter github.com_*.txt set filetype=markdown
au BufEnter *ipynb*.txt set filetype=python
au BufEnter *_lab_* set filetype=python
