return {
  "akinsho/toggleterm.nvim",
  version = "*",
  keys = {
    { "<C-t>", vim.cmd.ToggleTerm },
  },
  cmd = "ToggleTerm",
  config = function()
    require("toggleterm").setup({
      open_mapping = [[<c-t>]],
    })
    -- Add terminal only keymaps
    function _G.set_terminal_keymaps()
      local opts = { buffer = 0 }
      vim.keymap.set("t", "<esc>", [[<C-\><C-n>]], opts)
      vim.keymap.set("t", "<C-w>", [[<C-\><C-n><C-w>]], opts)
    end

    -- If you only want these mappings for toggle term use term://*toggleterm#* instead
    vim.cmd("autocmd! TermOpen term://* lua set_terminal_keymaps()")
  end,
}
