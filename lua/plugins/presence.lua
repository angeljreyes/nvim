return {
  "neoclide/coc.nvim",
  enabled = vim.env.NVIM_HOME_PROFILE,
  branch = "release",
  build = ":CocInstall coc-discord-rpc",
}
