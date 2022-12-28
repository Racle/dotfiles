-- used also in lspconfig.lua
local wk = require("which-key")

-- wk group names

wk.register(
  {
    a = {
      name = "[a]ctions",
      L = "Toggle lesscss"
    },
    b = {
      name = "[b]uffers"
    },
    f = {
      name = "[f]ind",
      g = {name = "[g]it"}
    },
    g = {
      name = "[G]it diff",
      d = "[d]iff",
      m = "git messenger"
    },
    l = {
      name = "[l]sp",
      w = "[w]orkspace",
      d = "[d]ocument"
    },
    s = {
      name = "[s]search"
    },
    S = {
      name = "[S]essions",
      s = "[s]ave",
      l = "[l]oad",
      d = "[d]elete"
    },
    t = {
      name = "[t]erminal"
    },
    T = {
      name = "[T]abularize"
    },
    w = {
      name = "Vim[w]iki",
      w = "Open wiki",
      t = "Open wiki (tab)",
      d = "Delete wiki",
      r = "Rename wiki"
    }
  },
  {prefix = "<leader>"}
)
