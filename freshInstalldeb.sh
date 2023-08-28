#!/usr/bin/env bash
echo "Hello...Starting fresh install script"
echo "
-----------------------------------------------------------------------
This script will install basic software 
-----------------------------------------------------------------------
"
while true; do
	read -p "Would you like to continue?" yn
	case $yn in
	[Yy]*)
		echo "Starting clean slate script..."
		break
		;;
	[Nn]*)
		echo "Abort..."
		exit
		;;
	*) echo "Please answer y/n." ;;
	esac
done
#initial update and upgrade
sudo apt update
sudo apt upgrade -y
#installs nala
sudo apt install nala
sudo nala install curl flatpak neofetch golang nodejs npm gh timeshift -y

################################################################################
#     All aditional user software will be installed via Nix Package Manager    #
################################################################################

curl -L https://nixos.org/nix/install | sh

#installs DENO => javascript runtime
#curl -fsSL https://deno.land/x/install/install.sh | sh
#installs lazygit
#go install github.com/jesseduffield/lazygit@latest
#prompt to install AstroNvim
while true; do
	read -p "Would you like to install AstroNvim?" yn
	case $yn in
	[Yy]*)
		echo "Installing AstroNvim"
		git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
		break
		;;
	[Nn]*)
		echo "abort..."
		break
		;;
	*) echo "Please enter y/n" ;;
	esac
done
#prompt user to install doomemacs
while true; do
	read -p "Would you like to install DOOM emacs?(Neovim is already isntalled)" yn
	case $yn in
	[Yy]*)
		echo "installing doom emacs"
		sudo nala install emacs -y
		git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
		~/.config/emacs/bin/doom install
		echo "export PATH='$HOME/.emacs.d/bin:$PATH'" >>~/.bashrc
		break
		;;
	[Nn]*) break ;;
	*) echo "please answer y/n." ;;
	esac
done
#prompt to install VScode
while true; do
	read -p "Would you like to install Visual Studio Code?(Neovim is already installed)" yn
	case $yn in
	[Yy]*)
		echo "installing VS Code"
		curl -o ~/vscode.deb -L http://go.microsoft.com/fwlink/?LinkID=760868
		sudo nala install ~/vscode.deb -y
		rm ~/vscode.deb
		break
		;;
	[Nn]*)
		echo "abort..."
		break
		;;
	*) echo "please answer y/n." ;;
	esac
done
echo "Finishing script..."
source ~/.bashrc
echo "Thank you for using our services."
echo "after installing neovim from nix. Dont forget to run TSInstall astro"
