# ~/.config

My personal dot files.

## What's in here

| Path | Purpose |
|------|---------|
| `zshrc` | zsh config (symlinked to `~/.zshrc`) |
| `zsh-abbr/user-abbreviations` | fish-style abbreviations, auto-loaded by zsh-abbr |
| `cmux/` | [cmux](https://www.cmux.dev/) settings (terminal/workspace manager) |
| `ghostty/` | terminal config for cmux's bundled Ghostty engine |
| `nvim/` | Neovim config (see `nvim/README.md`) |
| `hammerspoon/` | Hammerspoon hotkeys (app launcher, window management) |

## Install

Steps are in the order to run them on a fresh machine.

### 1. Homebrew

Everything below installs through [Homebrew](https://brew.sh/) (this also
installs the Xcode Command Line Tools, which provide `git` for the next step).

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. Clone

Requires a GitHub [SSH key](https://docs.github.com/en/authentication/connecting-to-github-with-ssh).

```sh
git clone git@github.com:lucasprag/.config.git ~/.config
```

### 3. zsh + oh-my-zsh

The shell setup uses [oh-my-zsh](https://ohmyz.sh/) with
[zsh-abbr](https://github.com/olets/zsh-abbr) (fish-style abbreviations),
[zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions), and
[zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting).

```sh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install zsh-autosuggestions zsh-syntax-highlighting
# zsh-abbr as an oh-my-zsh custom plugin (zshrc sources it from this path)
git clone --recurse-submodules https://github.com/olets/zsh-abbr ~/.oh-my-zsh/custom/plugins/zsh-abbr
ln -sf ~/.config/zshrc ~/.zshrc
chsh -s /bin/zsh
```

Notes:
- abbreviations are auto-loaded from `~/.config/zsh-abbr/user-abbreviations`
- secrets (DD/Metabase/Slack tokens etc.) live in `~/.secret.zsh` -- NOT committed

### 4. Terminal: cmux

[cmux](https://www.cmux.dev/) bundles the [Ghostty](https://ghostty.org/)
terminal engine, so there is no separate Ghostty install. Both configs are
read directly from `~/.config/cmux` and `~/.config/ghostty` (the ghostty
config drives cmux's embedded terminal) -- no symlinks needed.

```sh
brew install --cask cmux
```

### 5. Languages: asdf

[asdf](https://github.com/asdf-vm/asdf) manages the language runtimes I code
in: [Ruby](https://github.com/asdf-vm/asdf-ruby),
[Node.js](https://github.com/asdf-vm/asdf-nodejs), and
[Python](https://github.com/asdf-community/asdf-python). `zshrc` already puts
the asdf shims on the PATH.

```sh
brew install asdf
```

Then install only the languages the machine needs.

#### Ruby

```sh
asdf plugin add ruby
asdf install ruby latest
asdf global ruby latest
```

#### Node.js

```sh
asdf plugin add nodejs
asdf install nodejs latest
asdf global nodejs latest

# pnpm
npm install -g pnpm
asdf reshim nodejs
```

#### Python

Latest 3 and latest 2, both available globally (`python` is 3, `python2`
resolves via the fallback version).

```sh
asdf plugin add python

# latest regular 3.x (skips the free-threaded `t` builds, which `latest` resolves to)
PY3="$(asdf list all python | grep -E '^3(\.[0-9]+)+$' | tail -1)"
asdf install python "$PY3"
asdf install python latest:2
asdf global python "$PY3" latest:2
```

### 6. Neovim

```sh
brew install neovim
```

Install [Plug](https://github.com/junegunn/vim-plug?tab=readme-ov-file#neovim),
then follow the instructions in `nvim/README.md`.

### 7. Hammerspoon

[Hammerspoon](https://www.hammerspoon.org/) provides the app-launcher and
window-management hotkeys.

```sh
ln -s ~/.config/hammerspoon/init.lua ~/.hammerspoon/init.lua
```

### 8. macOS tweaks

```sh
# make typing great again -- re-pairing the bluetooth keyboard is required to make it work
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

# after installing vscode. Restart vscode.
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```

## Other dependencies

- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#using-homebrew) (Ctrl-R history, Ctrl-T files, the `kp` process killer)
- [Powerline fonts](https://github.com/powerline/fonts)

## MacOS apps

- [KeepingYouAwake](https://keepingyouawake.app/)
- [Clipy](https://github.com/Clipy/Clipy)
- [Postico](https://eggerapps.at/postico/v1.php)

## Day-to-day

Once everything is set up, `start smile` (defined in `zshrc`) opens all the
smile workspaces via the cmux CLI.
