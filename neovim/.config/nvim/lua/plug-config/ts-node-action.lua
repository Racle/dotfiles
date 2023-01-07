-- ts-node-action mapping, quick switch between true|false etc.
vim.keymap.set({"n"}, "K", require("ts-node-action").node_action, {desc = "Trigger Node Action"})
