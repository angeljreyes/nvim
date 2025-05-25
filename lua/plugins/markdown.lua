return {
  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    keys = {
      {
        "<leader>m",
        function()
          if vim.o.conceallevel == 0 then
            vim.cmd("Markview enable")
            vim.o.conceallevel = 3
          else
            vim.cmd("Markview disable")
            vim.o.conceallevel = 0
          end
        end,
        desc = "Toggle Extra Rendering",
        ft = "markdown",
      },
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
