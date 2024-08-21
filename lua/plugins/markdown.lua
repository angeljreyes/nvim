return {
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    keys = {
      { "<leader>m", "<cmd>Markview<cr>", desc = "Toggle Markview", ft = "markdown" },
    },
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "iamcco/markdown-preview.nvim",
    cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
    build = "cd app && npm i",
    init = function() vim.g.mkdp_filetypes = { "markdown" } end,
    ft = "markdown",
  },
}
