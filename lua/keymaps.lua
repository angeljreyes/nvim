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

local function show_virtual_lines()
  vim.diagnostic.config({
    virtual_lines = { current_line = true },
    virtual_text = false,
  })
  vim.api.nvim_create_autocmd("CursorMoved", {
    group = vim.api.nvim_create_augroup("line-diagnostics", { clear = true }),
    once = true,
    callback = function()
      vim.diagnostic.config({
        virtual_lines = false,
        virtual_text = true,
      })
    end,
  })
end

---@param count integer
local function diagnostic_jump_virtual_lines(count)
  vim.diagnostic.jump({ count = count })
  vim.schedule(show_virtual_lines)
end

vim.keymap.set(
  "n",
  "[d",
  function() diagnostic_jump_virtual_lines(-1) end,
  { desc = "Go to previous diagnostic message" }
)

vim.keymap.set("n", "]d", function() diagnostic_jump_virtual_lines(1) end, { desc = "Go to next diagnostic message" })

vim.keymap.set("n", "<leader>e", show_virtual_lines, { desc = "Open diagnostic messages" })
