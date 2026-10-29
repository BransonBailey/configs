-- Bash / sh support (LazyVim has no Bash language pack).
--   bash-language-server: completion, hover, go-to-definition, and ShellCheck
--   warnings when shellcheck is installed (apt). Formatting stays LazyVim's
--   default for sh (shfmt). Colours come from colors/gotham.lua.
--
-- Pinned to bash-language-server 5.6.0: newer versions need Node 20 and this
-- system has Node 18. mason = false stops LazyVim installing the latest one;
-- the pinned version is installed once by hand and skipped by
-- scripts/update-tools.lua (see `pinned` there).
return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        bashls = { mason = false },
      },
    },
  },
}
