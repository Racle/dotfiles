vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.xml,*.php,*.lua,*.rs,*.conf  FormatWrite
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
      nginx = {
        -- nginxbeautifier
        function()
          return {
            exe = "nginxbeautifier",
            args = {"-i", vim.api.nvim_buf_get_name(0)},
            stdin = false
          }
        end
      },
      vue = prettier,
      graphql = prettier,
      css = prettier,
      scss = prettier,
      less = prettier,
      php = prettier,
      xml = prettier,
      html = prettier,
      yaml = prettier,
      markdown = prettier,
      typescript = prettier,
      javascriptreact = prettier,
      javascript = prettier,
      json = prettier,
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
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      }
    }
  }
)
