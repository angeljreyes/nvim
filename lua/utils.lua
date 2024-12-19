---Utilities for my Neovim config
Utils = {}

---Checks if profile is equal to the value of an environment
---variable named "NVIM_PROFILE"
---@param profile "home" | "work" | string
---@return boolean
function Utils.is_profile(profile) return vim.env.NVIM_PROFILE == profile end

local sysname = vim.uv.os_uname().sysname
Utils.on_windows = sysname == "Windows_NT"
Utils.on_linux = sysname == "Linux"
