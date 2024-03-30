# Introduction

_This is a fork of [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that moves from a single file to a multi file configuration._

A starting point for Neovim that is:

- Small
- Documented
- Modular

## Installation

> **NOTE** > [Backup](#FAQ) your previous configuration (if any exists)

Requirements:

- Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  - Install ast_grep via Mason for Flutter Tools to work properly
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
  - Install `brew install 1password-cli` to use 1Pass for api credentials
  - Add HackNerdFont to your terminal for icons to properly display. Fonts are available in the `fonts/` directory

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%userprofile%\AppData\Local\nvim\`       |
| Windows (powershell) | `$env:USERPROFILE\AppData\Local\nvim\`    |

Clone this repo to correct directory.

## Flutter Tools

If after installation, code actions and highlight doesn't work, install `ast_grep` via `:Mason`
If still doesn't work, follow instructions to unistall lazy.nvim:

https://github.com/folke/lazy.nvim#-uninstalling

Then reopen nvim and install `ast_grep` again.

## Iterm setup

To configure all required fonts, add fonts from `/fonts` to your Font Book on mac

Then configure iTerm by:

1. Go to Settings > Profiles > Text
2. Set font to Monace
3. Enable `Use a different font for non ASCII text`
4. Select `Heck Nord Font` for your ASCII Characters

Add terminal theme:
https://github.com/catppuccin/iterm

Transparency: 5
Blur: 15
