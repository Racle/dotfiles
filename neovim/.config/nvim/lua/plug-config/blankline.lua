-- local highlight = {
--   "CursorColumn",
--   "Whitespace"
-- }
-- require("ibl").setup {
--   indent = {
--     highlight = highlight,
--     char = "▏"
--   },
--   exclude = {
--     buftypes = {"terminal"},
--     filetypes = {"help", "packer"}
--   },
--   scope = {
--     enabled = true,
--     show_start = false,
--     show_end = false,
--     highlight = {"Label"},
--     char = "▏"
--   }
-- }
require("ibl").setup {
  scope = {
    enabled = true,
    show_start = false,
    show_end = false
  }
}
