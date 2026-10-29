# configs

Personal dotfiles.

| Dir | Contents |
| --- | --- |
| `nvim/` | Neovim 0.12 + [LazyVim](https://lazyvim.org) config, with the Gotham colourscheme |
| `fastfetch/` | [fastfetch](https://github.com/fastfetch-cli/fastfetch) system info with a Batman logo |

## nvim

Linux / macOS:

```sh
git clone https://github.com/BransonBailey/configs.git ~/configs
ln -s ~/configs/nvim ~/.config/nvim   # back up any existing ~/.config/nvim first
nvim                                  # lazy.nvim bootstraps and installs plugins
```

Windows (PowerShell): Neovim reads its config from `~\AppData\Local\nvim`.

```powershell
git clone https://github.com/BransonBailey/configs.git $HOME\configs
Copy-Item -Recurse $HOME\configs\nvim $env:LOCALAPPDATA\nvim   # back up any existing one first
nvim
```

LazyVim wants `git`, a C compiler (for treesitter parsers), `ripgrep` and `fd`; some of the language plugins also install tools through Mason.

## fzf in the terminal

[fzf](https://github.com/junegunn/fzf) is a fuzzy finder, the same idea as Neovim's file picker. Type a few letters of a name, in any order, and the list narrows as you type. Enter selects, Esc cancels, Up/Down (or Ctrl-J/Ctrl-K) move through the list.

| Shortcut | What it does |
| --- | --- |
| `Ctrl-T` | Fuzzy-find a file and paste its path onto the command line, with a `bat` preview |
| `Alt-C` | Fuzzy-find a directory and `cd` into it |
| `Ctrl-R` | Fuzzy-search your command history and paste the match |

On my Linux machine these are set up for fish in `~/.config/fish/conf.d/fzf.fish`. It uses `fd` to list files, so `.gitignore` is respected and `.git` is skipped, and sets Gotham colours.

On Windows these keys don't exist out of the box. Install `fzf`, `fd` and `bat` (e.g. `winget install junegunn.fzf sharkdp.fd sharkdp.bat`), then add the [PSFzf](https://github.com/kelleyma49/PSFzf) module for PowerShell:

```powershell
Install-Module PSFzf
# in $PROFILE:
Import-Module PSFzf
Set-PsFzfOption -PSReadlineChordProvider 'Ctrl+t' -PSReadlineChordReverseHistory 'Ctrl+r'
Set-PSReadLineKeyHandler -Key Alt+c -ScriptBlock { Invoke-FzfSetLocation }
```

## fastfetch

`fastfetch/config.jsonc` plus `batman.txt`, the ASCII logo it points to. The config refers to the logo as `~/.config/fastfetch/batman.txt`, so copy both files into that folder (on Windows, `~\.config\fastfetch`):

```sh
mkdir -p ~/.config/fastfetch && cp ~/configs/fastfetch/* ~/.config/fastfetch/
```

Install fastfetch with `winget install Fastfetch-cli.Fastfetch` on Windows. Run `fastfetch` to try it.
