call plug#begin(stdpath('data') . '/plugged')

  " Nerdtree
  Plug 'scrooloose/nerdtree'
  " Coc.nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  Plug 'neoclide/coc-tsserver', {'do': 'npm install --frozen-lockfile'}
  " Automatic surround
  Plug 'tpope/vim-surround'
  " Gruvbox theme
  Plug 'morhetz/gruvbox'
  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  " Zoom in and out of a specific split pane (similar to tmux).
  Plug 'dhruvasagar/vim-zoom'

  " Pass focus events from tmux to Vim (useful for autoread and linting tools).
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " Git plugin
  Plug 'tpope/vim-fugitive'
  Plug 'tpope/vim-rhubarb'
  " emmet-vim (html autogenerate, C-y , to use ex. html:5<C-y>,)
  Plug 'mattn/emmet-vim'
  " vim-prettier
  Plug 'prettier/vim-prettier', { 'do': 'npm install' }
  " tagalong (tag autochange)
  Plug 'andrewradev/tagalong.vim'
  Plug 'tpope/vim-repeat'
  " tmux navigator
  Plug 'christoomey/vim-tmux-navigator'
  " Show keybindings
  Plug 'liuchengxu/vim-which-key'
  " floatterm
  Plug 'voldikss/vim-floaterm'
  " vim lessc
  Plug 'vitalk/vim-lesscss'
call plug#end()	
