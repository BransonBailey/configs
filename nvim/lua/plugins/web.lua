-- HTML / CSS support (LazyVim has no pack for these; JavaScript comes from
-- the lang.typescript pack). Colours come from colors/gotham.lua.
--   html   VS Code's HTML language server: completion, errors, formatting
--   cssls  VS Code's CSS language server (css, scss, less): completion,
--          colour previews, errors, formatting
--   emmet  abbreviation expansion, e.g. div.card>h2+p*3, from the completion menu
-- Format on save stays on (LazyVim default).
return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "html", "css", "scss" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        html = {},
        cssls = {},
        emmet_language_server = {},
      },
    },
  },
}
