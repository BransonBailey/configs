-- Verilog / SystemVerilog / Vivado support. Colours come from colors/gotham.lua.
--   .v .vh .sv .svh  -> tree-sitter systemverilog + Verible language server
--                       (diagnostics with Verible's full default lint rules,
--                        formatting, go-to-definition, symbols)
--   .tcl .xdc .sdc    -> tree-sitter tcl + tclint's language server (tclsp)
-- Format on save stays on (LazyVim default); toggle per session with <leader>uf.

-- Neovim guesses .v as the V language and doesn't know .vh / .xdc at all
vim.filetype.add({
  extension = {
    v = "verilog",
    vh = "verilog",
    xdc = "xdc",
  },
})
-- XDC and SDC constraint files are Tcl
vim.treesitter.language.register("tcl", { "xdc", "sdc" })

return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "systemverilog", "tcl" })
    end,
  },
  {
    "mason-org/mason.nvim",
    opts = function(_, opts)
      opts.ensure_installed = opts.ensure_installed or {}
      vim.list_extend(opts.ensure_installed, { "verible", "tclint" })
    end,
  },
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        verible = {
          -- Verible both pushes diagnostics and offers them on request;
          -- Neovim would show every warning twice, so keep only the pushed ones
          on_init = function(client)
            client.server_capabilities.diagnosticProvider = nil
          end,
        },
        tclsp = {},
      },
    },
  },
}
