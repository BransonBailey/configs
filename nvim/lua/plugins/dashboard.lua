-- Dashboard banner: "VIM" in the same ANSI Shadow letters as LazyVim's own
-- header. Its colour is SnacksDashboardHeader in colors/gotham.lua (gold).
return {
  "folke/snacks.nvim",
  opts = {
    dashboard = {
      preset = {
        header = [[
██╗   ██╗██╗███╗   ███╗
██║   ██║██║████╗ ████║
██║   ██║██║██╔████╔██║
╚██╗ ██╔╝██║██║╚██╔╝██║
 ╚████╔╝ ██║██║ ╚═╝ ██║
  ╚═══╝  ╚═╝╚═╝     ╚═╝]],
      },
    },
  },
}
