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
    ```

3. Clone dotfiles
    ```
    git clone git@github.com:taylorzr/dotfiles.git
    ```

4. Link all the things
    ```
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
    ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    tmux source ~/.tmux.conf
    # Install plugins, C-b I (tmux prefix followed by *capital* I)
    ```

6. Vim plugin manager and plugins
    ```
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

#### TODO
- power managment, suspend to ram/disk
- trackpad gestures, back/forward, prev/next workspace
- better visuals, lock screen, etc
- vpn setup
- ssh remember key password
- remaining multimedia keys (back, play/pause, forward)
- i3 split use current directory if shell
- install elixir 1.3.4

