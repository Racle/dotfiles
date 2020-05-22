" Map leader to space
let mapleader=" "
let maplocalleader=" "

" Auto completion with tab + enter
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Change tabs 
nnoremap th :tabnext<CR>
nnoremap tl :tabprev<CR>
inoremap <C-S-tab> <Esc>:tabprevious<CR>i
inoremap <C-tab>   <Esc>:tabnext<CR>i

" Terminal go back to normal mode
tnoremap <Esc> <C-\><C-n>
tnoremap :q! <C-\><C-n>:q!<CR>

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
map <leader>q :bp<bar>sp<bar>bn<bar>bd<CR>

" open files with ctrl+n
" map <C-S-n> <Esc><Esc>:Files<CR>

" esc to close terminal
tnoremap <Esc> <C-\><C-n>

" ctrl+s => save
noremap <silent> <C-S>          :update<CR>
vnoremap <silent> <C-S>         <C-C>:update<CR>
inoremap <silent> <C-S>         <C-O>:update<CR>

" Q == q
command Q q
