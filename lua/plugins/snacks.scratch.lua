---@module "snacks"

---@param cmd string[] | fun(filepath: string): string[]
local function make_source_key(cmd)
  ---@type snacks.win.Keys
  return {
    source = {
      "<cr>",
      ---@param window snacks.win
      function(window)
        vim.cmd("silent w")

        local filepath = vim.api.nvim_buf_get_name(window.buf)
        local final_cmd

        if type(cmd) == "function" then
          final_cmd = cmd(filepath)
        elseif type(cmd) == "table" then
          final_cmd = cmd
          table.insert(final_cmd, filepath)
        else
          error("cmd must be a list of strings or a function that returns a list of strings")
        end

        if vim.fn.executable(final_cmd[1]) == 0 then
          vim.notify(final_cmd[1] .. " wasn't found on your system.", vim.log.levels.ERROR)
          return
        end

        local result_window = Snacks.win({
          width = 0.7,
          style = "scratch",
          zindex = 30,
          title = " Running... ",
          ft = "text",
          bo = { filetype = "text", modifiable = false, buftype = "", bufhidden = "hide", swapfile = false },
          keys = { q = "close" },
        })

        ---@param lhs string
        ---@param desc string
        local function footer_insert_key(lhs, desc)
          table.insert(result_window.opts.footer, { " " })
          table.insert(result_window.opts.footer, { " " .. lhs .. " ", "SnacksScratchKey" })
          table.insert(result_window.opts.footer, { " " .. desc .. " ", "SnacksScratchDesc" })
        end

        local function footer_add_quit() footer_insert_key("q", "Go back") end

        vim.system(
          final_cmd,
          { text = true },
          vim.schedule_wrap(function(output)
            local stdout, stderr
            if output.stdout and output.stdout ~= "" then
              stdout = vim.split(output.stdout or "", "\n")
            end
            if output.stderr and output.stderr ~= "" then
              stderr = vim.split(output.stderr, "\n")
            end

            vim.bo[result_window.buf].modifiable = true
            vim.api.nvim_buf_set_lines(result_window.buf, 0, -1, false, stdout or stderr or { "" })
            vim.bo[result_window.buf].modifiable = false
            if not stdout and stderr then
              result_window.opts.title = {
                { " " },
                { " ", "Error" },
                { " Code Output " },
              }
              result_window.opts.footer = {}
              footer_add_quit()
            elseif stdout and stderr then
              local showing_stderr = false
              result_window.opts.title = {
                { " " },
                { " ", "WarningMsg" },
                { " Code Output " },
              }
              result_window.opts.footer = {}
              footer_insert_key("<Tab>", "Show stderr")
              footer_add_quit()
              vim.keymap.set("n", "<tab>", function()
                result_window.opts.footer = {}
                vim.bo[result_window.buf].modifiable = true
                if showing_stderr then
                  vim.api.nvim_buf_set_lines(result_window.buf, 0, -1, false, stdout)
                  footer_insert_key("<Tab>", "Show stderr")
                else
                  vim.api.nvim_buf_set_lines(result_window.buf, 0, -1, false, stderr)
                  footer_insert_key("<Tab>", "Show stdout")
                end
                vim.bo[result_window.buf].modifiable = false
                footer_add_quit()
                showing_stderr = not showing_stderr
                result_window:update()
              end, { desc = "Show stdout/stderr", buffer = result_window.buf })
            else
              result_window.opts.title = {
                { " " },
                { " ", "Added" },
                { " Code Output " },
              }
              result_window.opts.footer = {}
              footer_add_quit()
            end
            result_window:update()
          end)
        )
      end,
      desc = "Source buffer",
    },
  }
end

return {
  "folke/snacks.nvim",

  keys = {
    { "<leader>..", function() Snacks.scratch() end, desc = "Open current filetype scratch window" },
    {
      "<leader>./",
      function()
        local filetypes = vim.fn.getcompletion("", "filetype")
        ---@diagnostic disable-next-line: missing-fields
        Snacks.picker.select(filetypes, nil, function(ft) Snacks.scratch({ ft = ft }) end)
      end,
      desc = "Open some filetype scratch window",
    },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>.l", function() Snacks.scratch({ ft = "lua" }) end, desc = "Open Lua scratch window" },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>.c", function() Snacks.scratch({ ft = "cs" }) end, desc = "Open C# scratch window" },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>.p", function() Snacks.scratch({ ft = "python" }) end, desc = "Open Python scratch window" },
    ---@diagnostic disable-next-line: missing-fields
    { "<leader>.j", function() Snacks.scratch({ ft = "javascript" }) end, desc = "Open JavaScript scratch window" },
  },

  ---@type snacks.Config
  opts = {
    scratch = {
      win = {
        relative = "editor",
        width = 0.7,
      },
      win_by_ft = {
        python = { keys = make_source_key({ Utils.on_windows and "py" or "python3" }) },
        javascript = { keys = make_source_key({ "node" }) },
        cs = { keys = make_source_key({ "dotnet-script" }) },
      },
    },
  },
}
