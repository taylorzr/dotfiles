<<<<<<< Updated upstream
## Arch

1. Install packages
    ```
    sudo pacman -S \
      acpi    \ `# battery information for i3blocks`
      git     \ `# version control system`
      feh     \ `# preview images and set background`
      fish    \ `# a shell for the 90s`
      fzf     \ `# fuzzy search`
      htop    \ `# process info and control`
      hub     \ `# git extension for github support`
      i3      \ `# window manager`
      maim    \ `# screenshots`
      neovim  \ `# edit text`
      termite \ `# terminal emulator`
      xorg    \ `# screen stuff`
      xsel    \ `# copy-paste support for nvim`
      yaourt  \ `# install aur stuff`

    sudo yaourt -S \
      google-chrome       \ `# web`
      neofetch            \ `# show system information`
      the_silver_searcher \ `# more better grep`
      ```

2. Setup ssh
    ``` 
    mv ~/Downloads/id_rsa* ~/.ssh chmod 400 ~/.ssh/id_rsa
||||||| merged common ancestors
# Setup

### git
1. Install git and hub:

    `brew install git` or `sudo apt install git`
    `brew install hub` or `sudo apt install git`

2. Link config:

    ```
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
=======
# Setup

### git
1. Install git and hub:

    `brew install git` or `sudo apt install git`
    `brew install hub` or `sudo apt install git`

2. Link config:
```
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
>>>>>>> Stashed changes
    ```

3. Clone dotfiles
    ```
    git clone git@github.com:taylorzr/dotfiles.git
    ```

4. Link all the things
    ```
<<<<<<< Updated upstream
    ln -s ~/dotfiles/xinitrc ~/.xinitrc
    ln -s ~/dotfiles/xmodmap ~/.xmodmap
    ln -s ~/dotfiles/Xresources ~/.Xresources
    ln -s ~/dotfiles/config/i3/config ~/.config/i3/config
    ln -s ~/dotfiles/config/termite/config ~/.config/termite/config
    ln -s ~/dotfiles/config/fish/functions/fish_prompt.fish ~/.config/fish/functions/fish_prompt.fish
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
    ln -s ~/dotfiles/config/nvim/init.vim ~/.config/nvim/init.vim
    ```

5. Tmux plugin manager and plugins
||||||| merged common ancestors
    mv ~/.zshrc ~/.zshrc.backup
    ln -s ~/dotfiles/zshrc ~/.zshrc
    ```


### tmux
1. Install tmux:

    `brew install tmux` or `sudo apt install tmux`

2. Install [tmux plugin manager](https://github.com/tmux-plugins/tpm):

=======
    mv ~/.zshrc ~/.zshrc.backup
    ln -s ~/dotfiles/zshrc ~/.zshrc ``` 
### tmux
1. Install tmux:

    `brew install tmux` or `sudo apt install tmux`

2. Install [tmux plugin manager](https://github.com/tmux-plugins/tpm):

>>>>>>> Stashed changes
    ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux source ~/.tmux.conf
    # Install plugins, C-b I (tmux prefix followed by *capital* I)
    ```

<<<<<<< Updated upstream
6. Vim plugin manager and plugins
||||||| merged common ancestors
3. Install plugins with `Prefix + I`


### vim
1. Install vim:

    `brew install vim` or `sudo apt install vim`

2. Link config:

    ```
    ln -s ~/dotfiles/vimrc ~/.vimrc
    ln -s ~/dotfiles/vim/colors ~/.vim/
    ```

4. Install [vim-plug](https://github.com/junegunn/vim-plug):

=======
3. Link config:
    ```
    ln -s ~/dotfiles/tmux.conf ~/.tmux.conf
    ```

3. Install plugins with `Prefix + I`


### vim
1. Install vim:

    `brew install vim` or `sudo apt install vim`

2. Link config:

    ```
    ln -s ~/dotfiles/vimrc ~/.vimrc
    mkdir ~/.vim
    ln -s ~/dotfiles/vim/colors ~/.vim/
    ```

4. Install [vim-plug](https://github.com/junegunn/vim-plug):

>>>>>>> Stashed changes
    ```
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

#### TODO
- power managment, suspend to ram/disk
    maybe helpful: https://wiki.archlinux.org/index.php/I3#Shutdown.2C_reboot.2C_lock_screen
- trackpad gestures, back/forward, prev/next workspace
- better visuals, lock screen, etc
- vpn setup
- ssh remember key password
- remaining multimedia keys (back, play/pause, forward)
- i3 split use current directory if shell
- install elixir 1.3.4

#### Troubleshooting
Microphone not working
- alsamixer
- f6 # Select sound card
- Select 'HDA Intel PCH'
- f4 # View capture controls
- move to 'Capture' control
- toggle CAPTURE mode with spacebar


### OSX

#### SSH Credentials
- move to ~/.ssh
- chmod 400 ~/.ssh/id_rsa
#### Tokens
- move to ~/dotfiles
- chmod 400 ~/dotfiles/tokens

#### Caps lock -> control
http://teohm.com/blog/mac-tips-use-caps-lock-as-control-key/

#### Clock
Change clock to 24 hour

#### Mission control shortcuts
Command Control h # Move previous screen
Command Control l # Move next screen
Command Control k # Show screens
Command Control j # Hide screens
https://apple.stackexchange.com/questions/106559/keyboard-shorcut-to-switch-focus-between-multiple-displays-on-os-x-10-9-5-mav

#### Key repeat speed
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225
ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

#### TODO
ln -s '~/dotfiles/Library/Application Support/Spectacle/Shortcuts.json '~/Library/Application Support/Spectacle/Shortcuts.json'
ln -s '~/dotfiles/ctags' '~/.ctags'
ln -s '~/dotfiles/config/fish/config.fish' '~/.config/fish/config.fish'
