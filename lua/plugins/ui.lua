return {
  { "nvim-tree/nvim-web-devicons" },

  {
    "folke/todo-comments.nvim",
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
            }
          }
        }
      },
    },
  },
}
