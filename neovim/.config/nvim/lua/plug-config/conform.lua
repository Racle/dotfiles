local prettier = { "prettier" }

require("conform").setup(
  {
    formatters_by_ft = {
      javascript = prettier,
      javascriptreact = prettier,
      typescript = prettier,
      css = prettier,
      less = prettier,
      scss = prettier,
      json = prettier,
      vue = prettier,
      markdown = prettier,
      vimwiki = {}, -- suppress formatting
      graphql = prettier,
      yaml = prettier,
      ["yaml.ansible"] = prettier,
      html = prettier,
      xhtml = prettier,
      xml = prettier,
      php = prettier,
      sh = { "shfmt" },
      lua = { "luafmt" },
      rust = { "rustfmt" },
      nginx = { "nginxbeautifier" }
    },
    -- async format on save
    format_on_save = false,
    format_after_save = function(bufnr)
      -- skip vimwiki entirely
      if vim.bo[bufnr].filetype == "vimwiki" then
        return nil
      end
      return { lsp_fallback = false }
    end,
    formatters = {
      prettier = {
        command = "prettier",
        args = {
          -- use config file when found, fall back to the args below
          "--config-precedence", "prefer-file",
          -- defaults matching ~/.prettierrc
          "--tab-width", "2",
          "--single-quote",
          "--trailing-comma", "es5",
          "--no-semi",
          "--print-width", "200",
          "--end-of-line", "lf",
          "--no-use-tabs",
          "--jsx-single-quote",
          "--bracket-spacing",
          "--bracket-same-line",
          "--arrow-parens", "avoid",
          "--stdin-filepath", "$FILENAME"
        },
        stdin = true
      },
      luafmt = {
        command = "luafmt",
        args = { "--indent-count", "2", "--stdin", "--line-width", "200" },
        stdin = true
      },
      nginxbeautifier = {
        command = "nginxbeautifier",
        args = { "-i", "$FILENAME" },
        stdin = false
      }
    }
  }
)
