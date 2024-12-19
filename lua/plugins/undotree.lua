return {
  "mbbill/undotree",
  config = function()
    vim.keymap.set(
      "n",
      "<leader>u",
      "<cmd>UndotreeToggle<cr><cmd>UndotreeFocus<cr>",
      { desc = "Undotree" }
    )
    if Utils.on_windows then
      vim.g.undotree_DiffCommand = "FC"
    end
  end,
}
