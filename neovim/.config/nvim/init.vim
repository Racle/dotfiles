if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim 
  autocmd VimEnter * CocInstall coc-phpls
endif

source ~/.config/nvim/general/plugins.vim
source ~/.config/nvim/general/settings.vim
source ~/.config/nvim/keys/mappings.vim

" Plugins
source ~/.config/nvim/plug-config/fzf.vim
source ~/.config/nvim/plug-config/airline.vim
source ~/.config/nvim/plug-config/prettier.vim
source ~/.config/nvim/plug-config/coc.vim
