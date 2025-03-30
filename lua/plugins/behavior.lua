return {
  "tpope/vim-sleuth",

  {
    "kevinhwang91/nvim-fundo",
    dependencies = "kevinhwang91/promise-async",
    opts = {},
  },

  {
    "IogaMaster/neocord",
    enabled = Utils.is_profile("home"),
    opts = {},
  },
}
