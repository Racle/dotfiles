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
  return [[coc-explorer]]
end

local my_extension = {
  sections = {lualine_c = {filetree}},
  filetypes = {"coc-explorer"}
}

require "lualine".setup {
  options = {theme = "gruvbox"},
  extensions = {my_extension},
  sections = {
    lualine_a = {customModes, "mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {{"diagnostics", sources = {"coc"}}, "filename", "b:coc_current_function"},
    lualine_x = {"encoding", "fileformat"},
    lualine_y = {"filetype"},
    lualine_z = {"location", "progress"}
  }
}
