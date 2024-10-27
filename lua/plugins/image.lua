return {
  "3rd/image.nvim",
  enabled = vim.env.NVIM_PROFILE == "home",
  opts = {
    backend = "kitty",
  },
  dependencies = {
    "kiyoon/magick.nvim",
  },
}
