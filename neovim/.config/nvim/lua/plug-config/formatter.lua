-- autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.xml,*.php,*.lua,*.rs,*.conf FormatWrite
vim.api.nvim_exec(
  [[
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html,*.xml,*.php,*.lua,*.rs,*.sh FormatWrite
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

local nop = {
  -- prettier
  function()
    return {
      exe = "exit 0",
      stdin = false,
      ignore_exitcode = true
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
      vimwiki = nop,
      graphql = prettier,
      yaml = prettier,
      ["yaml.ansible"] = prettier,
      html = prettier,
      xhtml = prettier,
      xml = prettier,
      php = prettier,
      sh = {
        require("formatter.filetypes.sh").shfmt
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin", "--line-width", 200},
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
