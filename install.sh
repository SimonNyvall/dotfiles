#!/usr/bin/env bash

# Ask Y/n
function ask() {
	read -p "$1 (Y/n): " resp
	if [ -z "$resp" ]; then
		response_lc="y" # empty is Yes
	else
		response_lc=$(echo "$resp" | tr '[:upper:]' '[:lower:]') # case insensitive
	fi

	[ "$response_lc" = "y" ]
}

# Check what shell is being used
SH="${HOME}/.bashrc"
ZSHRC="${HOME}/.zshrc"
if [ -f "$ZSHRC" ]; then
	SH="$ZSHRC"
fi

echo >>"$SH"
echo '# -------------- SimonNyvall:dotfiles install ---------------' >>"$SH"

# Ask which files should be sourced
echo "Do you want $SH to source: "
for file in shell/*; do
	if [ -f "$file" ]; then
		filename=$(basename "$file")
		if ask "${filename}?"; then
			echo "source $(realpath "$file")" >>"$SH"
		fi
	fi
done

# Ask if .ssh_aliases should be sourced
if ask "Create .ssh_aliases to be sourced?"; then
	if [ ! -e ~/.ssh_aliases ]; then
		touch ~/.ssh_aliases
	fi
	echo 'source ~/.ssh_aliases' >>"$SH"
fi

echo '# -------------- SimonNyvall:dotfiles install ---------------' >>"$SH"

# Tmux conf
if ask "Do you want to install tmux.conf?"; then
	mkdir -p ~/.config/tmux
	ln -s "$(realpath "tmux.conf")" ~/.config/tmux/tmux.conf
fi

# Vim conf
if ask "Do you want to install nvim folder?"; then
	ln -s "$(realpath "nvim")" ~/.config/nvim
fi

# starship
if ask "Do you want to install starship.toml?"; then
	ln -s "$(realpath "starship.toml")" ~/.config/starship.toml
fi

# alacritty
if ask "Do you want to install alacritty.yml?"; then
	mkdir -p ~/.config/alacritty
	ln -s "$(realpath "alacritty.yml")" ~/.config/alacritty/alacritty.yml
fi

# i3
if ask "Do you want to install i3?"; then
	mkdir -p ~/.config/i3
	ln -s "$(realpath "i3")" ~/.config/i3/config

	unzip bumb.zip -d bumblebee-status
fi

# Session forge
if ask "Do you want to install session forge? (You will need to have tmux installed)"; then
	cd /bin || exit 1
	git clone https://github.com/SimonNyvall/SessionForge.git
	echo "sessionForge.sh" >>"$SH"
fi
