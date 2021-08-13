" Gruvbox setting
color gruvbox
set background=dark
let g:gruvbox_contrast_dark = 'hard'
let g:gruvbox_sign_column ='dark0'
let g:gruvbox_invert_selection='0'
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"

" Wildmenu
set wildignorecase
set wildmenu
set completeopt=menuone,preview
set wildmode=longest:full,full  " autocomplete like bash/zsh

filetype plugin indent on

" remove trailing whitespace on save
autocmd BufWritePre * %s/\s\+$//e

set history=1000

if has("vms")
  set nobackup                            " do not keep a backup file, use versions instead
else
  set backup                              " keep a backup file (restore to previous version)
  set undofile                            " keep an undo file (undo changes after closing)
endif

silent !mkdir $NVIMPATH/{backup,swap,undo} > /dev/null 2>&1
set backupdir=$NVIMPATH/backup/
set directory=$NVIMPATH/swap/
set undodir=$NVIMPATH/undo/

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set confirm                 " Set confirm when closing buffer
set mouse+=a                " Enable mouse
syntax enable               " Enables syntax highlighing
set cmdheight=2             " Give more space for displaying messages.
set hidden                  " Required to keep multiple buffers open multiple buffers
set nowrap                  " Display long lines as just one line
set list                    " Required for listchars
set encoding=utf-8          " The encoding displayed
set fileencoding=utf-8      " The encoding written to file
set ruler                   " Show the cursor position all the time
set updatetime=300          " Faster completion
set timeoutlen=300          " By default timeoutlen is 1000 ms
set clipboard=unnamedplus   " Copy paste between vim and everything else
set autoindent              " Good auto indent
set smartindent             " Makes indenting smart
set smarttab                " Makes tabbing smarter will realize you have 2 vs 4
set expandtab               " Converts tabs to spaces
set tabstop=2               " Show existing tab with 4 spaces width
set shiftwidth=2            " When indenting with '>', use 4 spaces width
set t_Co=256                " Support 256 colors
set conceallevel=0          " So that I can see `` in markdown files
set splitbelow              " Horizontal splits will automatically be below
set splitright              " Vertical splits will automatically be to the right
set cursorline              " Enable highlighting of the current line
set incsearch               " Incremental search, automatically go to next search
set ignorecase              " Incase sensitive search
set smartcase               " Smarcase search
set nu rnu                  " Set relative number
set shortmess+=I            " Disable the default Vim startup message.
set nocompatible            " Ignored in nvim
set inccommand=nosplit      " Realtime substitute s/search/replace/g
set termguicolors           " Gruvbox recommended
set listchars=extends:>,precedes:<,tab:\ \ , " show character on longer line
set colorcolumn=99999       " https://github.com/lukas-reineke/indent-blankline.nvim/issues/59#issuecomment-806374954
" set sessionoptions-=buffers " Don't save hidden and unloaded buffers in sessions.
set sessionoptions-=options " Don't persist options and mappings because it can corrupt sessions.
set sessionoptions-=blank   " Remove blank buffers/windows in sessions.

" trigger `autoread` when files changes on disk
set autoread
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
" notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" The 'nested' before call allows nested autocmds, important for
" syntax detection etc.
autocmd! VimEnter * nested call MyVimEnter()

" disable first click when gaining back focus with 100ms delay
autocmd FocusGained *  call timer_start(100, { tid -> execute('set mouse+=a')})
autocmd FocusLost * set mouse=

" autoide fzf and floaterm on lost focus and configs found in functions.vim

" fix for IndentBlankline on golang files
autocmd FileType go autocmd BufWritePost,TextChanged * exe ":IndentBlanklineRefresh"

" fix vimscript highlighting
au Syntax vim syn match vimUsrCmd '^\s*\zs\u\%(\w*\)\@>(\@!'

" Highlighted yank
au TextYankPost * silent! lua vim.highlight.on_yank{timeout=250}
