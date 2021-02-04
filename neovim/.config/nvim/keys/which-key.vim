" https://github.com/ChristianChiarulli/nvim/blob/master/keys/which-key.vim
" Map leader to which_key
nnoremap <silent> <leader> :silent <c-u> :silent WhichKey '<Space>'<CR>
vnoremap <silent> <leader> :silent <c-u> :silent WhichKeyVisual '<Space>'<CR>
"set timeoutlen=500

" Create map to add keys to
let g:which_key_map =  {}
" Define a separator
let g:which_key_sep = '→'

" Not a fan of floating windows for this
let g:which_key_use_floating_win = 0

" Change the colors if you want
highlight default link WhichKey          Operator
highlight default link WhichKeySeperator DiffAdded
highlight default link WhichKeyGroup     Identifier
highlight default link WhichKeyDesc      Function

" Hide status line
autocmd! FileType which_key
autocmd  FileType which_key set laststatus=0 noshowmode noruler
  \| autocmd BufLeave <buffer> set laststatus=2 noshowmode ruler


" Single mappings
let g:which_key_map['e'] = [ ':CocCommand explorer', 'Explorer']
let g:which_key_map['n'] = [ ':Files', 'Search files']
let g:which_key_map['f'] = [ ':Rg', 'Search text']
let g:which_key_map['F'] = 'Search text with ext'
let g:which_key_map['p'] = 'Prettier'
let g:which_key_map['r'] = 'replace'
let g:which_key_map['R'] = 'replace (confirm)'
let g:which_key_map['q'] = 'close buffer (:bd)'
let g:which_key_map['o'] = 'new line down'
let g:which_key_map['O'] = 'new line up'
let g:which_key_map['q'] = [ ':Bdelete this', 'close-buffer']
let g:which_key_map['Q'] = [ ':Bdelete! this', 'close-buffer!']
" Group mappings

" a is for actions
let g:which_key_map.a = {
      \ 'name' : '+actions' ,
      \ 'c' : [':ColorizerToggle'        , 'colorizer'],
      \ 'e' : [':CocCommand explorer'    , 'explorer'],
      \ 'n' : [':set nonumber!'          , 'line-numbers'],
      \ 'r' : [':set norelativenumber!'  , 'relative line nums'],
      \ 's' : [':let @/ = ""'            , 'remove search highlight'],
      \ 'S' : [':CocCommand cSpell.toggleEnableSpellChecker'            , 'toggle spellchecking'],
      \ 'L' : 'Toggle lesscss',
      \ 'm' : ['<Plug>MarkdownPreviewToggle'            , 'toggle markdown preview'],
      \ 'M' : [':SignatureToggleSigns'            , 'toggle mark sings'],
      \ 'G' : [':SignifyToggle'            , 'toggle git sings'],
      \ 't' : [':FloatermToggle'         , 'terminal'],
      \ 'u' : [':UndotreeToggle | UndotreeFocus'         , 'Undotree'],
      \ 'v' : [':VCoolor'                , 'vcoolor picker'],
      \ 'y' : [':call SendViaOSC52(getreg("))'                , 'remote yank'],
      \ 'w' : ['<Plug>(coc-codeaction-selected)w'                , 'spell check word'],
      \ }

" b is for buffer
let g:which_key_map.b = {
      \ 'name' : '+buffer' ,
      \ '1' : ['b1'        , 'buffer 1']        ,
      \ '2' : ['b2'        , 'buffer 2']        ,
      \ 'f' : ['bfirst'    , 'first-buffer']    ,
      \ 'l' : ['blast'     , 'last-buffer']     ,
      \ 'o' : [':Bdelete other'     , 'close other buffers']     ,
      \ 'd' : [':Bdelete menu'     , 'close menu']     ,
      \ 'n' : [':enew'     , 'new buffer']     ,
      \ 'V' : [':vsp'     , 'new vertical split']     ,
      \ 'H' : [':sp'     , 'new horizontal split']     ,
      \ 'v' : [':vnew'     , 'new vertical buffer']     ,
      \ 'h' : [':new'     , 'new horizontal buffer']     ,
      \ 'w' : ['Buffers'   , 'fzf-buffer']      ,
      \ 'q' : [':Bdelete this'        , 'close-buffer']   ,
      \ 'Q' : [':Bdelete! this'        , 'close-buffer!']   ,
      \ }
" custom mappings

" vim sessions
let g:which_key_map.S = {
      \ 'name' : '+sessions' ,
      \ 's' : {
              \ 'name': '+save',
              \ 's': ["SaveVimSession(1)"     , 'save 1'],
              \ '1': ['SaveVimSession(1)'     , 'save 1'],
              \ '2': ['SaveVimSession(2)'     , 'save 2'],
              \ '3': ['SaveVimSession(3)'     , 'save 3'],
              \ '4': ['SaveVimSession(4)'     , 'save 4'],
              \ '5': ['SaveVimSession(5)'     , 'save 5'],
              \ '6': ['SaveVimSession(6)'     , 'save 6'],
              \ '7': ['SaveVimSession(7)'     , 'save 7'],
              \ '8': ['SaveVimSession(8)'     , 'save 8'],
              \ '9': ['SaveVimSession(9)'     , 'save 9'],
              \ '0': ['SaveVimSession(0)'     , 'save 0'],
              \ },
      \ 'l' : {
              \ 'name': '+load',
              \ 'l': ['LoadVimSession(1)'     , 'load 1'],
              \ '1': ['LoadVimSession(1)'     , 'load 1'],
              \ '2': ['LoadVimSession(2)'     , 'load 2'],
              \ '3': ['LoadVimSession(3)'     , 'load 3'],
              \ '4': ['LoadVimSession(4)'     , 'load 4'],
              \ '5': ['LoadVimSession(5)'     , 'load 5'],
              \ '6': ['LoadVimSession(6)'     , 'load 6'],
              \ '7': ['LoadVimSession(7)'     , 'load 7'],
              \ '8': ['LoadVimSession(8)'     , 'load 8'],
              \ '9': ['LoadVimSession(9)'     , 'load 9'],
              \ '0': ['LoadVimSession(0)'     , 'load 0'],
              \ },
      \ 'd' : {
              \ 'name': '+delete',
              \ 'a': ['DeleteAllVimSessions()'     , 'delete all'],
              \ '1': ['DeleteVimSession(1)'     , 'delete 1'],
              \ '2': ['DeleteVimSession(2)'     , 'delete 2'],
              \ '3': ['DeleteVimSession(3)'     , 'delete 3'],
              \ '4': ['DeleteVimSession(4)'     , 'delete 4'],
              \ '5': ['DeleteVimSession(5)'     , 'delete 5'],
              \ '6': ['DeleteVimSession(6)'     , 'delete 6'],
              \ '7': ['DeleteVimSession(7)'     , 'delete 7'],
              \ '8': ['DeleteVimSession(8)'     , 'delete 8'],
              \ '9': ['DeleteVimSession(9)'     , 'delete 9'],
              \ '0': ['DeleteVimSession(0)'     , 'delete 0'],
              \ },
      \ }

" s is for search
let g:which_key_map.s = {
      \ 'name' : '+search' ,
      \ '/' : [':History/'     , 'history'],
      \ ';' : [':Commands'     , 'commands'],
      \ 'a' : [':Ag'           , 'text Ag'],
      \ 'b' : [':BLines'       , 'current buffer'],
      \ 'B' : [':Buffers'      , 'open buffers'],
      \ 'c' : [':Commits'      , 'commits'],
      \ 'C' : [':BCommits'     , 'buffer commits'],
      \ 'f' : [':Files'        , 'files'],
      \ 'g' : [':GFiles'       , 'git files'],
      \ 'G' : [':GFiles?'      , 'modified git files'],
      \ 'h' : [':History'      , 'file history'],
      \ 'H' : [':History:'     , 'command history'],
      \ 'l' : [':Lines'        , 'lines'] ,
      \ 'm' : [':Marks'        , 'marks'] ,
      \ 'M' : [':Maps'         , 'normal maps'] ,
      \ 'p' : [':Helptags'     , 'help tags'] ,
      \ 'P' : [':Tags'         , 'project tags'],
      \ 's' : [':Snippets'     , 'snippets'],
      \ 'S' : [':Colors'       , 'color schemes'],
      \ 't' : [':Rg'           , 'text Rg'],
      \ 'T' : [':BTags'        , 'buffer tags'],
      \ 'w' : [':Windows'      , 'search windows'],
      \ 'y' : [':Filetypes'    , 'file types'],
      \ 'z' : [':FZF'          , 'FZF'],
      \ }

let g:which_key_map.G = {
      \ 'name' : '+git diff'  ,
      \ 'D' : [':Gdiffsplit!' , 'diff split'],
      \ 'H' : [':diffget //2' , 'diffget from right'],
      \ 'L' : [':diffget //3' , 'diffget from left'],
      \ 'J' : [']c'           , 'prev change'],
      \ 'K' : ['[c'           , 'next change'],
      \ 'm' : [':!meld . &'   , 'open meld mergetool'],
      \ }

" g is for git
let g:which_key_map.g = {
      \ 'name' : '+git'                         ,
      \ 'a' : [':Git add .'                     , 'add all'],
      \ 'A' : [':Git add %'                     , 'add current'],
      \ 'b' : [':Git blame'                     , 'blame'],
      \ 'B' : [':GBrowse'                       , 'browse'],
      \ 'c' : [':Git commit'                    , 'commit'],
      \ 'd' : [':Git diff'                      , 'diff'],
      \ 'D' : [':Gdiffsplit!'                   , 'diff split'],
      \ 'g' : [':GGrep'                         , 'git grep'],
      \ 'G' : [':Gstatus'                       , 'status'],
      \ 'h' : [':GitGutterLineHighlightsToggle' , 'highlight hunks'],
      \ 'H' : ['<Plug>(GitGutterPreviewHunk)'   , 'preview hunk'],
      \ 'j' : ['<Plug>(signify-next-hunk)'      , 'next hunk'],
      \ 'k' : ['<Plug>(signify-prev-hunk)'      , 'prev hunk'],
      \ 'l' : [':Git log'                       , 'log'],
      \ 'm' : 'git messenger',
      \ 'M' : [':!meld . &'                     , 'open meld mergetool'],
      \ 'P' : [':Git push'                      , 'push'],
      \ 'p' : [':Git pull'                      , 'pull'],
      \ 'r' : [':GRemove'                       , 'remove'],
      \ 's' : ['<Plug>(GitGutterStageHunk)'     , 'stage hunk'],
      \ 't' : [':GitGutterSignsToggle'          , 'toggle signs'],
      \ 'u' : ['<Plug>(GitGutterUndoHunk)'      , 'undo hunk'],
      \ 'v' : [':GV'                            , 'view commits'],
      \ 'V' : [':GV!'                           , 'view buffer commits'],
      \ '>' : [':diffget //2'                   , 'diffget from left'],
      \ '<' : [':diffget //3'                   , 'diffget from right'],
      \ }

" l is for language server protocol
let g:which_key_map.l = {
      \ 'name' : '+lsp' ,
      \ '.' : [':CocConfig'                          , 'config'],
      \ ';' : ['<Plug>(coc-refactor)'                , 'refactor'],
      \ 'a' : ['<Plug>(coc-codeaction)'              , 'line action'],
      \ 'A' : ['<Plug>(coc-codeaction-selected)'     , 'selected action'],
      \ 'b' : [':CocNext'                            , 'next action'],
      \ 'B' : [':CocPrev'                            , 'prev action'],
      \ 'c' : [':CocList commands'                   , 'commands'],
      \ 'd' : ['<Plug>(coc-definition)'              , 'definition'],
      \ 'D' : ['<Plug>(coc-declaration)'             , 'declaration'],
      \ 'e' : [':CocList extensions'                 , 'extensions'],
      \ 'f' : ['<Plug>(coc-format-selected)'         , 'format selected'],
      \ 'F' : ['<Plug>(coc-format)'                  , 'format'],
      \ 'h' : ['<Plug>(coc-float-hide)'              , 'hide'],
      \ 'i' : ['<Plug>(coc-implementation)'          , 'implementation'],
      \ 'I' : [':CocList diagnostics'                , 'diagnostics'],
      \ 'j' : ['<Plug>(coc-float-jump)'              , 'float jump'],
      \ 'l' : ['<Plug>(coc-codelens-action)'         , 'code lens'],
      \ 'n' : ['<Plug>(coc-diagnostic-next)'         , 'next diagnostic'],
      \ 'N' : ['<Plug>(coc-diagnostic-next-error)'   , 'next error'],
      \ 'o' : ['<Plug>(coc-openlink)'                , 'open link'],
      \ 'O' : [':CocList outline'                    , 'outline'],
      \ 'p' : ['<Plug>(coc-diagnostic-prev)'         , 'prev diagnostic'],
      \ 'P' : ['<Plug>(coc-diagnostic-prev-error)'   , 'prev error'],
      \ 'q' : ['<Plug>(coc-fix-current)'             , 'quickfix'],
      \ 'r' : ['<Plug>(coc-rename)'                  , 'rename'],
      \ 'R' : ['<Plug>(coc-references)'              , 'references'],
      \ 's' : 'search',
      \ 'S' : 'search word',
      \ 't' : ['<Plug>(coc-type-definition)'         , 'type definition'],
      \ 'u' : [':CocListResume'                      , 'resume list'],
      \ 'U' : [':CocUpdate'                          , 'update CoC'],
      \ 'v' : [':Vista!!'                            , 'tag viewer'],
      \ 'z' : [':CocDisable'                         , 'disable CoC'],
      \ 'Z' : [':CocEnable'                          , 'enable CoC'],
      \ }

" a is for actions
let g:which_key_map.T = {
      \ 'name' : '+Tabularize' ,
      \ '=' : [':Tabularize /='                          , '='],
      \ ':' : [':Tabularize /:\zs'                          , ':'],
      \ ',' : [':Tabularize /,\zs'                          , ','],
      \ }

"custom commands
nmap <leader>ls :CocSearch <left><right>
nmap <leader>lS :CocSearch <C-R>=expand("<cword>")<CR><CR>

" t is for terminal
let g:which_key_map.t = {
      \ 'name' : '+terminal' ,
      \ 'g' : [':FloatermNew lazygit'                           , 'git'],
      \ 'r' : [':FloatermNew ranger'                            , 'ranger'],
      \ 't' : [':FloatermToggle'         , 'terminal'],
      \ }


" VimWiki bindings
let g:which_key_map.w = {
      \ 'name' : '+VimWiki'  ,
      \ 'w' : 'Open wiki',
      \ 't' : 'Open wiki (tab)',
      \ 's' : 'Select and open wiki',
      \ 'd' : 'Delete wiki',
      \ 'r' : 'Rename wiki',
      \ }




" Register which key map
call which_key#register('<Space>', "g:which_key_map")
