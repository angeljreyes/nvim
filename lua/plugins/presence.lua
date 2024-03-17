return {
  "andweeb/presence.nvim",
  -- Enter with `nvim +NoPresence` to avoid loading this plugin. This is
  -- useful when trying to avoid crashing Neovim when opening more
  -- than one instance of Neovim at a time.
  cond = function()
    vim.api.nvim_create_user_command("NoPresence", "exec", {})
    vim.api.nvim_create_autocmd("VimEnter", { pattern = "*", command = "delcommand NoPresence" })
    return vim.fn.index(vim.v.argv, "+NoPresence") < 0
  end,
}
