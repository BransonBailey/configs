# configs

Personal dotfiles.

| Dir | Contents |
| --- | --- |
| `nvim/` | Neovim 0.12 + [LazyVim](https://lazyvim.org) config, with the Gotham colourscheme |

## nvim

```sh
git clone https://github.com/BransonBailey/configs.git ~/configs
ln -s ~/configs/nvim ~/.config/nvim   # back up any existing ~/.config/nvim first
nvim                                  # lazy.nvim bootstraps and installs plugins
```
