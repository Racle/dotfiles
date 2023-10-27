-- The below settings make Leap's highlighting a bit closer to what you've been
-- used to in Lightspeed.
vim.api.nvim_set_hl(0, "LeapBackdrop", {link = "Comment"})
vim.api.nvim_set_hl(
  0,
  "LeapMatch",
  {
    fg = "white", -- for light themes, set to 'black' or similar
    bold = true,
    nocombine = true
  }
)

vim.api.nvim_set_hl(0, "LeapLabelPrimary", {fg = "#fb4934", bold = true, nocombine = true})
vim.api.nvim_set_hl(0, "LeapLabelSecondary", {fg = "#b8bb26", bold = true, nocombine = true})

-- keep old 'x' behaviour in visual mode
-- vim.keymap.del({"x", "o"}, "x")
-- vim.keymap.del({"x", "o"}, "X")
