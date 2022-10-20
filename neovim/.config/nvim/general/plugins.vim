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
  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  Plug 'airblade/vim-rooter'
  " Neovim library plugin
  Plug 'nvim-lua/plenary.nvim'
  " Git plugin
  Plug 'tpope/vim-fugitive'
  Plug 'tommcdo/vim-fubitive'
  Plug 'tpope/vim-rhubarb'
  Plug 'junegunn/gv.vim'
  Plug 'lewis6991/gitsigns.nvim'
  " Formatting / prettier
  Plug 'mhartington/formatter.nvim', {'do': 'npm install -g lua-fmt nginxbeautifier prettier @prettier/plugin-xml @prettier/plugin-php'}
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
  Plug 'vitalk/vim-lesscss', { 'do': 'npm install -g less minify'}
  " remote yank
  Plug 'ojroques/vim-oscyank', {'branch': 'main'}
  " Snippets
  Plug 'honza/vim-snippets'
  " Quickscope
  Plug 'unblevable/quick-scope'
  " multiple cursor
  Plug 'mg979/vim-visual-multi', {'branch': 'master'}
  " undootree
  Plug 'mbbill/undotree'
  " colorpicker
  " Plug 'ap/vim-css-color' coc-css does same thing
  Plug 'KabbAmine/vCoolor.vim'
  " Align (:Tab /<regexp>)
  Plug 'godlygeek/tabular'
  " Enables repeat in other plugins
  Plug 'tpope/vim-repeat'
  " Quick peek for Ctrl+R and @
  Plug 'junegunn/vim-peekaboo'
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
  Plug 'lukas-reineke/indent-blankline.nvim'
  " VimWiki
  Plug 'vimwiki/vimwiki'
  Plug 'michal-h21/vimwiki-sync'
  " restore cursor position on file open
  Plug 'farmergreg/vim-lastplace'
  " bufferline (tabs)
  Plug 'akinsho/nvim-bufferline.lua'
  " lualine, airline replacement
  Plug 'nvim-lualine/lualine.nvim'
  " icons
  Plug 'kyazdani42/nvim-web-devicons'
  " Scrollbar
  Plug 'dstein64/nvim-scrollview', { 'branch': 'main' }
  " treesitter for highlighting
  Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
  Plug 'nvim-treesitter/nvim-treesitter-textobjects'
  " javascript context commenting (different commenting to html tags and js parts on same file)
  Plug 'JoosepAlviste/nvim-ts-context-commentstring'
  " better text object support while using ex. ci"
  Plug 'wellle/targets.vim'
  " Markdown preview
  Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && npm install'  }
  " add sudo permission to write/read operations
  Plug 'lambdalisue/suda.vim'
  " Show functions/methods <leader>lv
  Plug 'liuchengxu/vista.vim'
  " Better wildmenu
  Plug 'gelguy/wilder.nvim', { 'do': ':UpdateRemotePlugins' }
  " extra library
  Plug 'MunifTanjim/nui.nvim'
  " Telescope
  Plug 'nvim-telescope/telescope.nvim'
  Plug 'nvim-lua/plenary.nvim'
  Plug 'nvim-lua/popup.nvim'
  Plug 'nvim-telescope/telescope-media-files.nvim', { 'do': 'pip3 install --upgrade ueberzug' }
  " Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
  " Github copilot
  Plug 'github/copilot.vim'
  " File explorer
  Plug 'kyazdani42/nvim-tree.lua'
  " Database view/explorer
  Plug 'tpope/vim-dadbod'
  Plug 'kristijanhusak/vim-dadbod-ui'
  " % matches to functions etc
  Plug 'andymass/vim-matchup'
  " Quick jumping around
  Plug 'ggandor/lightspeed.nvim'
  " smooth scrolling
  Plug 'karb94/neoscroll.nvim'
  " smooth scrolling
  Plug 'karb94/neoscroll.nvim'
call plug#end()


" for future
" nvim-telescope (fzf replacement, leaving for future)
" Plug 'nvim-lua/popup.nvim'
" Plug 'nvim-lua/plenary.nvim'
