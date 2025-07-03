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
  - [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
  - Install `brew install 1password-cli` to use 1Pass for api credentials
  - Add HackNerdFont to your terminal for icons to properly display. Fonts are available in the `fonts/` directory
  - A few requirements for media plugins: https://github.com/mikavilpas/yazi.nvim

| OS                   | PATH                                      |
| :------------------- | :---------------------------------------- |
| Linux                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS                | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)        | `%userprofile%\AppData\Local\nvim\`       |
| Windows (powershell) | `$env:USERPROFILE\AppData\Local\nvim\`    |

Clone this repo to correct directory.

## Flutter Tools

If still doesn't work, follow instructions to unistall lazy.nvim:

https://github.com/folke/lazy.nvim#-uninstalling

Then reopen nvim and install `ast_grep` again.
