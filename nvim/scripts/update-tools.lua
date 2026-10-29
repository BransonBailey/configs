-- Run headless by fish's `update` (step "Neovim plugins"):
--   nvim --headless -c "luafile ~/.config/nvim/scripts/update-tools.lua"
-- Updates LazyVim plugins, treesitter parsers and Mason tools, then quits.
-- Lines starting with "@@ " are the summary the fish function prints.
local function say(s) io.write("@@ " .. s .. "\n") end

-- 1. plugins (waits until done)
vim.cmd("Lazy! sync")
say("plugins synced")

-- 2. treesitter parsers
require("lazy").load({ plugins = { "nvim-treesitter" } })
local ok_ts, ts = pcall(require, "nvim-treesitter")
if ok_ts and ts.update then
  local ok = ts.update():wait(600000)
  say(ok and "parsers updated" or "parsers: update did not finish")
end

-- 3. Mason tools (formatters, language servers)
require("lazy").load({ plugins = { "mason.nvim" } })
local r = require("mason-registry")
local refreshed = false
r.refresh(function() refreshed = true end)
vim.wait(60000, function() return refreshed end, 200)
vim.wait(3000) -- let LazyVim start any installs of its own first

-- kept at a fixed version on purpose (see lua/plugins/bash.lua)
local pinned = { ["bash-language-server"] = true }
local updated = {}
for _, pkg in ipairs(r.get_installed_packages()) do
  local okc, cur = pcall(pkg.get_installed_version, pkg)
  local okl, latest = pcall(pkg.get_latest_version, pkg)
  if not pinned[pkg.name] and okc and okl and cur and latest and cur ~= latest and not pkg:is_installing() then
    pkg:install({ version = latest })
    updated[#updated + 1] = pkg.name .. " " .. cur .. " -> " .. latest
  end
end
vim.wait(600000, function()
  for _, pkg in ipairs(r.get_all_packages()) do
    if pkg:is_installing() then return false end
  end
  return true
end, 500)
say(#updated == 0 and "Mason tools up to date" or ("Mason updated: " .. table.concat(updated, ", ")))

vim.cmd("qa!")
