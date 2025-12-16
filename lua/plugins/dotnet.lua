return {
  {
    "angeljreyes/boilersharp.nvim",
    opts = {},
  },

  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    opts = function()
      return {
        test_runner = {
          viewmode = "float",
          mappings = {
            filter_failed_tests = { lhs = "f", desc = "Filter failed tests" },
            debug_test = { lhs = "<leader>db", desc = "Debug test" },
            run_all = { lhs = "R", desc = "Run all tests" },
            run = { lhs = "r", desc = "Run test" },
            peek_stacktrace = { lhs = "p", desc = "Peek stacktrace of failed test" },
            expand = { lhs = ";", desc = "Toggle node" },
            expand_node = { lhs = "e", desc = "Expand node" },
            expand_all = { lhs = "E", desc = "Expand all" },
            collapse_node = { lhs = "c", desc = "Collapse node" },
            collapse_all = { lhs = "C", desc = "Collapse all" },
          },
        },
        auto_bootstrap_namespace = false,
        lsp = {
          enabled = false,
        },
        debugger = {
          bin_path = vim.fn.expand("$MASON/packages/netcoredbg/netcoredbg"),
        },
      }
    end,
  },
}
