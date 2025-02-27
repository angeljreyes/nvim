---@module "snacks"

return {
  "folke/snacks.nvim",
  keys = {
    { "<leader>f", function() Snacks.explorer() end, desc = "File explorer" },
    { "<leader>ss", function() Snacks.picker() end, desc = "Search pickers" },
    { "<leader>sr", function() Snacks.picker.resume() end, desc = "Resume last picker" },
    { "<leader>sf", function() Snacks.picker.files() end, desc = "Search files" },
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
    { "<leader>s/", function() Snacks.picker.grep_buffers() end, desc = "Grep buffers" },
    { "<leader>sw", function() Snacks.picker.grep_word() end, desc = "Grep current word" },
    { "<leader>sq", function() Snacks.picker.qflist() end, desc = "Search quickfix list" },
    { "<leader>sl", function() Snacks.picker.loclist() end, desc = "Search location list" },
    { "<leader>sc", function() Snacks.picker.git_log_file() end, desc = "Search git commits on this file" },
  },

  ---@type snacks.Config
  opts = {
    explorer = {
      enabled = true,
      replace_netrw = true,
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

        explorer = {
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
