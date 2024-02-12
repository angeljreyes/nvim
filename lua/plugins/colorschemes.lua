return {
  {
    'loctvl842/monokai-pro.nvim',
    priority = 1000,
    config = function()
      require('monokai-pro').setup{ transparent_background = true }
      -- vim.cmd.colorscheme 'monokai-pro-machine'
    end,
  },

  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require('catppuccin').setup{ transparent_background = false }
      vim.cmd.colorscheme 'catppuccin'
    end
  },

  {
    -- Theme inspired by Atom
    'navarasu/onedark.nvim',
    priority = 1000,
    -- config = function()
    --   vim.cmd.colorscheme 'onedark'
    -- end,
  },
}
