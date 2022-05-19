![life](life.png)
# general setup

These dotfiles are setup as a bare repository. The git stuff it stored in ~/dotfiles, but the actual
content stays in ~/. This avoids having an subdir of home be within the dotfiles repo. It also
avoids problems with other dotfile stategies like the need to symlink all the things, which can be
tedious.

These dotfiles aren't intended to be re-used by anyone else, but may be a good reference. After
initial setup changes to the dotfiles repo can be made using the `home` alias instead of git
directly.

```
# auth
# download your ssh key from whereever it's stored
chmod 400 ~/.ssh/id_rsa

# dotfiles
git clone --bare git@github.com:taylorzr/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start tmux and run Prefix + I to install plugins

# neovim
pip3 install pynvim

# postgres
initdb
brew services start postgresql
createdb $USER

# ruby
ruby-install ruby

# go
brew install golang
# in vim -> :GoInstallBinaries
```

### iterm2 config?
- Import color scheme ~/Dracula.itermcolors
- alt keys? dont recall exactly
  https://stackoverflow.com/questions/18923765/bash-keyboard-shortcuts-in-iterm-like-altd-and-altf

# osx

### Map CapsLock to Control
http://teohm.com/blog/mac-tips-use-caps-lock-as-control-key/

### Key repeat speed
```
# After setting anything run:
#   killall SystemUIServer
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.screencapture location $HOME/Downloads
```

# Legacy
### keys
```
gpg --import zach.asc
gpg --edit-key zach
gpg> trust
Your decision? 5 # Trust ultimately
Do you really want to set this key to ultimate trust? (y/N) y
```

# WSL

## Copy/paste in WSL
- right click on wsl menubar
- properties
- check "Use ctrl-shift-c/v for copy/paste"

## Turn on annoying bell noise in console
sudo echo 'set bell-style none' > /etc/inputrc

## Mac "Turn off" dock
https://apple.stackexchange.com/questions/59556/is-there-a-way-to-completely-disable-dock
```
defaults write com.apple.dock autohide-delay -float 1000; killall Dock
```
