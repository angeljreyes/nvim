return {
  "3rd/image.nvim",
  enabled = Utils.is_profile("home"),
  opts = {
    backend = "kitty",
  },
  dependencies = {
    "kiyoon/magick.nvim",
  },
}
