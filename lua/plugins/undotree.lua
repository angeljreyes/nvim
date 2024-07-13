return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle, { desc = "Undotree" })
    if vim.uv.os_uname().sysname == "Windows_NT" then
      vim.g.undotree_DiffCommand = "FC"
    end
  end,
}
