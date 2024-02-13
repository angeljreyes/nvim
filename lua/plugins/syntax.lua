return {
  { "tpope/vim-sleuth" },

  { "hiphish/rainbow-delimiters.nvim" },

  {
    "jiangmiao/auto-pairs",
    config = function()
      -- Avoid nasty bug with cmp remapping CR
      vim.g.AutoPairsMapCR = 0
    end,
  },

  { "numToStr/Comment.nvim", opts = {} },

  {
    "lukas-reineke/indent-blankline.nvim",
    -- Enable `lukas-reineke/indent-blankline.nvim`
    -- See `:help ibl`
    main = "ibl",
    opts = {},
  },
}
