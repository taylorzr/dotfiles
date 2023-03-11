![life](life.png)
# general setup

These dotfiles are setup as a bare repository. The git stuff it stored in ~/dotfiles, but the actual
content stays in ~/. This avoids having any subdir of home be within the dotfiles repo. It also
avoids problems with other dotfile strategies like the need to symlink all the things, which can be
tedious.

```

# dotfiles
git clone --bare https://github.com/taylorzr/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
touch ~/.config/shell/local.sh
# after getting ssh setup
git remote set-url origin git@github.com:taylorzr/dotfiles.git


# brew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# install
zsh kitty vim fzf tldr jq yq gomplate ripgrep golang
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# generate ssh and gpg keys
$ ssh-keygen -t ed25519 -C "<email>"

$ gpg --full-generate-key
# choose: rsa & 4096

$ gpg --list-secret-keys --keyid-format=short
# copy sec id

# then export public key, copy and save in github
gpg --armor --export <key-id>

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# neovim master
tp git@github.com:neovim/neovim.git
make CMAKE_BUILD_TYPE=Release
use nv alias to run

# postgres
initdb
brew services start postgresql
createdb $USER

use vim :Mason to install language servers
TODO: get mason-lspconfig working 

# other software
rectangle, pastebot, pinentry-mac
rancher (includes kubectl, helm, nerdctl, “docker“, etc), kubectx, k9s
tfenv, then tfenv install
```

# fedora

### signal
```sh
sudo dnf copr enable luminoso/Signal-Desktop
sudo dnf install signal-desktop
```

# osx

### Key repeat speed
```
# After setting anything run:
#   killall SystemUIServer
# normal initial minimum is 25 (225 ms)
# normal repeat minimum is 6 (30 ms)
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
defaults write com.apple.finder AppleShowAllFiles YES
defaults write com.apple.screencapture location $HOME/Downloads
```

### Manual stuff, maybe figure out how to do this in terminal someday
* unset mission control re-arrange desktops
* unset key shortcuts ctrl-up and ctrl-down


```
sudo dnf install zsh kitty gh ripgrep jq yq gomplate 
include kitty-meow in the default setup
```
