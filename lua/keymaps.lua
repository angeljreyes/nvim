vim.keymap.set('v', '<leader>P', '"_dP', { desc = 'Put keep reg' })

-- Copy to and paste from clipboard
vim.keymap.set({ 'n', 'v' }, '<leader>y', '"+y', { desc = 'Copy to clipboard' })
vim.keymap.set({ 'n', 'v' }, '<leader>p', '"+p', { desc = 'Paste from clipboard' })

-- Move code :)
vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", { desc = 'Move selection down' })
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", { desc = 'Move selection up' })

-- Keep center cursor when scrolling half page
vim.keymap.set('n', '<C-d>', '<C-d>zz', { desc = 'Scroll down half a page' })
vim.keymap.set('n', '<C-u>', '<C-u>zz', { desc = 'Scroll up half a page' })
vim.keymap.set('n', 'n', 'nzz', { desc = 'Next search result' })
vim.keymap.set('n', 'N', 'Nzz', { desc = 'Previous search result' })

-- Visual block mode fix
vim.keymap.set('i', '<C-c>', '<esc>')

vim.keymap.set({ 'n', 'v' }, 'Z', 'zz', { desc = 'Center this line' })

-- Access file explorer
-- vim.keymap.set('n', '<leader>f', ':Neotree<CR>', { desc = 'File explorer on the right' })
-- vim.keymap.set('n', '<leader>F', ':Neotree current<CR>', { desc = 'File explorer full screen' })

vim.keymap.set('n', '<leader>u', vim.cmd.UndotreeToggle, { desc = 'Undotree' })

vim.keymap.set({ 'n', 'v' }, '<Space>', '<Nop>', { silent = true })

-- Remap for dealing with word wrap
vim.keymap.set('n', 'k', "v:count == 0 ? 'gk' : 'k'", { expr = true, silent = true })
vim.keymap.set('n', 'j', "v:count == 0 ? 'gj' : 'j'", { expr = true, silent = true })

-- Diagnostic keymaps
vim.keymap.set('n', '[d', vim.diagnostic.goto_prev, { desc = 'Go to previous diagnostic message' })
vim.keymap.set('n', ']d', vim.diagnostic.goto_next, { desc = 'Go to next diagnostic message' })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { desc = 'Open floating diagnostic message' })
vim.keymap.set('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- Debugger keymaps
-- vim.keymap.set('n', '<leader>db', '<cmd> DapToggleBreakpoint <CR>', { desc = 'Toggle a breakpoint' })
-- vim.keymap.set('n', '<leader>dr', require('dap-python').test_method, { desc = 'Toggle a breakpoint' })

vim.filetype.add({
	pattern = {
		['req.*.txt'] = 'requirements',
	},
})

