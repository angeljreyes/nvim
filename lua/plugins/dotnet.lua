return {
  {
    "DestopLine/boilersharp.nvim",
    dev = Utils.is_profile("home"),
    opts = {},
  },

  {
    "GustavEikaas/easy-dotnet.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "mfussenegger/nvim-dap",
    },
    config = function()
      local dotnet = require("easy-dotnet")
      local dap = require("dap")

      dotnet.setup({
        picker = "basic",
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
      })

      --- Rebuilds the project before starting the debug session
      ---@param co thread
      local function rebuild_project(co, path)
        local spinner = require("easy-dotnet.ui-modules.spinner").new()
        spinner:start_spinner("Building")
        vim.fn.jobstart(string.format("dotnet build %s", path), {
          on_exit = function(_, return_code)
            if return_code == 0 then
              spinner:stop_spinner("Built successfully")
            else
              spinner:stop_spinner("Build failed with exit code " .. return_code, vim.log.levels.ERROR)
              error("Build failed")
            end
            coroutine.resume(co)
          end,
        })
        coroutine.yield()
      end

      local debug_dll = nil

      local function ensure_dll()
        if debug_dll ~= nil then
          return debug_dll
        end
        local dll = dotnet.get_debug_dll()
        debug_dll = dll
        return dll
      end

      for _, value in ipairs({ "cs", "fsharp" }) do
        dap.configurations[value] = {
          {
            type = "coreclr",
            name = "launch - netcoredbg",
            request = "launch",
            env = function()
              local dll = ensure_dll()
              local vars = dotnet.get_environment_variables(dll.project_name, dll.relative_project_path)
              return vars or nil
            end,
            program = function()
              local dll = ensure_dll()
              local co = coroutine.running()
              rebuild_project(co, dll.project_path)
              return dll.relative_dll_path
            end,
            cwd = function()
              local dll = ensure_dll()
              return dll.relative_project_path
            end,
          },
        }
      end

      dap.listeners.before["event_terminated"]["easy-dotnet"] = function() debug_dll = nil end

      dap.adapters.coreclr = {
        type = "executable",
        command = "netcoredbg",
        args = { "--interpreter=vscode" },
      }
    end,
  },
}
