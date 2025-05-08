return {
  {
    "mfussenegger/nvim-dap",
    keys = function()
      local dap = require("dap")
      return {
        { "<Leader>db", function() dap.toggle_breakpoint() end, desc = "Toggle breakpoint" },
        {
          "<Leader>dB",
          function()
            vim.ui.input(nil, function(value)
              if value == nil or value == "" then
                return
              end
              dap.set_breakpoint(value)
            end)
          end,
          desc = "Set conditional breakpoint",
        },
        { "<Leader>dq", function() dap.clear_breakpoints() end, desc = "Clear breakpoints" },
        { "<leader>dc", function() dap.continue() end, desc = "Continue" },
        { "<leader>dn", function() dap.step_over() end, desc = "Step over" },
        { "<leader>di", function() dap.step_into() end, desc = "Step into" },
        { "<leader>do", function() dap.step_out() end, desc = "Step out" },
        { "<leader>dp", function() dap.step_back() end, desc = "Step back" },
        { "<leader>dr", function() dap.restart() end, desc = "Restart" },
        { "<leader>dg", function() dap.run_to_cursor() end, desc = "Continue until line under cursor" },
        { "<leader>dG", function() dap.goto_() end, desc = "Go to line under cursor" },
        { "<leader>du", function() dap.up() end, desc = "Go up in the stack" },
        { "<leader>dd", function() dap.down() end, desc = "Go down in the stack" },
        { "<leader>ds", function() dap.stop() end, desc = "Stop" },
      }
    end,
  },

  {
    "rcarriga/nvim-dap-ui",
    dependencies = {
      "mfussenegger/nvim-dap",
      "nvim-neotest/nvim-nio",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")
      dapui.setup()
      dap.listeners.before.attach.dapui_config = dapui.open
      dap.listeners.before.launch.dapui_config = dapui.open
      dap.listeners.before.event_terminated.dapui_config = dapui.close
      dap.listeners.before.event_exited.dapui_config = dapui.close
    end,
  },

  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = {
      "mfussenegger/nvim-dap",
      "williamboman/mason.nvim",
    },
    opts = function()
      return {
        handlers = {
          function(config)
            -- all sources with no handler get passed here
            -- Keep original functionality
            require("mason-nvim-dap").default_setup(config)
          end,
          python = function(config)
            local cmd = Utils.on_windows and "py" or "python3"
            config.adapters = {
              type = "executable",
              command = cmd,
              args = {
                "-m",
                "debugpy.adapter",
              },
            }
            require("mason-nvim-dap").default_setup(config)
          end,
        },
      }
    end,
  },
}
