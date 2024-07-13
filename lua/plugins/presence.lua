-- presence.nvim crashes on Windows when Neovim is opened more than once
-- coc-discord-rpc is an alternative that works but requires coc which
-- requires npm and some extra configuring
local on_windows = vim.uv.os_uname().sysname == "Windows_NT"

return {
  {
    "neoclide/coc.nvim",
    enabled = vim.env.NVIM_PROFILE == "home" and on_windows,
    branch = "release",
    build = ":CocInstall coc-discord-rpc",
  },

  {
    "andweeb/presence.nvim",
    enabled = vim.env.NVIM_PROFILE == "home" and not on_windows,
  },
}
