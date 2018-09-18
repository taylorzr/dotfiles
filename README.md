# general setup

These dotfiles are setup as a bare repository. This avoids the need to symlink all the things, which
is tedious. But because it is a bare repository, home is not a git directory, so all directories
under home don't think they're within the dotfiles repository.
```
git clone --bare git@github.com:taylorzr/dotfiles.git $HOME/dotfiles
alias dot='git --git-dir=$HOME/dotfiles/ --work-tree=$HOME'
dot checkout
dot config --local status.showUntrackedFiles no
```

### plugins for zsh, tmux, and vim
```
# Zsh
git clone https://github.com/tarjoilija/zgen.git "${HOME}/.zgen"

# Tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start tmux and run Prefix + I to install plugins

# Vim
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim # Used by deoplete
# start vim and ensure plugins get auto-installed or run :PlugInstall
```

# keys
```
chmod 400 ~/.ssh/id_rsa
gpg --import zach.asc
gpg --edit-key zach
gpg> trust
Your decision? 5 # Trust ultimately
Do you really want to set this key to ultimate trust? (y/N) y
```

# arch
# {{{
### TODO
- i3 split use current directory if shell
- power managment, suspend to ram/disk
    maybe helpful: https://wiki.archlinux.org/index.php/I3#Shutdown.2C_reboot.2C_lock_screen

```
sudo pacman -S acpi chruby git glances feh fzf hub i3 neovim polybar termite xorg xsel volumeicon yaourt zsh
yaourt -S google-chrome neofetch the_silver_searcher
```

### Troubleshooting
Microphone not working
```
alsamixer
f6 # Select sound card
# Select 'HDA Intel PCH'
f4 # View capture controls
# move to 'Capture' control
# toggle CAPTURE mode with spacebar
```

### Docs
Using swapfile: https://wiki.archlinux.org/index.php/Swap#Swapfile

# }}}

# osx
# {{{

### Map CapsLock to Control
http://teohm.com/blog/mac-tips-use-caps-lock-as-control-key/

### Key repeat speed
```
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225
ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)
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
# }}}

# code completion
Ruby:
* `gem install solargraph`
* `solargraph socket`
* start vim, should get semantic code completion
