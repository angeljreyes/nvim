return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").add({
      { "<leader>a", group = "Harpoon" },
      { "<leader>c", group = "Code" },
      { "<leader>d", group = "Debugger" },
      { "<leader>g", group = "Git" },
      { "<leader>h", group = "Git Hunk" },
      { "<leader>s", group = "Search" },
      { "<leader>w", group = "Workspace" },
      { "<leader>", group = "VISUAL <leader>", mode = "v" },
      { "<leader>h", group = "git Hunk", mode = "v" },
    })
  end,
}
