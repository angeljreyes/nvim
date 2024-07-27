return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>u",
      "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>",
      { desc = "Undotree" }
    )
    if vim.uv.os_uname().sysname == "Windows_NT" then
      vim.g.undotree_DiffCommand = "FC"
    end
  end,
}
