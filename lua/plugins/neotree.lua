return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  config = function()
    require("neo-tree").setup({
      default_component_configs = {
        modified = {
          symbol = "",
          highlight = "NeoTreeModified",
        },
        git_status = {
          symbols = {
            -- Change type
            added = "A", -- or "✚", but this is redundant info if you use git_status_colors on the name
            modified = "M", -- or "", but this is redundant info if you use git_status_colors on the name
            deleted = "D", -- this can only be used in the git_status source
            renamed = "R", -- this can only be used in the git_status source
            -- Status type
            -- untracked = "",
            -- ignored = "",
            -- unstaged = "󰄱;",
            -- staged = "",
            -- conflict = "",
          },
        },
      },
      window = {
        mappings = {
          ["<space>"] = "",
          [";"] = "toggle_node",
        },
      },
      filesystem = {
        window = {
          mappings = {
            ["[g"] = "",
            ["]g"] = "",
            ["[h"] = "prev_git_modified",
            ["]h"] = "next_git_modified",
          },
        },
        hijack_netrw_behavior = "disabled",
      },
    })
    vim.keymap.set(
      "n",
      "<leader>f",
      "<cmd>Neotree toggle position=right<cr>",
      { desc = "File explorer on the right" }
    )
  end,
}
