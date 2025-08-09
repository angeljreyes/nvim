-- local transparency = Utils.is_profile("home")
local transparency = true

return {
  {
    "catppuccin/nvim",
    priority = 1000,
    name = "catppuccin",
    config = function()
      require("catppuccin").setup({
        float = {
          transparent = true,
          solid = false,
        },
        transparent_background = transparency,
        custom_highlights = function(colors)
          return {
            GitSignsChange = { fg = colors.peach },
            WinSeparator = { fg = colors.overlay0 },
            Pmenu = { bg = colors.surface0 },
            debugPC = { bg = colors.surface1 },
            SignColumn = { fg = colors.maroon }, -- For breakpoints
          }
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
}
