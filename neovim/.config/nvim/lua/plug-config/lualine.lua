require "lualine".setup {
  options = {theme = "gruvbox"},
  sections = {
    lualine_a = {"mode"},
    lualine_b = {"branch", "diff"},
    lualine_c = {{"diagnostics", sources = {"coc"}}, "filename", "b:coc_current_function"},
    lualine_x = {"encoding", "fileformat"},
    lualine_y = {"filetype"},
    lualine_z = {"location"}
  }
}
