local function find_git_root()
  -- Use the current buffer's path as the starting point for the git search
  local current_file = vim.api.nvim_buf_get_name(0)
  local current_dir
  local cwd = vim.fn.getcwd()
  -- If the buffer is not associated with a file, return nil
  if current_file == "" then
    current_dir = cwd
  else
    -- Extract the directory from the current file"s path
    current_dir = vim.fn.fnamemodify(current_file, ":h")
  end

  -- Find the Git root directory from the current file's path
  local git_root = vim.fn.systemlist(
    "git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel"
  )[1]
  if vim.v.shell_error ~= 0 then
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep({
      search_dirs = { git_root },
    })
  end
end

local function live_grep_open_files()
  require("telescope.builtin").live_grep({
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  })
end

local function current_buffer_fuzzy()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end

local function search_files()
  find_git_root()
  if vim.v.shell_error ~= 0 then
    require("telescope.builtin").find_files()
  else
    require("telescope.builtin").git_files({ show_untracked = true })
  end
end

local function search_ignored()
  local git_root = find_git_root()
  require("telescope.builtin").find_files({
    cwd = git_root,
    hidden = true,
    no_ignore = true,
  })
end

local function check_venv()
  local venv = vim.fn.finddir("venv", vim.fn.getcwd())
  local dotvenv = vim.fn.finddir(".venv", vim.fn.getcwd())
  if venv ~= "" or dotvenv ~= "" then
    require("venv-selector").retrieve_from_cache()
  end
end

return {
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      -- Fuzzy Finder Algorithm which requires local dependencies to be built.
      -- Only load if `make` is available. Make sure you have the system
      -- requirements installed.
      {
        "nvim-telescope/telescope-fzf-native.nvim",
        -- NOTE: If you are having trouble with this installation,
        --       refer to the README for telescope-fzf-native for more instructions.
        build = "make",
        cond = function() return vim.fn.executable("make") == 1 end,
      },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
              ["<C-y>"] = require("telescope.actions").select_default,
              ["<C-q>"] = require("telescope.actions").smart_send_to_qflist,
              ["<M-q>"] = require("telescope.actions").smart_add_to_qflist,
              ["<C-l>"] = require("telescope.actions").smart_send_to_loclist,
              ["<M-l>"] = require("telescope.actions").smart_add_to_loclist,
            },
          },
        },
        extensions = {
          ["ui-select"] = {
            require("telescope.themes").get_dropdown(),
          },
        },
      })
      require("telescope").load_extension("ui-select")
      pcall(require("telescope").load_extension, "fzf")
      vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

      local tcbi = require("telescope.builtin")
      vim.keymap.set("n", "<leader>?", tcbi.oldfiles, { desc = "Find recently opened files" })
      vim.keymap.set("n", "<leader><space>", tcbi.buffers, { desc = "Find existing buffers" })
      vim.keymap.set(
        "n",
        "<leader>/",
        current_buffer_fuzzy,
        { desc = "Fuzzily search in current buffer" }
      )
      vim.keymap.set("n", "<leader>s/", live_grep_open_files, { desc = "Search in Open Files" })
      vim.keymap.set("n", "<leader>ss", tcbi.builtin, { desc = "Search Select telescope" })
      vim.keymap.set("n", "<leader>sf", search_files, { desc = "Search Files" })
      vim.keymap.set("n", "<leader>si", search_ignored, { desc = "Search Ignored files" })
      vim.keymap.set("n", "<leader>sh", tcbi.help_tags, { desc = "Search Help" })
      vim.keymap.set("n", "<leader>sw", tcbi.grep_string, { desc = "Search current Word" })
      vim.keymap.set("n", "<leader>sg", tcbi.live_grep, { desc = "Search by Grep" })
      vim.keymap.set("n", "<leader>sq", tcbi.quickfix, { desc = "Search the quickfix list" })
      vim.keymap.set(
        "n",
        "<leader>sQ",
        tcbi.quickfixhistory,
        { desc = "Search the quickfix history" }
      )
      vim.keymap.set("n", "<leader>sl", tcbi.loclist, { desc = "Search the location list history" })
      vim.keymap.set(
        "n",
        "<leader>sG",
        "<cmd>LiveGrepGitRoot<cr>",
        { desc = "Search by Live grep on git goot" }
      )
      vim.keymap.set("n", "<leader>sd", tcbi.diagnostics, { desc = "Search Diagnostics" })
      vim.keymap.set("n", "<leader>sr", tcbi.resume, { desc = "Search Resume" })
      vim.keymap.set("n", "<leader>sk", tcbi.keymaps, { desc = "Search Keymaps" })
      vim.keymap.set("n", "<leader>gc", tcbi.git_bcommits, { desc = "Git Commits on current buffer" })
      vim.keymap.set("n", "<leader>gC", tcbi.git_commits, { desc = "Git Commits" })
    end,
  },

  {
    "nvim-telescope/telescope-ui-select.nvim",
  },

  {
    "linux-cultist/venv-selector.nvim",
    enabled = vim.env.NVIM_PROFILE == "home",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-telescope/telescope.nvim",
      "mfussenegger/nvim-dap-python",
    },
    event = "VeryLazy",
    config = function()
      vim.api.nvim_create_autocmd("VimEnter", {
        desc = "Auto select venv Nvim open",
        callback = check_venv,
        once = true,
      })

      require("venv-selector").setup({
        stay_on_this_version = true,
        name = { "venv", ".venv" },
        parents = 0,
        -- auto_refresh = false
      })
    end,
  },
}
