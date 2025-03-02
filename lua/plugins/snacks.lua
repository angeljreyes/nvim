---@module "snacks"

return {
  "folke/snacks.nvim",
  priority = 1001,
  lazy = false,

  keys = {
    { "<leader>nd", function() Snacks.notifier.hide() end, desc = "Dismiss all notifications" },
    { "<leader>nh", function() Snacks.notifier.show_history() end, desc = "Notification history" },
  },

  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    bufdelete = { enabled = true },
    notifier = { enabled = true },
    image = { enabled = true },
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
    },
  },

  config = function(_, opts)
    vim.api.nvim_create_user_command("Q", function(cmd_opts) Snacks.bufdelete({ force = cmd_opts.bang }) end, {
      desc = "Delete the current buffer without closing the current window",
      bang = true,
    })

    Snacks.setup(opts)
  end,
}
