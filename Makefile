.PHONY: setup
setup: install ssh

.PHONY: install
install:
	sudo dnf install cmake g++ zsh kitty vim fzf tldr jq ripgrep golang direnv
	touch ~/.config/shell/local.sh
	mkdir -p ~/code

ssh: ~/.ssh/id_ed25519
~/.ssh/id_ed25519:
	ssh-keygen -t ed25519 -C 108883+taylorzr@users.noreply.github.com
	cat ~/.ssh/id_ed25519.pub

.PHONY: gpg
gpg:
	gpg --full-generate-key
	gpg --list-secret-keys --keyid-format=short
