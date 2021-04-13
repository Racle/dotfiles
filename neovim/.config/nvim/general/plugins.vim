call plug#begin(stdpath('data') . '/plugged')
  " Coc.nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " vim-go
  Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
  " Automatic surround
  Plug 'tpope/vim-surround'
  " commenting
  Plug 'tpope/vim-commentary'
  " Gruvbox theme
  Plug 'gruvbox-community/gruvbox'
  " airline
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  " Pass focus events from tmux to Vim (useful for autoread and linting tools).
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'tmux-plugins/vim-tmux'
  " Git plugin
  Plug 'tpope/vim-fugitive'
  Plug 'tommcdo/vim-fubitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'mhinz/vim-signify'
  " vim-prettier
  Plug 'prettier/vim-prettier', { 'do': 'npm install && npm install -g @prettier/plugin-xml @prettier/plugin-php' }
  " tagalong (tag autochange)
  Plug 'andrewradev/tagalong.vim'
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
  " Snippets
  Plug 'honza/vim-snippets'
  " Quickscope
  Plug 'unblevable/quick-scope'
  " multiple cursor
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " yank highlight
  Plug 'machakann/vim-highlightedyank'
  " undootree
  Plug 'mbbill/undotree'
  " colors / colorpicker
  Plug 'ap/vim-css-color'
  Plug 'KabbAmine/vCoolor.vim'
  " Align (:Tab /<regexp>)
  Plug 'godlygeek/tabular'
  " Enables repeat in other plugins
  Plug 'tpope/vim-repeat'
  " Quick peek for Ctrl+R and @
  Plug 'junegunn/vim-peekaboo'
  " markdown preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app & npm install'  }
  " closetags
  Plug 'alvan/vim-closetag'
  " nginx support
  Plug 'chr4/nginx.vim'
  " close-buffers
  Plug 'Asheq/close-buffers.vim'
  " GitMessenger
  Plug 'rhysd/git-messenger.vim'
  " mini-yank (fixes clipboard=unnamedplus block paste issue)
  Plug 'bfredl/nvim-miniyank'
  " blankline, | between multiline {}
  Plug 'lukas-reineke/indent-blankline.nvim', { 'branch': 'lua' }
  " VimWiki
  Plug 'vimwiki/vimwiki'
  Plug 'michal-h21/vimwiki-sync'
  " restore cursor position on file open
  Plug 'farmergreg/vim-lastplace'
  " bufferline (tabs)
  Plug 'akinsho/nvim-bufferline.lua'
  " icons
  Plug 'kyazdani42/nvim-web-devicons'
  " formatting
  Plug 'sbdchd/neoformat', {'do': 'npm install -g lua-fmt nginxbeautifier'}
  " Scrollbar
  Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
  " treesitter for highlighting
  Plug 'nvim-treesitter/nvim-treesitter'
call plug#end()


" for future
" nvim-telescope (fzf replacement, leaving for future)
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
