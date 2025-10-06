vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("utils")
require("options")
require("keymaps")
require("misc")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.uv.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.o.rtp = lazypath .. "," .. vim.o.rtp

require("lazy").setup("plugins", {
  change_detection = { notify = false },
  dev = {
    path = "~/dev/nvim",
    patterns = Utils.is_profile("home") and { "DestopLine" } or nil,
  },
  ui = { border = "rounded" },
})
