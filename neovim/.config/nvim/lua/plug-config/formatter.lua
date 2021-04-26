vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.xml,*.php,*.lua,*.rs,*.conf FormatWrite
augroup END
]],
  true
)

local prettier = {
  -- prettier
  function()
    return {
      exe = "prettier",
      args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0)},
      stdin = true
    }
  end
}

require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      css = prettier,
      less = prettier,
      scss = prettier,
      json = prettier,
      vue = prettier,
      markdown = prettier,
      vimwiki = prettier,
      graphql = prettier,
      yaml = prettier,
      html = prettier,
      xml = prettier,
      php = prettier,
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      nginx = {
        -- nginxbeautifier
        function()
          return {
            exe = "nginxbeautifier",
            args = {"-i", vim.api.nvim_buf_get_name(0)},
            stdin = false
          }
        end
      }
    }
  }
)
