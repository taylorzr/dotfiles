# common
```
git clone git@github.com:taylorzr/dotfiles.git
ln -fs ~/dotfiles/{.bashrc,.bash_profile,.tmux.conf,.gitconfig,.zshrc} ~
ln -s ~/dotfiles/config/nvim ~/.config/nvim
chmod 400 ~/.ssh/id_rsa
```

### tmux
```
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# start tmux and run Prefix + I to install plugins
```

### vim
```
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim # Used by deoplete
# start vim and ensure plugins get auto-installed or run :PlugInstall
```



# arch
```
sudo pacman -S acpi chruby git feh fzf htop hub i3 neovim polybar termite xorg xsel yaourt
yaourt -S google-chrome neofetch the_silver_searcher
```

```
ln -s ~/dotfiles/config/i3 ~/.config/i3
ln -s ~/dotfiles/config/termite/config ~/.config/termite/config
ln -s ~/dotfiles/config/polybar ~/.config/polybar
ln -s ~/dotfiles/{xinitrc,Xresources} ~
```

```
gpg --import zach.asc
gpg --edit-key zach
gpg> trust
Your decision? 5 # Trust ultimately
Do you really want to set this key to ultimate trust? (y/N) y
```

### TODO
- i3 split use current directory if shell
- power managment, suspend to ram/disk
    maybe helpful: https://wiki.archlinux.org/index.php/I3#Shutdown.2C_reboot.2C_lock_screen
- trackpad gestures, back/forward, prev/next workspace

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



# osx

```
brew install bash bash-completion2 fzf hub neovim the_silver_searcher tmux
brew tap homebrew/services
ln -s '~/dotfiles/Library/Application Support/Spectacle/Shortcuts.json' '~/Library/Application Support/Spectacle/Shortcuts.json' # Not sure if this works still
```

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

### Mission control shortcuts
https://apple.stackexchange.com/questions/106559/keyboard-shorcut-to-switch-focus-between-multiple-displays-on-os-x-10-9-5-mav
```
Command Control h # Move previous screen
Command Control l # Move next screen
Command Control k # Show screens
Command Control j # Hide screens
```
