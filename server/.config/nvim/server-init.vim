let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=
set notermguicolors
" Plug 'vim-airline/vim-airline', { 'on': [] }
" Plug 'vim-airline/vim-airline-themes', { 'on': [] }
luafile ~/.config/nvim/lua/plug-config/bufferline-server.lua
set notermguicolors
