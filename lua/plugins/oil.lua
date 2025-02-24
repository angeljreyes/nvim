return {
  "stevearc/oil.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  priority = 900,
  config = function()
    local oil = require("oil")
    vim.keymap.set(
      "n",
      "-",
      function() oil.open(nil, { preview = { vertical = true } }) end,
      { desc = "Open Oil in parent directory" }
    )
    oil.setup({
      default_file_explorer = true,
      skip_confirm_for_simple_edits = true,
      watch_for_changes = true,
      view_options = {
        show_hidden = true,
        is_always_hidden = function(name) return name == ".." end,
      },
      keymaps = {
        --  NOTE: <angle-bracket> notation IS case sensitive here
        --        Casing must match the default for the keymap to be
        --        overridden
        --        See :help oil-config for a list of default keymaps
        ["<C-c>"] = false,
        ["q"] = "actions.close",
        ["gq"] = "q",
      },
    })
  end,
}
