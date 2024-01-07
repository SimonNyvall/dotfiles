#!/usr/bin/env bash

sudo apt update && sudo apt upgrade -y

# Install neovim
sudo apt install neovim -y

# Install i3
wget -O- https://baltocdn.com/i3-window-manager/signing.asc | gpg --dearmor >/etc/apt/trusted.gpg.d/i3wm-signing.gpg

apt install apt-transport-https --yes

echo "deb https://baltocdn.com/i3-window-manager/i3/i3-autobuild/ all main" | sudo tee /etc/apt/sources.list.d/i3-autobuild.list

sudo apt update

sudo apt install i3 -y

# Install starship
curl -sS https://starship.rs/install.sh | sh

# Install tmux
sudo apt install tmux -y

# Install fzf
sudo apt install fzf -y

# Install alacritty
sudo add-apt-repository ppa:aslatter/ppa -y
sudo apt install alacritty -y