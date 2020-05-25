" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Set relative number
set nu rnu

" Disable the default Vim startup message.
set shortmess+=I

set nocompatible

" Gruvbox setting
color gruvbox
set background=dark

" Wildmenu
set wildignorecase
set wildmenu
set completeopt=menuone,preview

filetype plugin indent on


set history=1000

if has("vms")
	set nobackup		" do not keep a backup file, use versions instead
else
	set backup		" keep a backup file (restore to previous version)
	set undofile		" keep an undo file (undo changes after closing)
endif

silent !mkdir ~/.config/nvim/{backup,swap,undo} > /dev/null 2>&1
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/
set undodir=~/.config/nvim/undo/

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set mouse+=a                            " Enable mouse
syntax enable                           " Enables syntax highlighing
set cmdheight=2                         " Give more space for displaying messages.
set hidden                              " Required to keep multiple buffers open multiple buffers
set nowrap                              " Display long lines as just one line
set encoding=utf-8                      " The encoding displayed
set fileencoding=utf-8                  " The encoding written to file
set ruler              			            " Show the cursor position all the time
set updatetime=300                      " Faster completion
set timeoutlen=100                      " By default timeoutlen is 1000 ms
set clipboard=unnamedplus               " Copy paste between vim and everything else
set autoindent                          " Good auto indent
set smartindent                         " Makes indenting smart
set smarttab                            " Makes tabbing smarter will realize you have 2 vs 4
set expandtab                           " Converts tabs to spaces
set tabstop=2                           " show existing tab with 4 spaces width
set shiftwidth=2                        " when indenting with '>', use 4 spaces width
set t_Co=256                            " Support 256 colors
set conceallevel=0                      " So that I can see `` in markdown files
set splitbelow                          " Horizontal splits will automatically be below
set splitright                          " Vertical splits will automatically be to the right
set cursorline                          " Enable highlighting of the current line
set incsearch
