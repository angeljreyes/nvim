vim.opt.hlsearch = false

vim.opt.number = true
vim.opt.relativenumber = true

vim.opt.wrap = true

vim.opt.mouse = "a"

vim.opt.cursorline = true

vim.opt.scrolloff = 8

vim.opt.breakindent = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

vim.opt.undofile = true

vim.opt.ignorecase = true
vim.opt.smartcase = true

vim.opt.signcolumn = "yes"

vim.opt.updatetime = 250
vim.opt.timeoutlen = 300

vim.opt.completeopt = "menuone,noselect"

vim.opt.termguicolors = true

-- Highlight on yank
local highlight_group = vim.api.nvim_create_augroup("YankHighlight", { clear = true })
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function() vim.highlight.on_yank() end,
  group = highlight_group,
  pattern = "*",
})
