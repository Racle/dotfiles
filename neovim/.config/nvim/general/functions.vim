function PlugCocUpdate()
  set shortmess=a
  set nomore
  PlugUpgrade
  PlugUpdate
  CocUpdate
endfunction

command! PlugCocUpdate call PlugCocUpdate()

function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

function MyVimEnter()
  if argc() != 0
    return
  endif

  if &ft == 'man'
    return
  endif

  if filereadable('.vim/sessions/vim.session.1')
    call LoadVimSession("1")
  else
    execute ":Files"
  endif

  "   execute "e " . v:oldfiles[0]
  " else
  "   execute ":Files"
  " endif

endfunction

function SaveVimSession(session)
  !mkdir -p .vim/sessions
  exe 'mksession! .vim/sessions/vim.session.' . a:session
endfunction

function! LoadVimSession(session)
  exe 'source .vim/sessions/vim.session.' . a:session
endfunction

function DeleteAllVimSessions()
  exe '!rm -f .vim/sessions/vim.session.*'
endfunction

function DeleteVimSession(session)
  exe '!rm -f .vim/sessions/vim.session.' . a:session
endfunction


" A global variable that contains the size of which a file is considered
" large.  In this case, it is 10 megabytes.
let g:large_file = 1024 * 1024 * 10

" This autocmd runs before reading the file into the buffer.  It
" gets the file that the autocmd is running on by running expand on
" <afile>, which is short for the path to the file that the autocmd
" is running on.  Then, it gets the size of the file running
" getfsize on the file and sees if it is larger than the size
" specified in g:large_file.  If it is, it disables the swap file.
autocmd BufReadPre * let f=expand("<afile>") | if getfsize(f)
            \ > g:large_file | set noswapfile | endif

" Documentation on hover
augroup hover
    autocmd!
    " autocmd CursorHold * silent if ! coc#float#has_float()
    "     \| call CocAction('doHover')
    " \| endif
    " autocmd CursorHoldI * silent call CocAction('showSignatureHelp')
augroup end

function ShowDocumentation()
    if ! coc#float#has_float()
       call CocAction('doHover')
    endif

endfunction

function FloatermOpenCheat()
  exe ':FloatermNew expect-spawn-zsh cheat ' . &ft
endfunction

function! CleanEmptyBuffers()
    " let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && bufwinnr(v:val)<0 && !getbufvar(v:val, "&mod")')
    let buffers = filter(range(1, bufnr('$')), 'buflisted(v:val) && empty(bufname(v:val)) && !getbufvar(v:val, "&mod")')
    if !empty(buffers)
        exe 'bw ' . join(buffers, ' ')
    endif
endfunction

function! CloseThisBuffer()
  exe 'Bdelete this'
  call CleanEmptyBuffers()
endfunction

function! AutohideFzf()
  if(&ft == "fzf")
    exe 'close'
  endif
endfunction

" https://github.com/wookayin/dotfiles/blob/master/vim/vimrc
function! s:floaterm_hide(bufnr)
  "return floaterm#window#hide_floaterm(a:bufnr)   " API removed (d7196ee0)
  execute a:bufnr . 'FloatermHide'
endfunction
function! s:autohide_floaterm() abort
  if &filetype == 'floaterm'
    " Damn, floaterm keeps changing and breaking things ...
    " e29e93b2 (2020/8/31): floaterm_winopts -> floaterm_opts
    " 2b241d7e (2021/1/3):  floaterm_opts -> floaterm_config
    " 392f3b65 (2021/1/10): No more dict, b:floaterm_wintype, etc. (why such changes?)
    let l:floaterm_wintype = get(get(b:, 'floaterm_config', get(b:, 'floaterm_opts', {})), 'wintype')
    if empty(l:floaterm_wintype) | let l:floaterm_wintype = get(b:, 'floaterm_wintype') | endif
    if l:floaterm_wintype == 'float' || l:floaterm_wintype == 'floating'
      let l:FuncHide = function('s:floaterm_hide', [bufnr('%')])   " neovim or 7.4.1836+
      call timer_start(0, { -> l:FuncHide() })
    endif
  endif
endfunction

" autoide fzf on lost focus
autocmd Filetype fzf autocmd WinLeave * call AutohideFzf()

" when leaving out from floaterm, hide it so that it doesn't cover other windows
autocmd BufLeave floaterm://*,term://*   call <SID>autohide_floaterm()
