" Prettier
" Allow auto formatting for files without "@format" or "@prettier" tag
let g:prettier#autoformat_require_pragma = 0
let g:prettier#autoformat = 1
au BufRead,BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.xml,*.php PrettierAsync
