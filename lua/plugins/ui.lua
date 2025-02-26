local function indentation()
  if vim.bo.expandtab then
    return vim.bo.shiftwidth .. " spaces"
  else
    return "tabs"
  end
end

local function line_amount()
  return tostring(vim.fn.line("$")) .. "L"
end

return {
  { "nvim-tree/nvim-web-devicons" },

  {
    "uga-rosa/ccc.nvim",
    config = function()
      vim.keymap.set("n", "<leader>cc", "<cmd>CccPick<cr>", { desc = "Pick a color" })
      vim.keymap.set("n", "<leader>cC", "<cmd>CccConvert<cr>", { desc = "Convert color format" })

      local ccc = require("ccc")
      local m = ccc.mapping

      ccc.setup({
        highlighter = {
          auto_enable = true
        },
        mappings = {
          n = m.goto_next,
          p = m.goto_prev,
          N = m.goto_tail,
          P = m.goto_head,
          w = m.increase5,
          W = m.increase10,
          b = m.decrease5,
          B = m.decrease10,
          ["$"] = m.set100,
          ["_"] = m.set0,
          ["0"] = m.set0,
        }
      })
    end
  },

  {
    "mcauley-penney/visual-whitespace.nvim",
    config = function()
      local bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg
      local fg = vim.api.nvim_get_hl(0, { name = "NonText" }).fg
      require("visual-whitespace").setup({
        highlight = { bg = bg, fg = fg }
      })
    end,
  },

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
    end,
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "/", right = "/" },
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
          indentation,
          {
            "fileformat",
            symbols = {
              unix = "unix",
              dos = "dos",
              mac = "mac",
            },
          },
          "filetype",
        },
        lualine_y = {
          line_amount,
          "progress",
        },
        lualine_z = {
          "location",
        },
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
