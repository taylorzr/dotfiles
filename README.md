![life](life.png)
# general setup

These dotfiles are setup as a bare repository. The git stuff it stored in ~/dotfiles, but the actual
content stays in ~/. This avoids having any subdir of home be within the dotfiles repo. It also
avoids problems with other dotfile strategies like the need to symlink all the things, which can be
tedious.

```
# auth
# download your ssh key from whereever it's stored
chmod 400 ~/.ssh/id_rsa
# TODO: Document setting up signing for git

# dotfiles
git clone --bare git@github.com:taylorzr/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start tmux and run Prefix + I to install plugins

# neovim
pip3 install pynvim
brew install lua-language-server

# ruby
ruby-install ruby
brew install solargraph

# go
brew install golang

# ruby
ruby-install ruby
brew install solargraph
brew install gopls

# postgres
initdb
brew services start postgresql
createdb $USER

# other languages servers
# TODO: maybe json and/or python?
brew install hashicorp/tap/terraform-ls
yarn global add yaml-language-server
npm i -g bash-language-server
npm i -g sql-language-server
```

# osx

### Key repeat speed
```
# After setting anything run:
#   killall SystemUIServer
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.screencapture location $HOME/Downloads
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
