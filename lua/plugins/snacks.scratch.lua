---@module "snacks"

local scratch_fts = {
  {
    keymap = "l",
    ft = "lua",
    name = "Lua",
  },
  {
    keymap = "c",
    ft = "cs",
    name = "C#",
  },
  {
    keymap = "p",
    ft = "python",
    name = "Python",
  },
  {
    keymap = "j",
    ft = "javascript",
    name = "JavaScript",
  },
  {
    keymap = "t",
    ft = "typescript",
    name = "TypeScript",
  },
  {
    keymap = "r",
    ft = "rust",
    name = "Rust",
  },
}

local specific_fts = {}

for _, t in ipairs(scratch_fts) do
  table.insert(specific_fts, {
    "<leader>." .. t.keymap,
    ---@diagnostic disable-next-line: missing-fields
    function() Snacks.scratch({ ft = t.ft }) end,
    desc = "Open " .. t.name .. " scratch window",
  })
end

return {
  {
    "angeljreyes/scratch-runner.nvim",
    dependencies = "folke/snacks.nvim",

    ---@module "scratch-runner"
    ---@type scratch-runner.Config
    opts = {
      sources = {
        python = { { Utils.on_windows and "py" or "python3" }, extension = "py" },
        javascript = { { "deno" }, extension = "js" },
        typescript = { { "deno" }, extension = "ts" },
        cs = { "dotnet-script" },
        rust = {
          function(filepath, bin_path) return { "rustc", filepath, "-o", bin_path } end,
          extension = "rs",
          binary = true,
        },
        c = {
          function(filepath, bin_path) return { "gcc", filepath, "-o", bin_path } end,
          extension = "c",
          binary = true,
        },
        cpp = {
          function(filepath, bin_path) return { "g++", filepath, "-o", bin_path } end,
          extension = "cpp",
          binary = true,
        },
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
          Snacks.picker.select(filetypes, nil, function(ft)
            if ft then
              ---@diagnostic disable-next-line: missing-fields
              Snacks.scratch({ ft = ft })
            end
          end)
        end,
        desc = "Open some filetype scratch window",
      },
      unpack(specific_fts),
    },

    opts = {
      ---@type snacks.scratch.Config
      ---@diagnostic disable-next-line: missing-fields
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
