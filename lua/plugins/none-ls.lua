return {
  "nvimtools/none-ls.nvim",
  config = function()
    local null_ls = require("null-ls")
    local btins = null_ls.builtins
    null_ls.setup({
      sources = {
        btins.formatting.stylua,

        btins.formatting.isort,

        btins.formatting.prettier,
      },
    })

    vim.keymap.set("n", "<leader>cf", vim.lsp.buf.format, { desc = "Format current buffer" })

    vim.diagnostic.config({ signs = false })
  end,
}
