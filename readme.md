

# Introduction

*This is a fork of [nvim-lua/kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) that moves from a single file to a multi file configuration.*

A starting point for Neovim that is:

* Small
* Documented
* Modular

## Installation

> **NOTE** 
> [Backup](#FAQ) your previous configuration (if any exists)

Requirements:
* Make sure to review the readmes of the plugins if you are experiencing errors. In particular:
  * Insatl ast-grep via Mason for Flutter Tools to work properly
  * [ripgrep](https://github.com/BurntSushi/ripgrep#installation) is required for multiple [telescope](https://github.com/nvim-telescope/telescope.nvim#suggested-dependencies) pickers.
  * Install `brew install 1password-cli` to use 1Pass for api credentials
  * Add HackNerdFont to your terminal for icons to properly display. Fonts are available in the `fonts/` directory

| OS | PATH |
| :- | :--- |
| Linux | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| MacOS | `$XDG_CONFIG_HOME/nvim`, `~/.config/nvim` |
| Windows (cmd)| `%userprofile%\AppData\Local\nvim\` |
| Windows (powershell)| `$env:USERPROFILE\AppData\Local\nvim\` |


Clone this repo to correct directory.

## Flutter Tools
If after installation, code actions and highlight doesn't work, install `ast_grep` via `:Mason`
If still doesn't work, follow instructions to unistall lazy.nvim:

https://github.com/folke/lazy.nvim#-uninstalling

Then reopen nvim and install `ast_grep` again.


## Tmux & Iterm setup

install tmux and tmux plugins

```
brew install tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
```

To start iterm with tmux ad this sript to `Send text at start`:

```
tmux ls && read tmux_session && tmux attach -t ${tmux_session:-default} || tmux attach || tmux 
```

Paste this in `~/.tmux.conf`

```
unbind r
bind r source-file ~/.tmux.conf

set -g prefix C-b

setw -g mode-keys vi
bind-key h select-pane -L
bind-key j select-pane -D
bind-key k select-pane -U
bind-key l select-pane -R
bind  c  new-window      -c "#{pane_current_path}"
bind  %  split-window -h -c "#{pane_current_path}"
bind '"' split-window -v -c "#{pane_current_path}"

set -g @plugin 'tmux-plugins/tpm'
set -g @plugin 'christoomey/vim-tmux-navigator'

bind C-o display-popup -E "tms"

run '~/.tmux/plugins/tpm/tpm'
```

Run source config: 

```
tmux source ~/.tmux.conf
```

Run Ctrl + b + I to install packages

To configure all required fonts, add fonts from `/fonts` to your Font Book on mac

Then configure iTerm by:
1. Go to Settings > Profiles > Text
2. Set font to Monace
3. Enable `Use a different font for non ASCII text`
4. Select `Heck Nord Font` for your ASCII Characters

## Tmux sessionizer

https://github.com/ThePrimeagen/.dotfiles/blob/master/bin/.local/scripts/tmux-sessionizer
https://github.com/jrmoulton/tmux-sessionizer

First install rust following instauctions: https://doc.rust-lang.org/cargo/getting-started/installation.html
Then run `cargo install tmux-sessionizer` to install CLI tool

then you can use tms command, but firest setup default path to search for repositories f.e.:

```
tms -p ~/Files
```

