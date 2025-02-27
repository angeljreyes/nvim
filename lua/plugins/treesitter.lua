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

  "nvim-treesitter/nvim-treesitter-textobjects",

  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",

    ---@type TSConfig
    opts = {
      -- Add languages to be installed here that you want installed for treesitter
      ensure_installed = {
        "lua",
        "vimdoc",
        "vim",
      },

      -- Autoinstall languages that are not installed. Defaults to false (but you can change for yourself!)
      auto_install = true,
      -- Install languages synchronously (only applied to `ensure_installed`)
      sync_install = false,
      -- List of parsers to ignore installing
      ignore_install = {},
      -- You can specify additional Treesitter modules here: -- For example: -- playground = {--enable = true,-- },
      modules = {},
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = {
        enable = false,
        keymaps = {
          init_selection = "<c-space>",
          node_incremental = "<c-space>",
          scope_incremental = "<c-s>",
          node_decremental = "<M-space>",
        },
      },
      textobjects = {
        select = {
          enable = true,
          lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
          keymaps = {
            -- You can use the capture groups defined in textobjects.scm
            ["aa"] = "@parameter.outer",
            ["ia"] = "@parameter.inner",
            ["af"] = "@function.outer",
            ["if"] = "@function.inner",
            ["ac"] = "@class.outer",
            ["ic"] = "@class.inner",
          },
        },
        move = {
          enable = true,
          set_jumps = true, -- whether to set jumps in the jumplist
          goto_next_start = {
            ["]m"] = "@function.outer",
            ["]]"] = "@class.outer",
          },
          goto_next_end = {
            ["]M"] = "@function.outer",
            ["]["] = "@class.outer",
          },
          goto_previous_start = {
            ["[m"] = "@function.outer",
            ["[["] = "@class.outer",
          },
          goto_previous_end = {
            ["[M"] = "@function.outer",
            ["[]"] = "@class.outer",
          },
        },
        swap = {
          enable = true,
          swap_next = {
            ["<leader>cp"] = "@parameter.inner",
          },
          swap_previous = {
            ["<leader>cP"] = "@parameter.inner",
          },
        },
      },
    },

    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)

      local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
      ---@diagnostic disable-next-line: inject-field
      parser_config.monkey = {
        install_info = {
          url = "https://github.com/jamestrew/tree-sitter-monkey.git",
          files = { "src/parser.c" },
        },
        filetype = "mon",
      }
    end,
  },
}
