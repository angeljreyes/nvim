return {
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
      "MunifTanjim/nui.nvim",
      -- "3rd/image.nvim", -- Optional image support in preview window: See `# Preview Mode` for more information
    },
    keys = {
      { "<leader>f", "<cmd>Neotree<cr>", desc = "File explorer on the right" },
      { "<leader>F", "<cmd>Neotree current<cr>", desc = "File explorer full screen" },
    },
  },
}
