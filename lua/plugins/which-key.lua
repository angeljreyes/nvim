---@module "which-key"

return {
  "folke/which-key.nvim",
  opts = {
    ---@type wk.Spec
    spec = {
      { "<leader>a", group = "Harpoon" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debugger" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>s", group = "Search" },
      { "<leader>w", group = "Workspace" },
      { "<leader>", group = "VISUAL <leader>", mode = "v" },
      { "<leader>h", group = "git Hunk", mode = "v" },
    },
  },
}
