#!/usr/bin/env bash
echo "Hello...Starting post install script"
echo "
-----------------------------------------------------------------------
- HHHH     HHHH  EEEEEEEEEEEEEEEE 
- HHHH     HHHH  EEEEEEEEEEEEEEEE
- HHHH     HHHH  EEEEEEEEEEEEEEEE
- HHHH     HHHH  EEEEEEEEEEEEEEEE
- HHHH     HHHH  EEEE
- HHHH     HHHH  EEEE
- HHHHHHHHHHHHH  EEEEEEEEEEEE
- HHHHHHHHHHHHH  EEEEEEEEEEEE
- HHHHHHHHHHHHH  EEEE
- HHHH     HHHH  EEEE
- HHHH     HHHH  EEEEEEEEEEEEEEEE
- HHHH     HHHH  EEEEEEEEEEEEEEEE
- HHHH     HHHH  EEEEEEEEEEEEEEEE
- HHHH     HHHH  EEEEEEEEEEEEEEEE
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
#adds brave-browser into repository
sudo nala install curl -y
sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main" | sudo tee /etc/apt/sources.list.d/brave-browser-release.list
#installs aditional packages. Now with nala
sudo nala update
sudo nala install brave-browser flatpak neofetch golang nodejs npm gh timeshift -y
#flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo 
#flatpak install flathub com.discordapp.Discord -y
#installs latest neovim stable release
curl -o ~/neovim.deb -L https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.deb
sudo nala install ~/neovim.deb -y
rm ~/neovim.deb
#installs DENO => javascript runtime
curl -fsSL https://deno.land/x/install/install.sh | sh
#installs lazygit
go install github.com/jesseduffield/lazygit@latest
#prompt to install AstroNvim
while true; do
  read -p "Would you like to install AstroNvim?" yn
  case $yn in
    [Yy]*)
      echo "Installing AstroNvim"
      git clone --depth 1 https://github.com/AstroNvim/AstroNvim ~/.config/nvim
      break;;
    [Nn]*)
      echo "abort..."
      break;;
    *) echo "Please enter y/n"
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
