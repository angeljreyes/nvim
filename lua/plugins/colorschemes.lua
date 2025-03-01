-- local transparency = Utils.is_profile("home")
local transparency = false

return {
  {
    "loctvl842/monokai-pro.nvim",
    priority = 1000,
    opts = { transparent_background = transparency },
  },

  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        transparent_background = transparency,
        custom_highlights = function(colors)
          return { GitSignsChange = { fg = colors.peach } }
        end,
        integrations = {
          blink_cmp = true,
          diffview = true,
          fidget = true,
          harpoon = true,
          mason = true,
          snacks = {
            enabled = true,
          },
          which_key = true,
        },
      })
      vim.cmd.colorscheme("catppuccin")
    end,
  },

  {
    "navarasu/onedark.nvim",
    priority = 1000,
  },
}
