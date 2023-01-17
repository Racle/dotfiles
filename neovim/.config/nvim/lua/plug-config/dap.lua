local dap = require "dap"
local dapui = require("dapui")

-- open dap ui on debug start
dap.listeners.after.event_initialized["dapui_config"] = function()
  dapui.open({reset = true})
end

local dap_breakpoint_color = {
  breakpoint = {
    ctermbg = 0,
    fg = "#993939",
    bg = "#31353f"
  },
  logpoing = {
    ctermbg = 0,
    fg = "#61afef",
    bg = "#31353f"
  },
  stopped = {
    ctermbg = 0,
    fg = "#98c379",
    bg = "#31353f"
  }
}

vim.api.nvim_set_hl(0, "DapBreakpoint", dap_breakpoint_color.breakpoint)
vim.api.nvim_set_hl(0, "DapLogPoint", dap_breakpoint_color.logpoing)
vim.api.nvim_set_hl(0, "DapStopped", dap_breakpoint_color.stopped)

local dap_breakpoint = {
  error = {
    text = "",
    texthl = "DapBreakpoint",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint"
  },
  condition = {
    text = "ﳁ",
    texthl = "DapBreakpoint",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint"
  },
  rejected = {
    text = "",
    texthl = "DapBreakpint",
    linehl = "DapBreakpoint",
    numhl = "DapBreakpoint"
  },
  logpoint = {
    text = "",
    texthl = "DapLogPoint",
    linehl = "DapLogPoint",
    numhl = "DapLogPoint"
  },
  stopped = {
    text = "",
    texthl = "DapStopped",
    linehl = "DapStopped",
    numhl = "DapStopped"
  }
}

vim.fn.sign_define("DapBreakpoint", dap_breakpoint.error)
vim.fn.sign_define("DapBreakpointCondition", dap_breakpoint.condition)
vim.fn.sign_define("DapBreakpointRejected", dap_breakpoint.rejected)
vim.fn.sign_define("DapLogPoint", dap_breakpoint.logpoint)
vim.fn.sign_define("DapStopped", dap_breakpoint.stopped)

-- debug bindings
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {"go"}, -- filetypes
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>dt",
        function()
          require("dapui").toggle({reset = true})
        end,
        {desc = "[T]oggle Debug UI"}
      )

      vim.keymap.set("n", "<leader>dd", ":DapContinue<CR>", {desc = "DapContinue"})
      vim.keymap.set("n", "<leader>dc", ":DapContinue<CR>", {desc = "Dap[C]ontinue"})
      vim.keymap.set("n", "<leader>dj", ":DapStepOver<CR>", {desc = "DapStepOver"})
      vim.keymap.set("n", "<leader>dl", ":DapSetpOut<CR>", {desc = "DapSetpOut"})
      vim.keymap.set("n", "<leader>do", ":DapStepOver<CR>", {desc = "DapStepOver"})
      vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<CR>", {desc = "DapToggle[B]reakpoint"})
      vim.keymap.set("n", "<leader>dr", ":lua require'dap'.run_last()<CR>", {desc = "Dap[R]estart"})
      vim.keymap.set(
        "n",
        "<leader>d_",
        function()
          -- terminate dap, clear breakpoints, close dap ui
          vim.cmd(":DapTerminate")
          require("dap").clear_breakpoints()
          require("dapui").close()
        end,
        {desc = "DapTerminate"}
      )

      -- usable mappings
      -- vim.keymap.set("n", "<leader>dj", ":DapStepOut<cr>", {desc = "DapStepOut"})
      -- vim.keymap.set("n", "<leader>dj", ":DapStepInto<cr>", {desc = "DapStepInto"})
      -- vim.keymap.set("n", "<leader>dj", ":DapToggleRepl<cr>", {desc = "DapToggleRepl"})
      -- vim.keymap.set("n", "<leader>dj", ":DapSetLogLevel<cr>", {desc = "DapSetLogLevel"})
      -- vim.keymap.set("n", "<leader>dj", ":DapLoadLaunchJSON<cr>", {desc = "DapLoadLaunchJSON"})
    end
  }
)

-- adpater config

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
--
dap.adapters.delve = {
  type = "server",
  port = "${port}",
  executable = {
    command = "dlv",
    args = {"dap", "-l", "127.0.0.1:${port}"}
  }
}

-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "delve",
    name = "Debug (go.mod)",
    request = "launch",
    program = "./${relativeFileDirname}"
  }
  -- works with go.mod packages and sub packages
  -- {
  --   type = "delve",
  --   name = "Debug test (go.mod)",
  --   request = "launch",
  --   mode = "test",
  --   program = "./${relativeFileDirname}"
  -- }
}
