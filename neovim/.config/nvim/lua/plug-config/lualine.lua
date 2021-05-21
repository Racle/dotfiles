require "lualine".setup {
  options = {theme = "gruvbox"},
  sections = {
    lualine_b = {"branch", "diff"},
    lualine_c = {"filename", "b:coc_current_function"}
  }
}
