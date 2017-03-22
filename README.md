# Setup

### git
1. Install git and hub:

    `brew install git` or `sudo apt install git`
    `brew install hub` or `sudo apt install git`

2. Link config:

    ```
    ln -s ~/dotfiles/gitconfig ~/.gitconfig
    ```


### zsh
1. Install zsh:

    `brew install zsh` or `sudo apt install zsh`

2. Install [oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh):

    ```
    sh -c "$(curl -fsSL \
      https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    ```

3. Link config:

    ```
    mv ~/.zshrc ~/.zshrc.backup
    ln -s ~/dotfiles/zshrc ~/.zshrc
    ```


### tmux
1. Install tmux:

    `brew install tmux` or `sudo apt install tmux`

2. Install [tmux plugin manager](https://github.com/tmux-plugins/tpm):

    ```
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ```

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

    ```
    curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    ```

5. Install plugins with `:PlugInstall`


### ssh
1. Link config: `ln -s ~/dotfiles/ssh/config ~/.ssh/config` # osx only


### ack
1. Install [ack](https://beyondgrep.com): `brew install ack`
2. Link config: `ln -s ~/dotfiles/ackrc ~/.ackrc`
