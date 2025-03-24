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
    ---@module "mini.files"
    "echasnovski/mini.files",
    lazy = false,
    keys = {
      { "<leader>f", function() MiniFiles.open() end, desc = "Open files" },
    },
    opts = {
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        max_number = 3,
        preview = true,
        width_focus = 70,
        width_nofocus = 40,
        width_preview = 60,
      },
      mappings = {
        go_in = "L",
        go_in_plus = "<cr>",
        go_out = "",
        go_out_plus = "H",
      },
    },
    config = function(_, opts)
      require("mini.files").setup(opts)
      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesWindowOpen",
        callback = function(args)
          local win = args.data.win_id
          local config = vim.api.nvim_win_get_config(win)
          config.border = "rounded"
          config.title_pos = "center"
          vim.api.nvim_win_set_config(win, config)
        end,
      })
    end,
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
