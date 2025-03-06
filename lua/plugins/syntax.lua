return {
  "tpope/vim-sleuth",

  "hiphish/rainbow-delimiters.nvim",

  {
    "cohama/lexima.vim",
    config = function()
      local rule = vim.fn["lexima#add_rule"]

      -- Rules for angle brackets e.g. "List<int>"
      rule({
        char = "<",
        input_after = ">",
        at = [[\w\%#]],
      })
      rule({
        char = ">",
        at = [[\%#>]],
        leave = 1,
      })
      rule({
        char = "<bs>",
        at = [[<\%#>]],
        delete = 1,
      })
    end,
  },

  {
    "echasnovski/mini.move",
    opts = {},
  },

  {
    "numToStr/Comment.nvim",
    opts = {},
  },

  {
    "kevinhwang91/nvim-fundo",
    opts = {},
    dependencies = "kevinhwang91/promise-async",
  },

  {
    "windwp/nvim-ts-autotag",
    opts = {
      aliases = { razor = "html" },
    },
  },

  {
    "kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {},
  },
}
