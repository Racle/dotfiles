local function customModes()
  local modes = {}
  if vim.b.macromode then
    table.insert(modes, "MacroMode")
  end
  if vim.o.paste == true then
    table.insert(modes, "PASTE")
  end

  -- check if any custom modes has set
  if #modes == 0 then
    return ""
  else
    return table.concat(modes, " | ")
  end
end

local function filetree()
  return [[Neo-tree]]
end

local my_extension = {
  sections = {lualine_c = {filetree}},
  filetypes = {"NvimTree", "neo-tree"}
}

local treesitter = require("nvim-treesitter")
local function treelocation()
  local ret =
    treesitter.statusline(
    {
      indicator_size = 100,
      type_patterns = {"class", "function", "method"},
      separator = " -> "
    }
  )
  if ret == nil then
    return ""
  else
    return ret
  end
end

require "lualine".setup {
  options = {
    theme = "gruvbox",
    disabled_filetypes = {
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_console",
      "dapui_stacks",
      "dap-repl"
    },
    ignore_focus = {
      "dapui_watches",
      "dapui_breakpoints",
      "dapui_scopes",
      "dapui_console",
      "dapui_stacks",
      "dap-repl"
    }
  },
  extensions = {my_extension},
  sections = {
    lualine_a = {customModes, "mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {{treelocation}},
    --{{"diagnostics", sources = {"vim_lsp"}}, "filename", "b:coc_current_function"},
    lualine_x = {"encoding", "fileformat"},
    lualine_y = {"filetype"},
    lualine_z = {"location", "progress"}
  }
}
