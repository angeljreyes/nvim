local function get_indentation_style()
  if vim.bo.expandtab then
    return vim.bo.shiftwidth .. " spaces"
  else
    return "tabs"
  end
end

local function get_line_amount() return tostring(vim.fn.line("$")) .. "L" end

return {
  "nvim-tree/nvim-web-devicons",

  {
    "uga-rosa/ccc.nvim",
    lazy = false,
    keys = {
      { "<leader>cc", "<cmd>CccPick<cr>", desc = "Pick a color" },
      { "<leader>cC", "<cmd>CccConvert<cr>", desc = "Convert color format" },
    },
    opts = function()
      local m = require("ccc").mapping

      return {
        highlighter = {
          auto_enable = true,
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
        },
      }
    end,
  },

  {
    "folke/which-key.nvim",
    opts = {
      ---@module "which-key"
      ---@type wk.Spec
      spec = {
        { "<leader>a", group = "Harpoon" },
        { "<leader>c", group = "Code" },
        { "<leader>d", group = "Debugger" },
        { "<leader>h", group = "Git hunk" },
        { "<leader>s", group = "Search" },
        { "<leader>.", group = "Open scratch window" },
        { "<leader>", group = "Visual <leader>", mode = "v" },
        { "<leader>h", group = "Git hunk", mode = "v" },
      },
    },
  },

  {
    "mcauley-penney/visual-whitespace.nvim",
    opts = function()
      return {
        highlight = {
          bg = vim.api.nvim_get_hl(0, { name = "Visual" }).bg,
          fg = vim.api.nvim_get_hl(0, { name = "NonText" }).fg,
        },
      }
    end,
  },

  {
    "folke/todo-comments.nvim",
    dependencies = "nvim-lua/plenary.nvim",
    keys = function()
      local tc = require("todo-comments")
      return {
        { "]t", function() tc.jump_next() end, desc = "Next todo comment" },
        { "[t", function() tc.jump_prev() end, desc = "Previous todo comment" },
      }
    end,
    opts = { signs = false },
  },

  {
    "nvim-lualine/lualine.nvim",
    opts = {
      options = {
        icons_enabled = true,
        theme = "auto",
        section_separators = { left = "", right = "" },
        component_separators = { left = "/", right = "/" },
        disabled_filetypes = {
          statusline = { "snacks_dashboard" },
        },
      },
      sections = {
        lualine_b = {
          "branch",
          "diff",
          {
            "diagnostics",
            symbols = {
              error = " ",
              warn = " ",
              info = " ",
              hint = "󰌵 ",
            },
          },
        },
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
          get_indentation_style,
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
          get_line_amount,
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

  {
    "b0o/incline.nvim",
    opts = function()
      local devicons = require("nvim-web-devicons")

      return {
        window = {
          padding = 0,
          margin = { horizontal = 0 },
          winhighlight = { Normal = "lualine_b_normal" },
        },
        hide = {
          focused_win = true,
          only_win = true,
        },
        ignore = {
          buftypes = { "acwrite", "nofile", "nowrite", "quickfix", "terminal", "prompt" },
          unlisted_buffers = false,
        },
        render = function(props)
          local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(props.buf), ":t")

          if filename == "" then
            filename = "[No Name]"
          end

          local ft_icon, ft_color = devicons.get_icon_color(filename)
          local modified = vim.bo[props.buf].modified
          return {
            ft_icon and { " ", ft_icon, " ", guifg = ft_color } or "",
            { filename, gui = modified and "bold,italic" or "bold" },
            " ",
            -- guibg = "#45475a",
          }
        end,
      }
    end,
  },
}
