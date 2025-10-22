-- used also in lspconfig.lua
local wk = require("which-key")

wk.setup(
  {
    triggers_blacklist = {
      -- list of mode / prefixes that should never be hooked by WhichKey
      -- this is mostly relevant for keymaps that start with a native binding
      i = {"j", "k"},
      v = {"j", "k", "c"} -- c for vim-visual-multi plugin
    }
  }
)

-- wk group names

-- wk.register(
--   {
--     a = {
--       name = "[a]ctions",
--       L = "Toggle lesscss"
--     },
--     b = {
--       name = "[b]uffers"
--     },
--     c = {
--       name = "[C]opilot"
--     },
--     f = {
--       name = "[f]ind",
--       g = {
--         name = "[g]it",
--         d = "[d]iff"
--       }
--     },
--     g = {
--       name = "[G]it diff",
--       d = "[d]iff",
--       m = "git messenger"
--     },
--     l = {
--       name = "[l]sp",
--       w = "[w]orkspace",
--       d = "[d]ocument"
--     },
--     m = {
--       name = "[m]inimap"
--     },
--     s = {
--       name = "[s]search"
--     },
--     S = {
--       name = "[S]essions",
--       s = "[s]ave",
--       l = "[l]oad",
--       d = "[d]elete"
--     },
--     t = {
--       name = "[t]erminal"
--     },
--     T = {
--       name = "[T]abularize"
--     },
--     w = {
--       name = "Vim[w]iki",
--       w = "Open wiki",
--       t = "Open wiki (tab)",
--       d = "Delete wiki",
--       r = "Rename wiki"
--     }
--   },
--   {prefix = "<leader>"}
-- )

wk.add(
  {
    {"<leader>S", group = "[S]essions"},
    {"<leader>Sd", desc = "[d]elete"},
    {"<leader>Sl", desc = "[l]oad"},
    {"<leader>Ss", desc = "[s]ave"},
    {"<leader>T", group = "[T]abularize"},
    {"<leader>a", group = "[a]ctions"},
    {"<leader>c", group = "[c]hat"},
    {"<leader>aL", desc = "Toggle lesscss"},
    {"<leader>b", group = "[b]uffers"},
    {"<leader>c", group = "[C]opilot"},
    {"<leader>f", group = "[f]ind"},
    {"<leader>fg", group = "[g]it"},
    {"<leader>fgd", desc = "[d]iff"},
    {"<leader>g", group = "[G]it diff"},
    {"<leader>gd", desc = "[d]iff"},
    {"<leader>gm", desc = "git messenger"},
    {"<leader>l", group = "[l]sp"},
    {"<leader>ld", desc = "[d]ocument"},
    {"<leader>lw", desc = "[w]orkspace"},
    {"<leader>m", group = "[m]inimap"},
    {"<leader>s", group = "[s]search"},
    {"<leader>t", group = "[t]erminal"},
    {"<leader>w", group = "Vim[w]iki"},
    {"<leader>wd", desc = "Delete wiki"},
    {"<leader>wr", desc = "Rename wiki"},
    {"<leader>wt", desc = "Open wiki (tab)"},
    {"<leader>ww", desc = "Open wiki"}
  },
  {prefix = "<leader>"}
)
