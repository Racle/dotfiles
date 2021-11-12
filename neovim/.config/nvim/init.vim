if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $NVIMPATH/init.vim
  autocmd VimEnter * CocInstall
endif

" nvim config path to variable for windows support
let $NVIMPATH = fnamemodify($MYVIMRC, ':p:h')

source $NVIMPATH/general/plugins.vim
source $NVIMPATH/general/functions.vim
source $NVIMPATH/general/mappings.vim
source $NVIMPATH/general/settings.vim

" Plugins
source $NVIMPATH/plug-config/which-key.vim
source $NVIMPATH/plug-config/fzf.vim
source $NVIMPATH/plug-config/prettier.vim
source $NVIMPATH/plug-config/coc.vim
source $NVIMPATH/plug-config/tagalong.vim
source $NVIMPATH/plug-config/floatterm.vim
source $NVIMPATH/plug-config/vimlesscss.vim
source $NVIMPATH/plug-config/quickscope.vim
source $NVIMPATH/plug-config/highlightedyank.vim
source $NVIMPATH/plug-config/signify.vim
source $NVIMPATH/plug-config/visual-multi.vim
source $NVIMPATH/plug-config/closetag.vim
source $NVIMPATH/plug-config/tmux-navigator.vim
source $NVIMPATH/plug-config/git-messenger.vim
source $NVIMPATH/plug-config/go.vim
source $NVIMPATH/plug-config/vimwiki.vim
source $NVIMPATH/plug-config/suda.vim
source $NVIMPATH/plug-config/vista.vim
source $NVIMPATH/plug-config/vcoolor.vim
source $NVIMPATH/plug-config/wilder.vim
source $NVIMPATH/plug-config/rooter.vim
source $NVIMPATH/plug-config/copilot.vim

" Lua config
luafile $NVIMPATH/lua/general/mappings.lua
luafile $NVIMPATH/lua/plug-config/bufferline.lua
luafile $NVIMPATH/lua/plug-config/blankline.lua
luafile $NVIMPATH/lua/plug-config/scrollview.lua
luafile $NVIMPATH/lua/plug-config/treesitter.lua
luafile $NVIMPATH/lua/plug-config/telescope.lua
luafile $NVIMPATH/lua/plug-config/gitsigns.lua
luafile $NVIMPATH/lua/plug-config/nvim-ts-context-commentstring.lua
luafile $NVIMPATH/lua/plug-config/formatter.lua
luafile $NVIMPATH/lua/plug-config/lualine.lua
luafile $NVIMPATH/lua/plug-config/package-info.lua

" server settings
call ServerfixCommandIfFileExists()

" firenvim config
if exists('g:started_by_firenvim')
  source $NVIMPATH/plug-config/firenvim.vim
endif
