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

wk.register(
  {
    a = {
      name = "[a]ctions",
      L = "Toggle lesscss"
    },
    b = {
      name = "[b]uffers"
    },
    c = {
      name = "[C]opilot"
    },
    f = {
      name = "[f]ind",
      g = {
        name = "[g]it",
        d = "[d]iff"
      }
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
    m = {
      name = "[m]inimap"
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
