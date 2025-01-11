# Plugins

# Much easier and faster to just clone these zsh plugins than use some crazy slow zsh plugin manager

if [ ! -d ~/.zsh/zsh-autosuggestions ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
fi
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh

if [ ! -d ~/.zsh/zsh-syntax-highlighting ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
fi
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

if [ ! -d ~/.zsh/fzf-tab ]; then
  git clone https://github.com/Aloxaf/fzf-tab ~/.zsh/fzf-tab
fi
source ~/.zsh/fzf-tab/fzf-tab.plugin.zsh

if [ ! -d ~/.zsh/spaceship ]; then
  git clone --depth=1 https://github.com/spaceship-prompt/spaceship-prompt.git "$HOME/.zsh/spaceship"
fi

source "$HOME/.zsh/spaceship/spaceship.zsh"
