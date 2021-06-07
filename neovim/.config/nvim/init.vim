if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim
  autocmd VimEnter * CocInstall
endif

source ~/.config/nvim/general/plugins.vim
source ~/.config/nvim/general/functions.vim
source ~/.config/nvim/general/mappings.vim
source ~/.config/nvim/general/settings.vim

" Plugins
source ~/.config/nvim/plug-config/which-key.vim
source ~/.config/nvim/plug-config/fzf.vim
source ~/.config/nvim/plug-config/prettier.vim
source ~/.config/nvim/plug-config/coc.vim
source ~/.config/nvim/plug-config/tagalong.vim
source ~/.config/nvim/plug-config/floatterm.vim
source ~/.config/nvim/plug-config/vimlesscss.vim
source ~/.config/nvim/plug-config/quickscope.vim
source ~/.config/nvim/plug-config/highlightedyank.vim
source ~/.config/nvim/plug-config/signify.vim
source ~/.config/nvim/plug-config/visual-multi.vim
source ~/.config/nvim/plug-config/closetag.vim
source ~/.config/nvim/plug-config/tmux-navigator.vim
source ~/.config/nvim/plug-config/git-messenger.vim
source ~/.config/nvim/plug-config/go.vim
source ~/.config/nvim/plug-config/vimwiki.vim
source ~/.config/nvim/plug-config/suda.vim

" Lua config
luafile ~/.config/nvim/lua/general/mappings.lua
luafile ~/.config/nvim/lua/plug-config/bufferline.lua
luafile ~/.config/nvim/lua/plug-config/blankline.lua
luafile ~/.config/nvim/lua/plug-config/scrollview.lua
luafile ~/.config/nvim/lua/plug-config/treesitter.lua
" luafile ~/.config/nvim/lua/plug-config/telescope.lua
luafile ~/.config/nvim/lua/plug-config/gitsigns.lua
luafile ~/.config/nvim/lua/plug-config/nvim-ts-context-commentstring.lua
luafile ~/.config/nvim/lua/plug-config/formatter.lua
luafile ~/.config/nvim/lua/plug-config/lualine.lua

" server settings
call SourceIfExists('~/.config/nvim/server-init.vim')
