-- Swift support (LazyVim has no Swift language pack).
--   tree-sitter swift for highlighting; sourcekit-lsp for completion, hover,
--   go-to-definition, and diagnostics. sourcekit-lsp ships with the Swift
--   toolchain from swiftly, so Mason doesn't manage it (mason = false).
--   For iOS projects built with xtool, the project's .bsp/ folder points
--   sourcekit-lsp at the iOS SDK so SwiftUI/UIKit imports resolve.
--
-- Only .swift files: sourcekit-lsp also claims C/C++/Objective-C by default,
-- which would fight clangd (lang.clangd extra) over those buffers.
local swiftly_lsp = vim.fn.expand("~/.local/share/swiftly/bin/sourcekit-lsp")

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "swift" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        sourcekit = {
          mason = false,
          -- Absolute fallback so it works even when nvim isn't started from fish
          cmd = { vim.fn.executable("sourcekit-lsp") == 1 and "sourcekit-lsp" or swiftly_lsp },
          filetypes = { "swift" },
        },
      },
    },
  },
}
