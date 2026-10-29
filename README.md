# configs

Personal dotfiles.

| Dir | Contents |
| --- | --- |
| `nvim/` | Neovim 0.12 + [LazyVim](https://lazyvim.org) config, with the Gotham colourscheme |
| `starship/` | [Starship](https://starship.rs) prompt config (Gotham palette) |

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

## starship

`starship/starship.toml` is a two-line prompt: directory, git branch and status on the left, language versions (Python, Node, Go, Rust, ...) and command duration on the right, then the prompt character. The colours come from the `gotham` palette at the bottom of the file; change `palette = 'gotham'` to `'nord'` or `'onedark'` to switch.

Starship only reads `~/.config/starship.toml` by default, so point it at the file instead of copying:

```sh
# fish
set -Ux STARSHIP_CONFIG ~/configs/starship/starship.toml
# bash/zsh
export STARSHIP_CONFIG=~/configs/starship/starship.toml
```

```powershell
# PowerShell: put in $PROFILE
$ENV:STARSHIP_CONFIG = "$HOME\configs\starship\starship.toml"
Invoke-Expression (&starship init powershell)
```

The icons need a [Nerd Font](https://www.nerdfonts.com) in the terminal (I use FiraCode Nerd Font). On Windows, install Starship itself with `winget install Starship.Starship`.
