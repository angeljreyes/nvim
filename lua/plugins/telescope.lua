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
  local git_root = vim.fn.systemlist("git -C " .. vim.fn.escape(current_dir, " ") .. " rev-parse --show-toplevel")[1]
  if vim.v.shell_error ~= 0 then
    print "Not a git repository. Searching on current working directory"
    return cwd
  end
  return git_root
end

-- Custom live_grep function to search in git root
local function live_grep_git_root()
  local git_root = find_git_root()
  if git_root then
    require("telescope.builtin").live_grep {
      search_dirs = { git_root },
    }
  end
end

local function telescope_live_grep_open_files()
  require("telescope.builtin").live_grep {
    grep_open_files = true,
    prompt_title = "Live Grep in Open Files",
  }
end

local function current_buffer_fuzzy()
  require("telescope.builtin").current_buffer_fuzzy_find(require("telescope.themes").get_dropdown({
    winblend = 10,
    previewer = false,
  }))
end

local function tlb(subcmd)
  return "<cmd>Telescope " .. subcmd .. "<cr>"
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
        cond = function()
          return vim.fn.executable "make" == 1
        end,
      },
    },
    config = function()
      local project_actions = require("telescope._extensions.project.actions")
      require("telescope").setup {
        defaults = {
          mappings = {
            i = {
              ["<C-u>"] = false,
              ["<C-d>"] = false,
            },
          },
        },
        extensions = {
          project = {
            on_project_selected = function(prompt_bufnr)
              project_actions.change_working_directory(prompt_bufnr, false)
              check_venv()
              vim.api.nvim_command("Neotree current")
              require("telescope.builtin").find_files()
            end
          }
        }
      }
      require("telescope").load_extension("project")
      vim.keymap.set(
        "n",
        "<leader>sp",
        function() require"telescope".extensions.project.project{ display_type = "full" } end,
        { desc = "Search Projects" }
      )
      pcall(require("telescope").load_extension, "fzf")
      vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})
    end,
    keys = {
      { "<leader>?", tlb("oldfiles"), desc = "Find recently opened files" },
      { "<leader><space>", tlb("buffers"), desc = "Find existing buffers" },
      { "<leader>/", current_buffer_fuzzy, desc = "Fuzzily search in current buffer" },
      { "<leader>s/", telescope_live_grep_open_files, desc = "Search in Open Files" },
      { "<leader>ss", tlb("builtin"), desc = "Search Select telescope" },
      { "<leader>sg", tlb("git_files"), desc = "Search Git files" },
      {
        "<leader>sf",
        function()
          require("telescope.builtin").find_files({ no_ignore = true })
        end,
        desc = "Search Files",
      },
      { "<leader>sh", tlb("help_tags"), desc = "Search Help" },
      { "<leader>sw", tlb("grep_string"), desc = "Search current Word" },
      { "<leader>sl", tlb("live_grep"), desc = "Search by Live grep" },
      { "<leader>sL", "<cmd>LiveGrepGitRoot<cr>", desc = "Search by Live grep on git goot" },
      { "<leader>sd", tlb("diagnostics"), desc = "Search Diagnostics" },
      { "<leader>sr", tlb("resume"), desc = "Search Resume" },
      { "<leader>sk", tlb("keymaps"), desc = "Search Keymaps" },
    },
  },
  {
    "linux-cultist/venv-selector.nvim",
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
        name = { "venv", ".venv" },
        parents = 0,
        -- auto_refresh = false
      })
    end,
  },
}
