-- LazyVim spec for the Gotham colorscheme (colors/gotham.lua), adapted from
-- cosmic-noir-theme's nvim/lua/plugins/noir.lua: colorscheme plus the
-- treesitter parsers for the config files this setup touches.
return {
  { "LazyVim/LazyVim", opts = { colorscheme = "gotham" } },
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "ron", "bash", "fish", "lua", "markdown", "markdown_inline", "toml", "yaml", "css", "json" })
    end,
  },
}
