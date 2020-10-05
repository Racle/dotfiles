function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction

function MyVimEnter()
  if argc() != 0
    return
  endif

  execute ":Files"

  " if exists("v:oldfiles[0]") && filereadable(expand(v:oldfiles[0]))
  "   execute "e " . v:oldfiles[0]
  " else
  "   execute ":Files"
  " endif

endfunction

function SaveVimSession(session)
  !mkdir -p .vim/sessions
  exe 'mksession! .vim/sessions/vim.session.' . a:session
  echo 'mksession! .vim/sessions/vim.session.' . a:session
endfunction


function! LoadVimSession(session)
  exe 'source .vim/sessions/vim.session.' . a:session
endfunction
