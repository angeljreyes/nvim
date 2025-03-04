vim.g.omni_sql_no_default_maps = true

vim.o.hlsearch = false

vim.o.number = true
vim.o.relativenumber = true

vim.o.wrap = true

vim.o.mouse = "a"

vim.o.cursorline = true

vim.o.scrolloff = 8
vim.o.sidescrolloff = 10

vim.o.breakindent = true
vim.o.shiftwidth = 4
vim.o.tabstop = 4
vim.o.expandtab = true

vim.o.undofile = true

vim.o.ignorecase = true
vim.o.smartcase = true

vim.o.signcolumn = "yes"

vim.o.updatetime = 250
vim.o.timeoutlen = 300

vim.o.completeopt = "menuone,noselect"

vim.o.termguicolors = true

vim.o.showmode = false

vim.o.title = true
vim.o.titlelen = 0
vim.o.titlestring = [[nvim – %{fnamemodify(getcwd(), ':t')}/%t]]

vim.o.splitright = true
vim.o.splitbelow = true

vim.o.foldmethod = "expr"
vim.o.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.o.foldlevel = 99
vim.o.foldtext = ""

vim.cmd[[
  aunmenu PopUp.How-to\ disable\ mouse
  aunmenu PopUp.-1-
]]
