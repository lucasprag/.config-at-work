# ~/.config

My personal dot files.

## Dependencies

- [zsh](https://www.zsh.org/) with [oh-my-zsh](https://ohmyz.sh/)
- [zsh-abbr](https://github.com/olets/zsh-abbr) (fish-style abbreviations)
- [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions)
- [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- [Powerline fonts](https://github.com/powerline/fonts)
- [asdf](https://github.com/asdf-vm/asdf), [asdf-ruby](https://github.com/asdf-vm/asdf-ruby), [asdf-elixir](https://github.com/asdf-vm/asdf-elixir), [asdf-nodejs](https://github.com/asdf-vm/asdf-nodejs), [asdf-erlang](https://github.com/asdf-vm/asdf-erlang), [asdf-python](https://github.com/asdf-community/asdf-python).
- [tmux](https://github.com/tmux/tmux/wiki)
- [tmuxinator](https://github.com/tmuxinator/tmuxinator)
- [neovim](https://neovim.io)
- [fzf](https://github.com/junegunn/fzf?tab=readme-ov-file#using-homebrew)

## MacOS apps
- [Alacritty](https://github.com/jwilm/alacritty)
- [Hammerspoon](https://www.hammerspoon.org/)
- [KeepingYouAwake](https://keepingyouawake.app/)
- [Clipy](https://github.com/Clipy/Clipy)
- [Postico](https://eggerapps.at/postico/v1.php)


## Install

```
git clone git@github.com:lucasprag/.config.git ~/.config

# zsh + oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
brew install zsh-autosuggestions zsh-syntax-highlighting
brew install olets/tap/zsh-abbr   # or: git clone https://github.com/olets/zsh-abbr ~/.oh-my-zsh/custom/plugins/zsh-abbr (--recurse-submodules)
ln -sf ~/.config/zshrc ~/.zshrc
# abbreviations are auto-loaded from ~/.config/zsh-abbr/user-abbreviations
# secrets (DD/Metabase/Slack tokens etc.) live in ~/.secret.zsh -- NOT committed
chsh -s /bin/zsh

# tmux
brew install tmux
ln -sf ~/.config/tmux.conf ~/.tmux.conf

# install tmux plugins
mkdir -p ~/.tmux/plugins/tpm
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# ctrl+b + I to install plugins

# tmuxinator
ln -sf ~/.config/tmuxinator ~/.tmuxinator

# neovim
brew install neovim
# install Plug https://github.com/junegunn/vim-plug?tab=readme-ov-file#neovim
# Follow instructions from nvim/README.md

# hammerspoon
ln -s ~/.config/hammerspoon/init.lua ~/.hammerspoon/init.lua

# make typing great again -- re-pair bluetooth keyboard required to make it work
defaults write -g InitialKeyRepeat -int 13
defaults write -g KeyRepeat -int 1

# after installing vscode. Restart vscode.
defaults write com.microsoft.VSCode ApplePressAndHoldEnabled -bool false
```
