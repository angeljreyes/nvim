return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window:
      -- See `# Preview Mode` for more information
    },
    config = function()
      vim.keymap.set(
        "n",
        "<leader>f",
        "<cmd>Neotree toggle<cr>",
        { desc = "File explorer on the right" }
      )
      vim.keymap.set(
        "n",
        "<leader>F",
        "<cmd>Neotree current<cr>",
        { desc = "File explorer full screen" }
      )
    end,
  },
}
