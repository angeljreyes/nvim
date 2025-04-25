---@module "snacks"

local function directory_picker()
  return Snacks.picker({
    finder = function()
      local directories = {}

      local handle = io.popen("fd . --type directory")
      if handle then
        for line in handle:lines() do
          table.insert(directories, line)
        end
        handle:close()
      else
        vim.notify("Failed to execute fd command", vim.log.levels.ERROR)
      end

      local items = {}
      for i, item in ipairs(directories) do
        table.insert(items, {
          idx = i,
          file = item,
          text = item,
        })
      end
      return items
    end,
    format = function(item, _)
      local file = item.file
      local format = {}
      local align = Snacks.picker.util.align
      local icon, icon_hl = Snacks.util.icon(file.ft, "directory")

      format[#format + 1] = { align(icon, 3), icon_hl }
      format[#format + 1] = { " " }
      format[#format + 1] = { align(file, 20) }

      return format
    end,
    confirm = function(picker, item)
      picker:close()
      ---@module "mini.files"
      MiniFiles.open(item.file, false)
    end,
  })
end

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>ss", function() Snacks.picker() end, desc = "Search pickers" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume last picker" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Search files" },
    { "<leader>F", function() directory_picker() end, desc = "Search directories" },
    { "<leader>s?", function() Snacks.picker.recent() end, desc = "Search recent files" },
    { "<leader>sb", function() Snacks.picker.buffers() end, desc = "Search buffers" },
    { "<leader>u", function() Snacks.picker.undo() end, desc = "Undotree" },
    { "<leader>sd", function() Snacks.picker.diagnostics_buffer() end, desc = "Search diagnostics in buffer" },
    { "<leader>sD", function() Snacks.picker.diagnostics() end, desc = "Search all diagnostics" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Search help" },
    { "<leader>sk", function() Snacks.picker.keymaps() end, desc = "Search keymaps" },
    ---@diagnostic disable-next-line: undefined-field
    { "<leader>st", function() Snacks.picker.todo_comments() end, desc = "Search TODOs" },
    { "<leader>sg", function() Snacks.picker.grep() end, desc = "Grep" },
    { "<leader>/", function() Snacks.picker.lines() end, desc = "Search lines in buffer" },
    { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "Grep buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep current word" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Search quickfix list" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Search location list" },
    { "<leader>sc", function() Snacks.picker.git_log_file() end, desc = "Search git commits on this file" },

    { "gd", function() Snacks.picker.lsp_definitions() end, "Go to definition" },
    { "grr", function() Snacks.picker.lsp_references() end, "Go to references" },
    { "gri", function() Snacks.picker.lsp_implementations() end, "Go to implementation" },
    { "gC", function() Snacks.picker.lsp_type_definitions() end, "Search type definitions" },
    { "gO", function() Snacks.picker.lsp_symbols() end, "Search document symbols" },
    { "gW", function() Snacks.picker.lsp_workspace_symbols() end, "Search workspace symbols" },
  },

  ---@type snacks.Config
  opts = {
    explorer = {
      enabled = true,
      replace_netrw = false,
    },

    picker = {
      enabled = true,
      layout = {
        preset = "default",
        layout = {
          width = 0.88,
          height = 0.88,
        },
      },

      matcher = {
        frecency = true,
      },

      win = {
        input = {
          keys = {
            ["<c-c>"] = { "close", mode = "n" },
          },
        },
        list = {
          wo = {
            scrolloff = 4,
          },
        },
      },

      ---@diagnostic disable-next-line: missing-fields
      icons = {
        diagnostics = { Hint = "󰌵 " },
      },

      layouts = {
        dropdown = {
          layout = {
            backdrop = false,
            width = 0.5,
            min_width = 80,
            height = 0.8,
            border = "none",
            box = "vertical",
            { win = "preview", title = "{preview}", height = 0.6, border = "rounded" },
            {
              box = "vertical",
              border = "rounded",
              title = "{title} {live} {flags}",
              title_pos = "center",
              { win = "input", height = 1, border = "bottom" },
              { win = "list", border = "none" },
            },
          },
        },
      },

      sources = {
        undo = { focus = "list" },

        select = {
          layout = {
            layout = { width = 0.5 },
          },
          win = {
            input = {
              keys = {
                ["<c-c>"] = { "close", mode = { "n", "i" } },
              },
            },
          },
        },

        help = {
          win = {
            input = {
              keys = {
                ["<cr>"] = { "edit_vsplit", mode = { "i", "n" } },
              },
            },
          },
        },

        lines = {
          layout = {
            preset = "vertical",
            fullscreen = true,
            ---@diagnostic disable-next-line: assign-type-mismatch
            preview = true,
            layout = {
              border = "top",
            },
          },
        },

        explorer = {
          hidden = true,
          ignored = true,
          auto_close = true,
          layout = {
            ---@diagnostic disable-next-line: assign-type-mismatch
            preview = true,
            preset = "default",
          },
          win = {
            list = {
              keys = {
                -- Making it more similar to oil.nvim
                S = "explorer_rename",
                o = "explorer_add",
                gx = "explorer_open",
                ["<c-c>"] = false,
                ["~"] = "tcd",
                ["-"] = "explorer_up",
              },
            },
          },
        },
      },
    },
  },
}
