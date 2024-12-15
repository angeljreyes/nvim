return {
  { "williamboman/mason.nvim", config = true },

  { "j-hui/fidget.nvim", config = true },

  { "Issafalcon/lsp-overloads.nvim" },

  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = {
      "williamboman/mason.nvim",
      "neovim/nvim-lspconfig",
    },
  },

  {
    "folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "luvit-meta/library", words = { "vim%.uv" } },
      },
    },
  },

  { "Bilal2453/luvit-meta", lazy = true }, -- optional `vim.uv` typings

  {
    "neovim/nvim-lspconfig",
    config = function()
      local on_attach = function(client, bufnr)
        local map = function(mode, keys, func, desc)
          if desc then
            desc = "LSP: " .. desc
          end

          vim.keymap.set(mode, keys, func, { buffer = bufnr, desc = desc })
        end

        local builtin = require("telescope.builtin")

        map("n", "<leader>cr", vim.lsp.buf.rename, "Code Rename")
        map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "Code Action")
        map("i", "<c-.>", vim.lsp.buf.code_action, "Code Action")

        map("n", "gd", builtin.lsp_definitions, "Go to Definition")
        map("n", "gr", builtin.lsp_references, "Go to References")
        map("n", "gI", builtin.lsp_implementations, "Go to Implementation")
        map("n", "<leader>D", builtin.lsp_type_definitions, "type Definition")
        map("n", "<leader>cs", builtin.lsp_document_symbols, "Document Symbols")
        map("n", "<leader>ws", builtin.lsp_dynamic_workspace_symbols, "Workspace Symbols")

        -- See `:help K` for why this keymap
        map("n", "K", vim.lsp.buf.hover, "Hover Documentation")
        map("n", "<c-k>", vim.lsp.buf.signature_help, "Signature Documentation")

        -- Lesser used LSP functionality
        map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
        map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Workspace Add Folder")
        map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Workspace Remove Folder")
        map(
          "n",
          "<leader>wl",
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end,
          "Workspace List Folders"
        )

        if client.server_capabilities.signatureHelpProvider then
          require("lsp-overloads").setup(client, {
            ui = {
              border = "rounded",
            },
          })
          vim.keymap.set(
            "n",
            "<a-s>",
            ":LspOverloadsSignature<cr>",
            { noremap = true, silent = true, buffer = bufnr }
          )
        end

        -- Create a command `:Format` local to the LSP buffer
        vim.api.nvim_buf_create_user_command(
          bufnr,
          "Format",
          function(_) vim.lsp.buf.format() end,
          { desc = "Format current buffer with LSP" }
        )
      end

      vim.keymap.set(
        "n",
        "[d",
        function() vim.diagnostic.goto_prev({ float = { border = "rounded" } }) end,
        { desc = "Go to previous diagnostic message" }
      )
      vim.keymap.set(
        "n",
        "]d",
        function() vim.diagnostic.goto_next({ float = { border = "rounded" } }) end,
        { desc = "Go to next diagnostic message" }
      )
      vim.keymap.set(
        "n",
        "<leader>e",
        function() vim.diagnostic.open_float({ border = "rounded" }) end,
        { desc = "Open floating diagnostic message" }
      )

      require("mason").setup({
        ui = {
          icons = {
            package_pending = " ",
            package_installed = " ",
            package_uninstalled = " ",
          },
        },
      })
      require("mason-lspconfig").setup()

      local servers = {
        -- gopls = {},
        -- html = { filetypes = { "html", "twig", "hbs"} },

        rust_analyzer = vim.env.NVIM_PROFILE == "home" and {} or nil,
        omnisharp = {
          filetypes = { "csx", "cs" },
          RoslynExtensionsOptions = {
            EnableImportCompletion = true,
          },
        },
        ts_ls = vim.env.NVIM_PROFILE == "home" and {} or nil,
        angularls = vim.env.NVIM_PROFILE == "home" and {
          filetypes = { "html", "angular" },
        } or nil,
        tailwindcss = vim.env.NVIM_PROFILE == "home" and {
          filetypes = { "html", "angular" },
          init_options = {
            userLanguages = {
              angular = "html",
            },
          },
        } or nil,
        jsonls = {},
        clangd = vim.env.NVIM_PROFILE == "home" and {} or nil,
        pyright = {},
        ruff = {},
        lua_ls = {
          Lua = {
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
            -- NOTE: toggle below to ignore Lua_LS's noisy `missing-fields` warnings
            -- diagnostics = { disable = { "missing-fields" } },
          },
        },
      }

      -- nvim-cmp supports additional completion capabilities, so broadcast that to servers
      local capabilities = vim.lsp.protocol.make_client_capabilities()
      capabilities = require("cmp_nvim_lsp").default_capabilities(capabilities)

      -- Ensure the servers above are installed
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        ensure_installed = vim.tbl_keys(servers),
        automatic_installation = true,
      })

      mason_lspconfig.setup_handlers({
        function(server_name)
          require("lspconfig")[server_name].setup({
            capabilities = capabilities,
            on_attach = on_attach,
            settings = servers[server_name],
            filetypes = (servers[server_name] or {}).filetypes,
            init_options = (servers[server_name] or {}).init_options,
          })
        end,
      })

      vim.lsp.handlers["textDocument/publishDiagnostics"] =
        vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
          virtual_text = true,
          signs = false,
          update_in_insert = false,
          underline = true,
          severity_sort = true,
        })

      vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
        border = "rounded",
      })
    end,
  },
}
