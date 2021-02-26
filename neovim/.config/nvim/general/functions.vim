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
