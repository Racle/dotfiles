local function customModes()
  if vim.b.macromode then
    return [[MacroMode]]
  elseif vim.o.paste == true then
    return [[PASTE]]
  else
    return nil
  end
end

require "lualine".setup {
  options = {theme = "gruvbox"},
  sections = {
    lualine_a = {customModes, "mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {{"diagnostics", sources = {"coc"}}, "filename", "b:coc_current_function"},
    lualine_x = {"encoding", "fileformat"},
    lualine_y = {"filetype"},
    lualine_z = {"location"}
  }
}
