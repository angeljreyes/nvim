---@module "which-key"

return {
  "folke/which-key.nvim",
  opts = {
    ---@type wk.Spec
    spec = {
      { "<leader>a", group = "Harpoon" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debugger" },
      { "<leader>h", group = "Git hunk" },
      { "<leader>s", group = "Search" },
      { "<leader>.", group = "Open scratch window" },
      { "<leader>", group = "Visual <leader>", mode = "v" },
      { "<leader>h", group = "Git hunk", mode = "v" },
    },
  },
}
