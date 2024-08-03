return {
  { "jlcrochet/vim-razor" },

  { "OrangeT/vim-csharp" },

  { "nvim-tree/nvim-web-devicons" },

  {
    "OXY2DEV/markview.nvim",
    ft = "markdown",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "nvim-tree/nvim-web-devicons",
    },
  },

  {
    "folke/todo-comments.nvim",
    enabled = vim.env.NVIM_PROFILE == "home",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local tc = require("todo-comments")
      tc.setup({
        signs = false,
      })
      vim.keymap.set("n", "]t", function() tc.jump_next() end, { desc = "Next todo comment" })
      vim.keymap.set("n", "[t", function() tc.jump_prev() end, { desc = "Previous todo comment" })
      vim.keymap.set("n", "<leader>st", vim.cmd.TodoTelescope, { desc = "Search todo comments" })
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
      },
      sections = {
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            path = 1,
            symbols = {
              modified = " ",
              readonly = " ",
              newfile = " ",
            },
            fmt = function(s, _) return s:gsub([[\]], "/") end,
          },
        },
        lualine_x = {
          "encoding",
          function()
            if vim.bo.expandtab then
              return vim.bo.shiftwidth .. " spaces"
            else
              return "tabs"
            end
          end,
          {
            "fileformat",
            symbols = {
              unix = "lf",
              dos = "crlf",
              mac = "cr",
            },
          },
          "filetype",
        },
        lualine_y = { "progress", "location" },
        lualine_z = {},
      },
      inactive_sections = {
        lualine_c = {
          {
            "filename",
            newfile_status = true,
            symbols = {
              modified = " ",
              readonly = " ",
              newfile = " ",
            },
          },
        },
      },
    },
  },
}
