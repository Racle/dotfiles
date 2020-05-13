if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  !sh -c 'curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim' 
  autocmd VimEnter * PlugInstall --sync | source ~/.config/nvim/init.vim 
  autocmd VimEnter * CocInstall coc-phpls
endif
call plug#begin(stdpath('data') . '/plugged')

  " Nerdtree
  Plug 'scrooloose/nerdtree'
  " Coc.nvim
  Plug 'neoclide/coc.nvim', {'branch': 'release'}
  " Automatic surround
  Plug 'tpope/vim-surround'
  " Gruvbox theme
  Plug 'morhetz/gruvbox'
  " fzf
  Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
  Plug 'junegunn/fzf.vim'
  " Zoom in and out of a specific split pane (similar to tmux).
  Plug 'dhruvasagar/vim-zoom'

  " Pass focus events from tmux to Vim (useful for autoread and linting tools).
  Plug 'tmux-plugins/vim-tmux-focus-events'
  Plug 'tmux-plugins/vim-tmux'
  Plug 'vim-airline/vim-airline'
  Plug 'vim-airline/vim-airline-themes'
call plug#end()	

" Map leader to space
let mapleader=" "
let maplocalleader=" "

" Change tabs with Ctrl+Tab
nnoremap th :tabnext<CR>
nnoremap tl :tabprev<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i

" Give more space for displaying messages.
set cmdheight=2

set history=1000

set hidden

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

" fzf custom settings
map <C-S-n> <Esc><Esc>:Files<CR>
" Alternative
map <Leader>f <Esc><Esc>:Files<CR>
" let g:fzf_action = { 'enter': 'tabedit' }

"keep in visual mode after shifting
vnoremap < <gv
vnoremap > >gv

" open Nerdtree
nnoremap <silent> <expr> <Leader>n g:NERDTree.IsOpen() ? "\:NERDTreeClose<CR>" : bufexists(expand('%')) ? "\:NERDTreeFind<CR>" : "\:NERDTree<CR>"
" Close NERDTree if it's last tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=2
" when indenting with '>', use 4 spaces width
set shiftwidth=2
" On pressing tab, insert 4 spaces
set expandtab

" Terminal Function
let g:term_buf = 0
let g:term_win = 0
function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

" Toggle terminal on/off (neovim)
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

" coc settings
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <silent> ög <Plug>(coc-diagnostic-prev)
nmap <silent> äg <Plug>(coc-diagnostic-next)

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" shortcut to replace command
nnoremap <Leader>r :%s///g<Left><Left>
nnoremap <Leader>rc :%s///gc<Left><Left><Left>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Change buffer
map <Leader>b <Esc><Esc>:b 

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable clipboard
set clipboard+=unnamedplus

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

" vim-airline
let g:airline#extensions#tabline#enabled = 1
:nnoremap <Tab> :bnext<CR>
:nnoremap <S-Tab> :bprevious<CR>
