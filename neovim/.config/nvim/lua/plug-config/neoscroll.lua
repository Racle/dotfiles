-- require("neoscroll").setup({})
require("neoscroll").setup(
  {
    pre_hook = function()
      vim.opt.eventignore:append(
        {
          "WinScrolled",
          "CursorMoved"
        }
      )
    end,
    post_hook = function()
      vim.opt.eventignore:remove(
        {
          "WinScrolled",
          "CursorMoved"
        }
      )
    end
  }
)
neoscroll = require('neoscroll')
local keymap = {
  ["<C-u>"] = function() neoscroll.ctrl_u({ duration = 100 }) end;
  ["<C-d>"] = function() neoscroll.ctrl_d({ duration = 100 }) end;
  ["<C-b>"] = function() neoscroll.ctrl_b({ duration = 100 }) end;
  ["<C-f>"] = function() neoscroll.ctrl_f({ duration = 100 }) end;
  ["<C-y>"] = function() neoscroll.scroll(-0.1, { move_cursor=false; duration = 100 }) end;
  ["<C-e>"] = function() neoscroll.scroll(0.1, { move_cursor=false; duration = 100 }) end;
  ["zt"]    = function() neoscroll.zt({ half_win_duration = 100 }) end;
  ["zz"]    = function() neoscroll.zz({ half_win_duration = 100 }) end;
  ["zb"]    = function() neoscroll.zb({ half_win_duration = 100 }) end;
}
local modes = { 'n', 'v', 'x' }
for key, func in pairs(keymap) do
  vim.keymap.set(modes, key, func)
end


-- local t = {}
-- -- Syntax: t[keys] = {function, {function arguments}}
-- t["<C-u>"] = {"scroll", {"-vim.wo.scroll", "true", "1"}}
-- t["<C-d>"] = {"scroll", {"vim.wo.scroll", "true", "1"}}
-- t["<C-b>"] = {"scroll", {"-vim.fn.winheight(0)", "true", "1"}}
-- t["<C-f>"] = {"scroll", {"vim.fn.winheight(0)", "true", "1"}}
-- t["<C-y>"] = {"scroll", {"-0.10", "false", "100"}}
-- t["<C-e>"] = {"scroll", {"0.10", "false", "100"}}
-- t["zt"] = {"zt", {"100"}}
-- t["zz"] = {"zz", {"50"}}
-- t["zb"] = {"zb", {"100"}}

-- require("neoscroll.config").set_mappings(t)
