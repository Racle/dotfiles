call wilder#enable_cmdline_enter()
set wildcharm=<Tab>
cmap <expr> <Tab> wilder#in_context() ? wilder#next() : "\<Tab>"
cmap <expr> <S-Tab> wilder#in_context() ? wilder#previous() : "\<S-Tab>"

call wilder#set_option('modes', ['/', '?', ':'])

call wilder#set_option('pipeline', [
      \   wilder#branch(
      \     wilder#cmdline_pipeline({
      \       'language': 'python',
      \       'fuzzy': 1,
      \     }),
      \     wilder#cmdline_pipeline(),
      \     wilder#python_search_pipeline(),
      \   ),
      \ ])

let s:highlighters = [
      \ wilder#basic_highlighter(),
      \ ]
      " \ wilder#pcre2_highlighter(),
      " \ wilder#lua_fzy_highlighter(),
      "
let s:search_renderer = wilder#wildmenu_renderer({
    \ 'highlighter': s:highlighters,
    \ 'mode': 'statusline',
    \ 'right': [' ', wilder#wildmenu_index()]
    \ })

call wilder#set_option('renderer', wilder#renderer_mux({
      \ ':': wilder#popupmenu_renderer({
      \   'highlighter': s:highlighters,
      \   'left': [
      \ ' ' ,
      \     wilder#popupmenu_devicons(),
      \   ],
      \   'right': [
      \     ' ',
      \     wilder#popupmenu_scrollbar(),
      \   ],
      \ }),
      \ '/': s:search_renderer,
      \ '?': s:search_renderer
      \ }))
