require("ibl").setup {
  indent = {
    char = "▏"
  },
  exclude = {
    buftypes = {"terminal"},
    filetypes = {"help", "packer"}
  },
  scope = {
    enabled = true,
    show_start = false,
    highlight = {"Label"},
    char = "▏"
  }
}
