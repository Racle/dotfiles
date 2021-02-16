" Map leader to space
let mapleader=" "
let maplocalleader=" "

" Map § to esc
noremap § <Esc>
tmap § <C-c>
nmap § <C-c>
imap § <C-c>
xmap § <C-c>

" disable digraph hotkey, works better with coc-snippets
imap <C-k> <NOP>

" ctrl+hjkl change window (better window navigation)
" imap <C-h> <C-w>h
" imap <C-j> <C-w>j
" imap <C-k> <C-w>k
" imap <C-l> <C-w>l

nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Terminal window navigation
tnoremap <C-h> <C-\><C-N><C-w>h
tnoremap <C-j> <C-\><C-N><C-w>j
tnoremap <C-k> <C-\><C-N><C-w>k
tnoremap <C-l> <C-\><C-N><C-w>l

" Terminal go back to normal mode
tnoremap :q! <C-\><C-n>:q!<CR>

" Change to insert mode with § in terminal
tnoremap § <C-\><C-n>

" Use alt + hjkl to resize windows
nnoremap <silent> <M-j>    :resize -2<CR>
nnoremap <silent> <M-k>    :resize +2<CR>
nnoremap <silent> <M-h>    :vertical resize -2<CR>
nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Auto completion with tab + enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Change tabs
nnoremap th :tabnext<CR>
nnoremap tl :tabprev<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i


" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Toggle paste mode
nnoremap <F2> :set invpaste paste?<CR>
set pastetoggle=<F2>

" shortcut to replace command
nnoremap <Leader>r :%s///g<Left><Left><Left>
nnoremap <Leader>R :%s///gc<Left><Left><Left><Left>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

"  shortcut to ripgrep advanced
nnoremap <Leader>F :RgFileExt *.

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

"keep in visual mode after shifting
vnoremap < <gv
vnoremap > >gv

" Close NERDTree if it's last tab
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Close buffer
" map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" open files with ctrl+n
" map <C-S-n> <Esc><Esc>:Files<CR>

" ctrl+s => save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Q == q
command! Q q

" Map Ctrl-Backspace to delete the previous word in insert mode.
imap <C-BS> <C-W>

" Swap , and ;
nnoremap , ;
nnoremap ; ,

" Change word under cursor
nnoremap c. :%s/\<<C-r><C-w>\>//gc<Left><Left><Left>

" fixes clipboard=unnamedplus block copy/paste issue
map p <Plug>(miniyank-autoput)
map P <Plug>(miniyank-autoPut)

" show documentation with gh
nmap <silent> gh :call ShowDocumentation()<CR>

" map öä {} ÖÄ []
" Bug: ubuntu outputs :/' when usint with ctrl
set langmap=öäÖÄ;{}[]

nmap [Ö [[
nmap ]Ä ]]
map Ä ]
