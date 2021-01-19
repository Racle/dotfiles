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

silent !mkdir ~/.config/nvim/{backup,swap,undo} > /dev/null 2>&1
set backupdir=~/.config/nvim/backup/
set directory=~/.config/nvim/swap/
set undodir=~/.config/nvim/undo/

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
set signcolumn=yes

set confirm                 " Set confirm when closing buffer
set mouse+=a                " Enable mouse
syntax enable               " Enables syntax highlighing
set cmdheight=2             " Give more space for displaying messages.
set hidden                  " Required to keep multiple buffers open multiple buffers
set nowrap                  " Display long lines as just one line
set list                    " required for listchars
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
set tabstop=2               " show existing tab with 4 spaces width
set shiftwidth=2            " when indenting with '>', use 4 spaces width
set t_Co=256                " Support 256 colors
set conceallevel=0          " So that I can see `` in markdown files
set splitbelow              " Horizontal splits will automatically be below
set splitright              " Vertical splits will automatically be to the right
set cursorline              " Enable highlighting of the current line
set incsearch               " incremental search, automatically go to next search
set ignorecase              " incase sensitive search
set smartcase               " smarcase search
set nu rnu                  " set relative number
set shortmess+=I            " Disable the default Vim startup message.
set nocompatible            " ignored in nvim
set inccommand=nosplit      " realtime substitute s/search/replace/g
set termguicolors           " Gruvbox recommended
set listchars=extends:>,precedes:<,tab:\ \ , " show character on longer line

" trigger `autoread` when files changes on disk
set autoread
" autocmd FocusGained,BufEnter,CursorHold,CursorHoldI * if mode() != 'c' | checktime | endif
autocmd! FocusGained,BufEnter,CursorHold,CursorHoldI * silent! checktime
" notification after file change
autocmd FileChangedShellPost *
  \ echohl WarningMsg | echo "File changed on disk. Buffer reloaded." | echohl None

" The 'nested' before call allows nested autocmds, important for
" syntax detection etc.
autocmd VimEnter * nested call MyVimEnter()

" disable first click when gaining back focus
autocmd FocusGained * set mouse+=a
autocmd FocusLost * set mouse=

" golang indent fix. exec for fixing automatic trailing whitespace removing
exec 'set lcs=tab:\┊\ '
let g:indentLine_char_list = ['|', '¦', '┆', '┊']

" identLine fix for json files and missing "
autocmd Filetype json :IndentLinesDisable
