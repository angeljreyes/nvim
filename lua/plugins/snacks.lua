---@module "snacks"

return {
  "folke/snacks.nvim",
  priority = 1001,
  lazy = false,

  keys = {
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss All Notifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification History" },
  },

  config = function()
    vim.api.nvim_create_user_command("Q", function(cmd_opts) Snacks.bufdelete({ force = cmd_opts.bang }) end, {
      desc = "Delete the current buffer without closing the current window",
      bang = true,
    })

    Snacks.setup({
      bigfile = { enabled = true },
      bufdelete = { enabled = true },

      dashboard = {
        enabled = true,
        sections = {
          { section = "header" },
          { section = "keys", gap = 1, padding = { 2, 0 } },
          { section = "recent_files", cwd = true, icon = " ", title = "Recent Files", indent = 2 },
          { section = "startup", padding = { 0, 2 } },
        },
        preset = {
          keys = {
            { icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
            {
              icon = " ",
              key = "c",
              desc = "Config",
              action = ":lua Snacks.dashboard.pick('files', {cwd = vim.fn.stdpath('config')})",
            },
            { icon = "󰒲 ", key = "l", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
            { icon = " ", key = "m", desc = "Mason", action = ":Mason" },
            { icon = " ", key = "q", desc = "Quit", action = ":qa" },
          },
        },
      },

      input = {
        enabled = true,
        win = {
          style = "input",
          keys = {
            i_cc = { "<c-c>", "stopinsert", mode = "i" },
            i_esc = { "<esc>", "stopinsert", mode = "i" },
            i_ctrl_w = {},
          },
        },
      },

      notifier = { enabled = true },

      scroll = {
        enabled = true,
        animate = {
          fps = 60,
          duration = {
            step = 10,
            total = 150,
          },
          easing = "inOutCubic",
        },
        filter = function(buf)
          -- Neogit Log View scrolling gets glitchy with this plugin enabled
          return not vim.endswith(vim.api.nvim_buf_get_name(buf), "NeogitLogView")
        end,
      },

      image = {
        enabled = true,
      },
    })
  end,
}
