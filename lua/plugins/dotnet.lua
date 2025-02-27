return {
  {
    "DestopLine/boilersharp.nvim",
    dev = Utils.is_profile("home"),
    config = true,
  },

  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      local dotnet = require("easy-dotnet")

      dotnet.setup({
        picker = "basic",
        test_runner = {
          viewmode = "float",
          mappings = {
            filter_failed_tests = { lhs = "f", desc = "filter failed tests" },
            debug_test = { lhs = "<leader>db", desc = "Debug test" },
            run_all = { lhs = "R", desc = "run all tests" },
            run = { lhs = "r", desc = "run test" },
            peek_stacktrace = { lhs = "p", desc = "peek stacktrace of failed test" },
            expand = { lhs = ";", desc = "toggle node" },
            expand_node = { lhs = "e", desc = "expand node" },
            expand_all = { lhs = "E", desc = "expand all" },
            collapse_node = { lhs = "c", desc = "collapse node" },
            collapse_all = { lhs = "C", desc = "collapse all" },
          },
        },
        auto_bootstrap_namespace = false,
      })
    end,
  },
}
