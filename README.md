![life](life.png)
# general setup

These dotfiles are setup as a bare repository. This avoids the need to symlink all the things, which
is tedious. Direnv is used to set GIT_DIR && GIT_WORK_TREE in the home directory so you only need to
use `--git-dir=$HOME/dotfiles/ --work-tree=$HOME` when setting up the first time. All projects are
kept at $HOME/code, where there is an empty .envrc so that any projects without a .envrc don't
inherit the $HOME/.envrc.

```
# auth
# download your ssh key from whereever it's stored
chmod 400 ~/.ssh/id_rsa

# dotfiles
git clone --bare git@github.com:taylorzr/dotfiles.git $HOME/dotfiles
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME checkout
git --git-dir=$HOME/dotfiles/ --work-tree=$HOME config --local status.showUntrackedFiles no

# apps
brew bundle install ~/Brewfile

# zsh
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

# tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start tmux and run Prefix + I to install plugins

# neovim
pip3 install neovim

# postgres
initdb
brew services start postgresql
createdb $USER
```

### iterm2 config?
- Import color scheme ~/Dracula.itermcolors
- alt keys? dont recall exactly

### ruby
```
ruby-install ruby
ruby-install ruby 2.3.4
```

# osx

### Map CapsLock to Control
http://teohm.com/blog/mac-tips-use-caps-lock-as-control-key/

### Key repeat speed
```
defaults write -g InitialKeyRepeat -int 13 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
defaults write com.apple.finder AppleShowAllFiles YES
```

### Keyboard
Keyboard > Shortcuts > App Shortcuts
- Sleep > Alt q
- Copy > Ctrl c
- Paste > Ctrl v

Keyboard > Shortcuts > Mission Control
- Move left a space > Ctrl Command h
- Move right a space > Ctrl Command l
- Application windows > Ctrl Command j
- Mission Control > Ctrl Command k

# Legacy
### keys
```
gpg --import zach.asc
gpg --edit-key zach
gpg> trust
Your decision? 5 # Trust ultimately
Do you really want to set this key to ultimate trust? (y/N) y
```
