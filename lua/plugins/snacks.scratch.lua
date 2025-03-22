---@module "snacks"

return {
  {
    "DestopLine/scratch-runner.nvim",
    dependencies = "folke/snacks.nvim",
    opts = {
      sources = {
        python = { Utils.on_windows and "py" or "python3" },
        javascript = { "node" },
        cs = { "dotnet-script" },
      },
    },
  },

  {
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

    opts = {
      ---@type snacks.scratch.Config
      scratch = {
        filekey = {
          branch = false,
          cwd = false,
        },
        win = {
          relative = "editor",
          width = 0.7,
          height = 0.8,
        },
      },
    },
  },
}
