-- presence.nvim crashes on Windows when Neovim is opened more than once
-- coc-discord-rpc is an alternative that works but requires coc which
-- requires npm and some extra configuring

return {
  {
    "neoclide/coc.nvim",
    enabled = Utils.is_profile("home") and Utils.on_windows,
    branch = "release",
    build = ":CocInstall coc-discord-rpc",
  },

  {
    "andweeb/presence.nvim",
    enabled = Utils.is_profile("home") and not Utils.on_windows,
  },
}
