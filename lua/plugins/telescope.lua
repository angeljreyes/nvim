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
      local actions = require("telescope.actions")
      require("telescope").setup({
        defaults = {
          scroll_strategy = "limit",
          mappings = {
            i = {
              ["<pageup>"] = false,
              ["<pagedown>"] = false,
              ["<c-x>"] = false,
              ["<c-s>"] = actions.select_horizontal,
              ["<c-u>"] = actions.results_scrolling_up,
              ["<c-d>"] = actions.results_scrolling_down,
              ["<c-k>"] = actions.preview_scrolling_up,
              ["<c-j>"] = actions.preview_scrolling_down,
              ["<m-p>"] = actions.move_to_top,
              ["<m-n>"] = actions.move_to_bottom,
              ["<c-y>"] = actions.select_default,
              ["<c-q>"] = actions.smart_send_to_qflist,
              ["<m-q>"] = actions.smart_add_to_qflist,
              ["<c-o>"] = actions.smart_send_to_loclist,
              ["<m-o>"] = actions.smart_add_to_loclist,
            },
          },
        },
        pickers = {
          help_tags = {
            mappings = {
              i = {
                ["<cr>"] = actions.select_vertical,
                ["<c-y>"] = actions.select_vertical,
              },
            },
          },
        },
        extensions = {
          fzf = {},
        },
      })
      pcall(require("telescope").load_extension, "fzf")
      vim.api.nvim_create_user_command("LiveGrepGitRoot", live_grep_git_root, {})

      local tcbi = require("telescope.builtin")
      vim.keymap.set(
        "n",
        "<leader>/",
        current_buffer_fuzzy,
        { desc = "Fuzzily search in current buffer" }
      )
      vim.keymap.set("n", "<leader>si", search_ignored, { desc = "Search Ignored files" })
      vim.keymap.set(
        "n",
        "<leader>sQ",
        tcbi.quickfixhistory,
        { desc = "Search the quickfix history" }
      )
      vim.keymap.set(
        "n",
        "<leader>sG",
        "<cmd>LiveGrepGitRoot<cr>",
        { desc = "Search by Live grep on git goot" }
      )
    end,
  },
}
