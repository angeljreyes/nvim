return {
  {
    "Wansmer/treesj",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = { use_default_keymaps = false },
    keys = function()
      local tsj = require("treesj")
      return {
        { "<leader>m", tsj.toggle, desc = "Toggle node join" },
        {
          "<leader>M",
          function() tsj.toggle({ split = { recursive = true } }) end,
          desc = "Toggle node join recursively",
        },
      }
    end,
  },

  "nvim-treesitter/nvim-treesitter-context",

  {
    "nvim-treesitter/nvim-treesitter-textobjects",
    branch = "main",
    opts = {
      select = {
        lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      },
      move = {
        set_jumps = true, -- whether to set jumps in the jumplist
      },
    },
    config = function(_, opts)
      require("nvim-treesitter-textobjects").setup(opts)

      -- Select
      ---@param lhs string
      ---@param textobject string
      local add_select_keymap = function(lhs, textobject)
        vim.keymap.set(
          { "x", "o" },
          lhs,
          function() require("nvim-treesitter-textobjects.select").select_textobject(textobject, "textobjects") end
        )
      end
      add_select_keymap("aa", "@parameter.outer")
      add_select_keymap("ia", "@parameter.inner")
      add_select_keymap("af", "@function.outer")
      add_select_keymap("if", "@function.inner")
      add_select_keymap("ac", "@class.outer")
      add_select_keymap("ic", "@class.inner")

      -- Move
      ---@param key_start string
      ---@param key_end string
      ---@param textobject string
      local add_move_keymap = function(key_start, key_end, textobject)
        vim.keymap.set(
          { "n", "x", "o" },
          "]" .. key_start,
          function() require("nvim-treesitter-textobjects.move").goto_next_start(textobject, "textobjects") end
        )
        vim.keymap.set(
          { "n", "x", "o" },
          "]" .. key_end,
          function() require("nvim-treesitter-textobjects.move").goto_next_end(textobject, "textobjects") end
        )
        vim.keymap.set(
          { "n", "x", "o" },
          "[" .. key_start,
          function() require("nvim-treesitter-textobjects.move").goto_previous_start(textobject, "textobjects") end
        )
        vim.keymap.set(
          { "n", "x", "o" },
          "[" .. key_end,
          function() require("nvim-treesitter-textobjects.move").goto_previous_end(textobject, "textobjects") end
        )
      end
      add_move_keymap("f", "F", "@function.outer")
      add_move_keymap("]", "[", "@class.outer")

      -- Swap
      vim.keymap.set(
        "n",
        "<leader>cp",
        function() require("nvim-treesitter-textobjects.swap").swap_next("@parameter.inner") end
      )
      vim.keymap.set(
        "n",
        "<leader>cP",
        function() require("nvim-treesitter-textobjects.swap").swap_previous("@parameter.inner") end
      )
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,
    build = ":TSUpdate",
    opts = {},
    config = function(_, opts)
      require("nvim-treesitter").setup(opts)

      vim.api.nvim_create_autocmd("User", {
        pattern = "TSUpdate",
        callback = function()
          ---@diagnostic disable-next-line: missing-fields
          require("nvim-treesitter.parsers").monkey = {
            install_info = {
              url = "https://github.com/jamestrew/tree-sitter-monkey",
              revision = "master",
              queries = "queries",
            },
          }
        end,
      })
    end,
  },

  {
    "MeanderingProgrammer/treesitter-modules.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    opts = {
      auto_install = true,
      fold = { enable = true },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<m-space>",
        },
      },
    },
  },
}
