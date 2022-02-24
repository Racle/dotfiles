" Other mappings locations:
" plug-config/which-key.vim
" lua/general/mappings.lua
" lua/plug-config/bufferline.lua
" lua/plug-config/telescope.lua

" Map leader to space
let mapleader=" "
let maplocalleader=" "

" Map § to esc
noremap § <Esc>
tnoremap § <Esc>
nnoremap § <Esc>
xnoremap § <Esc>
" inoremap § <Esc> " mapped in coc.vim

" disable digraph hotkey, works better with coc-snippets
imap <C-k> <NOP>

" ctrl+hjkl change window (better window navigation)
" imap <C-h> <C-w>h
" imap <C-j> <C-w>j
" imap <C-k> <C-w>k
" imap <C-l> <C-w>l

" Navigate quickfix list
nmap <M-K> :cp<CR>
nmap <M-J> :cn<CR>

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

" Use alt + hjkl to resize windows (moved to mappings.lua)
" nnoremap <silent> <M-j>    :resize -2<CR>
" nnoremap <silent> <M-k>    :resize +2<CR>
" nnoremap <silent> <M-h>    :vertical resize -2<CR>
" nnoremap <silent> <M-l>    :vertical resize +2<CR>

" Auto completion with tab + enter in insert mode and command mode
inoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" cnoremap <expr> <CR> pumvisible() ? "\<C-e>" : "\<CR>"
" nvim 0.5 uses this
cnoremap <expr> <CR> pumvisible() ? "\<C-y>" : "\<CR>"

" Change tabs
nnoremap th :tabnext<CR>
nnoremap tl :tabprev<CR>
" inoremap <C-S-tab> <Esc>:tabprevious<CR>i
" inoremap <C-tab>   <Esc>:tabnext<CR>i

" change jumplist forward to <c-p>
nnoremap <C-P> <Tab>

" Change buffers
" Changed to bufferline.lua
" nmap <Tab> [b
" nmap <S-Tab> b]

" Unbind some useless/annoying default key bindings.
nmap Q :echo "Use gQ to enter Ex mode."<CR>

" Toggle paste mode
nnoremap <F9> :set invpaste paste?<CR>
set pastetoggle=<F9>

" Toggle custom MacroMode
nnoremap <F10> :MacroMode<CR>

" shortcut to replace command
nnoremap <leader>r :%s///g<Left><Left><Left>
nnoremap <leader>R :%s///gc<Left><Left><Left><Left>

" Quickly insert an empty new line without entering insert mode
nnoremap <leader>o o<Esc>
nnoremap <leader>O O<Esc>

"  shortcut to ripgrep advanced
nnoremap <leader>fF :RgFileExt *.

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

"keep in visual mode after shifting
vnoremap < <gv
vnoremap > >gv

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
vmap p <Plug>(miniyank-autoput)
vmap P <Plug>(miniyank-autoPut)
nmap p <Plug>(miniyank-autoput)
nmap P <Plug>(miniyank-autoPut)

" github copilot mappings in copilot.vim


" show documentation with gh
nmap <silent> gh :call <SID>show_documentation()<CR>
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" map öä {} ÖÄ []
" Bug: ubuntu outputs :/' when usint with ctrl
set langmap=öäÖÄ;{}[]

nmap [Ö [[
nmap ]Ä ]]
map Ä ]

" fix for highlightedyank if needed
" map y <Plug>(highlightedyank)


" do not copy text in register when using ex. ciw
nnoremap c "_c
