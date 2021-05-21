require "lualine".setup {
  options = {theme = "gruvbox"},
  sections = {
    lualine_b = {"branch", "diff"},
    lualine_c = {{"diagnostics", sources = {"coc"}}, "filename", "b:coc_current_function"}
  }
}
