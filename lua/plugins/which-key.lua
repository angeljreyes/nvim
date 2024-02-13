return {
  "folke/which-key.nvim",
  config = function()
    require("which-key").register({
      ["<leader>a"] = { name = "Harpoon", _ = "which_key_ignore" },
      ["<leader>ad"] = { name = "Delete", _ = "which_key_ignore" },
      ["<leader>c"] = { name = "Code", _ = "which_key_ignore" },
      -- ["<leader>d"] = { name = "Debugger", _ = "which_key_ignore" },
      ["<leader>g"] = { name = "Git", _ = "which_key_ignore" },
      ["<leader>h"] = { name = "Git Hunk", _ = "which_key_ignore" },
      ["<leader>s"] = { name = "Search", _ = "which_key_ignore" },
      ["<leader>w"] = { name = "Workspace", _ = "which_key_ignore" },
    })

    require("which-key").register({
      ["<leader>"] = { name = "VISUAL <leader>" },
      ["<leader>h"] = { "git Hunk" },
    }, { mode = "v" })
  end
}
