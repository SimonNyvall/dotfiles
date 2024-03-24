#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

# Install neovim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
./nvim.appimage

./nvim.appimage --appimage-extract
./squashfs-root/AppRun --version

# Optional: exposing nvim globally.
sudo mv squashfs-root /
sudo ln -s /squashfs-root/AppRun /usr/bin/nvim
nvim

# Install i3
wget -O- https://baltocdn.com/i3-window-manager/signing.asc | gpg --dearmor >/etc/apt/trusted.gpg.d/i3wm-signing.gpg

apt install apt-transport-https --yes

echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list

sudo apt update

sudo apt install i3 -y

sudo apt install i3lock-fancy -y

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install tmux
sudo apt install tmux -y

# Install fzf
sudo apt install fzf -y

# Install alacritty
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt install alacritty -y

# Install lazygit
LAZYGIT_VERSION=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*')
curl -Lo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VERSION}_Linux_x86_64.tar.gz"
tar xf lazygit.tar.gz lazygit
sudo install lazygit /usr/local/bin

# Install font
echo 'Install the font at https://github.com/ryanoasis/nerd-fonts/releases/download/v3.1.1/JetBrainsMono.zip'

# Install catbat
sudo apt install bat -y

# Install zoxide
sudo apt isntall zoxide -y

# Midnight commander
sudo add-apt-repository universe
sudo apt install mc -y
