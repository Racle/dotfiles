" fzf custom settings
let $FZF_DEFAULT_OPTS = '--layout=reverse --info=inline'
let $FZF_DEFAULT_COMMAND="rg --smart-case --files --hidden --glob '!**/{.git,node_modules,.idea,.vscode,.history}/**'"
let g:fzf_layout = {'up':'~90%', 'window': { 'width': 0.95, 'height': 0.8,'yoffset':0.5,'xoffset': 0.5, 'highlight': 'Todo', 'border': 'sharp' } }

" Make Ripgrep ONLY search file contents and not filenames
command! -bang -nargs=* Rg
  \ call fzf#vim#grep(
  \   "rg --column --line-number --hidden --smart-case --no-heading --color=always --glob '!**/{.git,node_modules,.idea,.vscode,.history}/**' ".shellescape(<q-args>), 1,
  \   <bang>0 ? fzf#vim#with_preview({'options': '--delimiter : --nth 4..'}, 'up:60%')
  \           : fzf#vim#with_preview({'options': '--delimiter : --nth 4.. -e'}, 'right:50%', '?'),
  \   <bang>0)


" Make Ripgrep search with custom glob (ex. *.md for md files)
command! -bang -nargs=* RgFileExt call fzf#vim#grep("rg --column --line-number --hidden --smart-case --no-heading --color=always --glob '!**/{.git,node_modules,.idea,.vscode,.history}/**' -g '" . <q-args> . "' ''", 1, <bang>0)

" Ripgrep advanced, show all files
function! RipgrepFzf(query, fullscreen)
  let command_fmt = 'rg --column --line-number --no-heading --color=always --smart-case %s || true'
  let initial_command = printf(command_fmt, shellescape(a:query))
  let reload_command = printf(command_fmt, '{q}')
  let spec = {'options': ['--phony', '--query', a:query, '--bind', 'change:reload:'.reload_command]}
  call fzf#vim#grep(initial_command, 1, fzf#vim#with_preview(spec), a:fullscreen)
endfunction

command! -nargs=* -bang RG call RipgrepFzf(<q-args>, <bang>0)

" Git grep
command! -bang -nargs=* GGrep
  \ call fzf#vim#grep(
  \   'git grep --line-number '.shellescape(<q-args>), 0,
  \   fzf#vim#with_preview({'dir': systemlist('git rev-parse --show-toplevel')[0]}), <bang>0)
