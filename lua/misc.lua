vim.filetype.add({
  filename = {
    ["picom.conf"] = "cfg",
    ["requirements.txt"] = "requirements",
  },
  pattern = {
    [".*component%.html"] = "angular",
    ["appsettings.*%.json"] = "jsonc",
  },
  extension = {
    mon = "monkey",
    rasi = "rasi",
    rasinc = "rasi",
  },
})

vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking text",
  group = vim.api.nvim_create_augroup("YankHighlight", { clear = true }),
  callback = function() vim.highlight.on_yank() end,
})

vim.api.nvim_create_user_command(
  "Q",
  function(opts)
    local buffer = vim.api.nvim_get_current_buf()
    local is_modified = vim.api.nvim_get_option_value("modified", { buf = buffer })

    if is_modified and not opts.bang then
      vim.notify("No write since last change (add ! to override)", vim.log.levels.ERROR)
      return
    end

    vim.cmd("enew")
    vim.api.nvim_buf_delete(buffer, { force = opts.bang })
  end,
  {
    desc = "Delete the current buffer without closing the current window",
    bang = true,
  }
)
