let $NVIM_TUI_ENABLE_CURSOR_SHAPE=0
set guicursor=
autocmd OptionSet guicursor noautocmd set guicursor=
set notermguicolors
" Plug 'vim-airlinerequire("dapui").setup()/vim-airline', { 'on': [] }
" Plug 'vim-airline/vim-airline-themes', { 'on': [] }
luafile $NVIMPATH/lua/plug-config/bufferline-server.lua
luafile $NVIMPATH/lua/plug-config/lualine.lua
set notermguicolors
