return {
  {
    ---@module "mini.files"
    "echasnovski/mini.files",
    lazy = false,
    keys = {
      {
        "<leader>f",
        function()
          local ok = pcall(function() MiniFiles.open(vim.api.nvim_buf_get_name(0)) end)
          if not ok then
            MiniFiles.open()
          end
        end,
        desc = "Open files",
      },
    },
    opts = {
      options = {
        use_as_default_explorer = true,
      },
      windows = {
        max_number = 3,
        preview = true,
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
          config.title_pos = "center"
          vim.api.nvim_win_set_config(win, config)
        end,
      })

      vim.api.nvim_create_autocmd("User", {
        pattern = "MiniFilesExplorerOpen",
        callback = function(_) MiniFiles.reveal_cwd() end,
      })

      local function set_window_widths()
        MiniFiles.config.windows.width_nofocus = math.floor(0.25 * vim.o.columns)
        MiniFiles.config.windows.width_focus = math.floor(0.30 * vim.o.columns)
        MiniFiles.config.windows.width_preview = math.floor(0.35 * vim.o.columns)
      end
      set_window_widths()
      vim.api.nvim_create_autocmd("VimResized", { callback = set_window_widths })
    end,
  },

  {
    "ThePrimeagen/harpoon",
    branch = "harpoon2",
    dependencies = {
      "nvim-lua/plenary.nvim",
    },
    config = function()
      local harpoon = require("harpoon")
      harpoon:setup({
        settings = {
          save_on_toggle = true,
          sync_on_ui_close = true,
        },
      })

      ---@param index integer index to select a list item
      ---@return function
      local function sel(index)
        return function() harpoon:list():select(index) end
      end

      vim.keymap.set(
        "n",
        "<leader>as",
        function() harpoon.ui:toggle_quick_menu(harpoon:list()) end,
        { desc = "Search" }
      )
      vim.keymap.set("n", "<leader>an", function() harpoon:list():add() end, { desc = "New index" })

      vim.keymap.set("n", "<leader>aj", sel(1), { desc = "First index" })
      vim.keymap.set("n", "<leader>ak", sel(2), { desc = "Second index" })
      vim.keymap.set("n", "<leader>al", sel(3), { desc = "Third index" })
      vim.keymap.set("n", "<leader>a;", sel(4), { desc = "Fourth index" })

      vim.keymap.set("n", "<leader>ac", function() harpoon:list():clear() end, { desc = "Clear list" })

      -- Toggle previous & next buffers stored within Harpoon list
      vim.keymap.set("n", "[a", function() harpoon:list():prev() end, { desc = "Previous harpoon index" })
      vim.keymap.set("n", "]a", function() harpoon:list():next() end, { desc = "Next harpoon index" })
    end,
  },
}
