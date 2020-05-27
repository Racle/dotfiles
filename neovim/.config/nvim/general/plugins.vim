call plug#begin(stdpath('data') . '/plugged')
  " Coc.nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
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
  Plug 'tommcdo/vim-fubitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'mhinz/vim-signify'
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
  " remote yank
  Plug 'fcpg/vim-osc52'
  " snippets
  Plug 'honza/vim-snippets'
  " auto-pairs
  Plug 'jiangmiao/auto-pairs'
  " tagbar (function name on vim-airline)
  Plug 'majutsushi/tagbar'
  " Quickscope
  Plug 'unblevable/quick-scope'
  " multiple cursor
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " yank highlight
  Plug 'machakann/vim-highlightedyank'
call plug#end()
