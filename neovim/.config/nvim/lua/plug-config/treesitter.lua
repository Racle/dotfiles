require("nvim-treesitter.configs").setup {
  ensure_installed = {
    "bash",
    "c_sharp",
    "cmake",
    "comment",
    "commonlisp",
    "cpp",
    "css",
    "dockerfile",
    "glsl",
    "go",
    "gomod",
    "gowork",
    "graphql",
    "heex",
    "hjson",
    "html",
    "http",
    "java",
    "javascript",
    "jsdoc",
    "json",
    "json5",
    "jsonc",
    "lua",
    "make",
    "nix",
    "perl",
    "php",
    "python",
    "ql",
    "query",
    "r",
    "regex",
    "rst",
    "ruby",
    "rust",
    "scala",
    "scss",
    "tsx",
    "typescript",
    "vim",
    "vue",
    "yaml",
    "c",
    "markdown"
  },
  highlight = {
    enable = true,
    use_languagetree = true,
    -- Or use a function for more flexibility, e.g. to disable slow treesitter highlight for large files
    disable = function(lang, buf)
      local max_filesize = 200 * 1024 -- 200 KB
      local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
      if ok and stats and stats.size > max_filesize then
        return true
      end
    end
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "<M-w>",
      node_incremental = "<M-w>",
      scope_incremental = "<M-C-w>",
      node_decremental = "<M-e>"
    }
  },
  indent = {
    enable = true,
    disable = {"yaml"}
  },
  textobjects = {
    select = {
      enable = true,
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ["af"] = "@function.outer",
        ["if"] = "@function.inner",
        ["ac"] = "@class.outer",
        ["ic"] = "@class.inner"
      }
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ["]m"] = "@function.outer",
        ["]]"] = "@class.outer"
      },
      goto_next_end = {
        ["]M"] = "@function.outer",
        ["]["] = "@class.outer"
      },
      goto_previous_start = {
        ["[m"] = "@function.outer",
        ["[["] = "@class.outer"
      },
      goto_previous_end = {
        ["[M"] = "@function.outer",
        ["[]"] = "@class.outer"
      }
    }
  },
  matchup = {
    enable = true, -- mandatory, false will disable the whole extension
    -- enable = false,
    disable = {"c", "ruby"} -- optional, list of language that will be disabled
  }
}

-- for sticky scrolling
require "treesitter-context".setup {
  enable = true, -- Enable this plugin (Can be enabled/disabled later via commands)
  max_lines = 0, -- How many lines the window should span. Values <= 0 mean no limit.
  min_window_height = 0, -- Minimum editor window height to enable context. Values <= 0 mean no limit.
  line_numbers = true,
  multiline_threshold = 20, -- Maximum number of lines to show for a single context
  trim_scope = "outer", -- Which context lines to discard if `max_lines` is exceeded. Choices: 'inner', 'outer'
  mode = "cursor", -- Line used to calculate context. Choices: 'cursor', 'topline'
  -- Separator between context and content. Should be a single character string, like '-'.
  -- When separator is set, the context will only show up when there are at least 2 lines above cursorline.
  separator = nil,
  zindex = 20, -- The Z-index of the context window
  on_attach = nil -- (fun(buf: integer): boolean) return false to disable attaching
}

-- quickly ; to go to previous context
vim.keymap.set(
  "n",
  ";",
  function()
    require("treesitter-context").go_to_context(vim.v.count1)
  end,
  {silent = true}
)
vim.api.nvim_create_augroup("cmdwin_treesitter", {clear = true})
vim.api.nvim_create_autocmd(
  "CmdwinEnter",
  {
    pattern = "*",
    command = "TSBufDisable incremental_selection",
    group = "cmdwin_treesitter",
    desc = "Disable treesitter's incremental selection in Command-line window"
  }
)
