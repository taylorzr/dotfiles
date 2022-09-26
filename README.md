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

$ gpg --full-generate-key
# choose: rsa & 4096

$ gpg --list-secret-keys --keyid-format=long
# copy sec id

# then export public key, copy and save in github
gpg --armor --export <key-id>


# dotfiles
git clone --bare git@github.com:taylorzr/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start tmux and run Prefix + I to install plugins

# neovim
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
:PackerCompile
pip3 install pynvim
brew install lua-language-server

# fzf
brew install fzf
$(brew --prefix)/opt/fzf/install

# neovim master
tp git@github.com:neovim/neovim.git
make CMAKE_BUILD_TYPE=Release
use nv alias to run

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

### Manual stuff, maybe figure out how to do this in terminal someday
* unset mission control re-arrange desktops
* unset key shortcuts ctrl-up and ctrl-down
