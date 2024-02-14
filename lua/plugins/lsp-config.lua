return {
  "neovim/nvim-lspconfig",
  dependencies = {
    { "williamboman/mason.nvim", config = true },
    "williamboman/mason-lspconfig.nvim",
    { "j-hui/fidget.nvim", opts = {} },
    "folke/neodev.nvim",
  },
  config = function()
    local on_attach = function(_, bufnr)
      local nmap = function(keys, func, desc)
        if desc then
          desc = "LSP: " .. desc
        end

        vim.keymap.set("n", keys, func, { buffer = bufnr, desc = desc })
      end

      nmap("<leader>cr", vim.lsp.buf.rename, "Code Rename")
      nmap("<leader>ca", vim.lsp.buf.code_action, "Code Action")

      nmap("gd", require("telescope.builtin").lsp_definitions, "Go to Definition")
      nmap("gr", require("telescope.builtin").lsp_references, "Go to References")
      nmap("gI", require("telescope.builtin").lsp_implementations, "Go to Implementation")
      nmap("<leader>D", require("telescope.builtin").lsp_type_definitions, "type Definition")
      nmap("<leader>cs", require("telescope.builtin").lsp_document_symbols, "Document Symbols")
      nmap(
        "<leader>ws",
        require("telescope.builtin").lsp_dynamic_workspace_symbols,
        "Workspace Symbols"
      )

      -- See `:help K` for why this keymap
      nmap("K", vim.lsp.buf.hover, "Hover Documentation")
      nmap("<C-k>", vim.lsp.buf.signature_help, "Signature Documentation")

      -- Lesser used LSP functionality
      nmap("gD", vim.lsp.buf.declaration, "Go to Declaration")
      nmap("<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
      nmap("<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
      nmap(
        "<leader>wl",
        function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
        "Workspace List Folders"
      )

      -- Create a command `:Format` local to the LSP buffer
      vim.api.nvim_buf_create_user_command(
        bufnr,
        "Format",
        function(_) vim.lsp.buf.format() end,
        { desc = "Format current buffer with LSP" }
      )
    end

    require("mason").setup({
      ui = {
        icons = {
          package_pending = " ",
          package_installed = "󰄳 ",
          package_uninstalled = " 󰚌",
        },
      },
    })
    require("mason-lspconfig").setup()

    local servers = {
      -- gopls = {},
      -- rust_analyzer = {},
      -- html = { filetypes = { "html", "twig", "hbs"} },

      omnisharp = {
        filetypes = { "csx", "cs" },
      },
      tsserver = {},
      angularls = {},
      tailwindcss = {},
      clangd = {},
      pyright = {},
      lua_ls = {
        Lua = {
          workspace = { checkThirdParty = false },
          telemetry = { enable = false },
          -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
          -- diagnostics = { disable = { "missing-fields" } },
        },
      },
    }

    -- Setup neovim lua configuration
    require("neodev").setup()

    -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
    local capabilities = vim.lsp.protocol.make_client_capabilities()
    capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

    -- Ensure the servers above are installed
    local mason_lspconfig = require("mason-lspconfig")

    mason_lspconfig.setup({
      ensure_installed = vim.tbl_keys(servers),
    })

    mason_lspconfig.setup_handlers({
      function(server_name)
        require("lspconfig")[server_name].setup({
          capabilities = capabilities,
          on_attach = on_attach,
          settings = servers[server_name],
          filetypes = (servers[server_name] or {}).filetypes,
        })
      end,
    })

    vim.lsp.handlers["textDocument/publishDiagnostics"] =
      vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = true,
        signs = false,
        update_in_insert = true,
        underline = true,
      })
  end,
}
