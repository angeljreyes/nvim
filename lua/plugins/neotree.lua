return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
    {
      "3rd/image.nvim",
      enabled = vim.env.NVIM_HOME_PROFILE,
      opts = {
        backend = "kitty",
      },
      dependencies = {
        "vhyrro/luarocks.nvim",
        priority = 1001, -- this plugin needs to run before anything else
        opts = {
          rocks = { "magick" },
        },
      },
    }, -- Optional image support in preview window:
    -- See `# Preview Mode` for more information
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
            ["[c"] = "prev_git_modified",
            ["]c"] = "next_git_modified",
          },
        },
        hijack_netrw_behavior = "open_current",
      },
    })
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
}
