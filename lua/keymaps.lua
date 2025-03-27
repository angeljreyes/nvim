vim.keymap.set("v", "<leader>P", '"_dP', { desc = "Put keep reg" })

-- Copy to and paste from clipboard
vim.keymap.set({ "n", "v" }, "<leader>y", '"+y', { desc = "Copy to clipboard" })
vim.keymap.set({ "n", "v" }, "<leader>p", '"+p', { desc = "Paste from clipboard" })

-- Visual block mode fix
vim.keymap.set({ "x", "i" }, "<C-c>", "<esc>")

-- Disable "Type  :qa  and press <Enter> to exit Nvim" text
vim.cmd([[nnoremap <C-c> <silent> <C-c>]])

vim.keymap.set({ "n", "v" }, "Z", "zz", { desc = "Center this line" })

-- vim.keymap.set({ "n", "v" }, "<Space>", "<Nop>", { silent = true })

-- Ctrl backspace as ctrl w in insert mode
vim.keymap.set("i", "<c-bs>", "<c-w>", { desc = "Delete word" })

vim.keymap.set(
  "n",
  "[d",
  function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end,
  { desc = "Go to previous diagnostic message" }
)
vim.keymap.set(
  "n",
  "]d",
  function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end,
  { desc = "Go to next diagnostic message" }
)
vim.keymap.set(
  "n",
  "<leader>e",
  function() vim.diagnostic.open_float({ border = "rounded" }) end,
  { desc = "Open floating diagnostic message" }
)
