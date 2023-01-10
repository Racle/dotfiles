local dap = require "dap"

vim.fn.sign_define("DapBreakpoint", {text = "🟥", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define("DapBreakpointRejected", {text = "🟦", texthl = "", linehl = "", numhl = ""})
vim.fn.sign_define("DapStopped", {text = "⭐️", texthl = "", linehl = "", numhl = ""})

-- debug bindings
vim.api.nvim_create_autocmd(
  "FileType",
  {
    pattern = {"go"}, -- filetypes
    callback = function()
      vim.keymap.set(
        "n",
        "<leader>dd",
        function()
          require("dapui").toggle({reset = true})
        end,
        {desc = "Toggle [D]ebug UI"}
      )

      vim.keymap.set("n", "<leader>dj", ":GoDebugStep<CR>", {desc = "GoDebugStep"})
      vim.keymap.set("n", "<leader>dl", ":DapSetpOut<CR>", {desc = "DapSetpOut"})
      vim.keymap.set("n", "<leader>dc", ":DapContinue<cr>", {desc = "Dap[C]ontinue"})
      vim.keymap.set("n", "<leader>db", ":DapToggleBreakpoint<cr>", {desc = "DapToggle[B]reakpoint"})
      vim.keymap.set("n", "<leader>dr", ":DapRestartFrame<cr>", {desc = "Dap[R]estartFrame"})
      vim.keymap.set("n", "<leader>d_", ":DapTerminate<cr>", {desc = "DapTerminate"})

      -- usable mappings
      -- vim.keymap.set("n", "<leader>dj", ":DapStepOut<cr>", {desc = "DapStepOut"})
      -- vim.keymap.set("n", "<leader>dj", ":DapStepInto<cr>", {desc = "DapStepInto"})
      -- vim.keymap.set("n", "<leader>dj", ":DapStepOver<cr>", {desc = "DapStepOver"})
      -- vim.keymap.set("n", "<leader>dj", ":DapTerminate<cr>", {desc = "DapTerminate"})
      -- vim.keymap.set("n", "<leader>dj", ":DapToggleRepl<cr>", {desc = "DapToggleRepl"})
      -- vim.keymap.set("n", "<leader>dj", ":DapSetLogLevel<cr>", {desc = "DapSetLogLevel"})
      -- vim.keymap.set("n", "<leader>dj", ":DapRestartFrame<cr>", {desc = "DapRestartFrame"})
      -- vim.keymap.set("n", "<leader>dj", ":DapLoadLaunchJSON<cr>", {desc = "DapLoadLaunchJSON"})
    end
  }
)

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
  },
  {
    type = "delve",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "delve",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "delve",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}
