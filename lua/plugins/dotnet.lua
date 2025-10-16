return {
  {
    "DestopLine/boilersharp.nvim",
    opts = {},
  },

  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
      "tris203/rzls.nvim",
      "williamboman/mason.nvim",
    },
    opts = function()
      local rzls_path = vim.fn.expand("$MASON/packages/rzls/libexec")

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
          config = {
            cmd = {
              "roslyn",
              "--stdio",
              "--logLevel=Information",
              "--extensionLogDirectory=" .. vim.fs.dirname(vim.lsp.get_log_path()),
              "--razorSourceGenerator=" .. vim.fs.joinpath(rzls_path, "Microsoft.CodeAnalysis.Razor.Compiler.dll"),
              "--razorDesignTimePath="
                .. vim.fs.joinpath(rzls_path, "Targets", "Microsoft.NET.Sdk.Razor.DesignTime.targets"),
              "--extension",
              vim.fs.joinpath(rzls_path, "RazorExtension", "Microsoft.VisualStudioCode.RazorExtension.dll"),
            },
            handlers = require("rzls.roslyn_handlers"),
          },
        },
        debugger = {
          bin_path = vim.fn.expand("$MASON/packages/netcoredbg/netcoredbg"),
        },
      }
    end,
  },
}
