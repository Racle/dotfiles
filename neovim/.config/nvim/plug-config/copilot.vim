let g:copilot_filetypes = {
  \ 'TelescopePrompt': v:false,
  \ }

" change previous/next mapping to c+k / c+j (as default C-] doesn't work with finnish layout
imap <C-k> <Plug>(copilot-previous)
imap <C-j> <Plug>(copilot-next)

" make ctrl+c work with copilot dismiss
imap <silent><script><nowait><expr> <C-c> copilot#Dismiss() . "\<C-c>"
