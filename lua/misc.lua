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
