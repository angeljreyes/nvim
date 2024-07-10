return {
  "neoclide/coc.nvim",
  enabled = vim.env.NVIM_PROFILE == "home",
  branch = "release",
  build = ":CocInstall coc-discord-rpc",
}
