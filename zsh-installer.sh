#!/bin/bash

# ZSH

zsh_apt() {
    echo -e "\n=================================Installing Zsh=================================\n"
    sudo apt update && sudo apt install -y zsh git curl
}

zsh_pacman() {
    echo -e "\n=================================Installing Zsh=================================\n"
    sudo pacman -Syu --noconfirm --needed zsh curl git
}

echo "Select package manager:"
echo -e "\t1) apt (Debian-based)"
echo -e "\t2) pacman (Arch-based)"
read -p "Enter 1 or 2: " pkg_choice

case $pkg_choice in
    1)
        zsh_apt
        ;;
    2)
        zsh_pacman
        ;;
    *)
        echo "Invalid choice. Please enter 1 or 2."
        exit 1
        ;;
esac

# Oh My Zsh
echo -e "\n==============================Installing Oh My Zsh==============================\n"
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# zsh-autosuggestions
echo -e "\n==========================Instaling zsh-autosuggestions=========================\n"
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

# zsh-syntax-highlighting
echo -e "\n=======================Instalilng zsh-syntax-highlighting=======================\n"
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

# Enable plugins in .zshrc
echo -e "\n================================Enabling plugins================================\n"
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc
echo "DONE"

# Default shell to Zsh
echo -e "\n==========================Changing default shell to zsh=========================\n"
chsh -s $(which zsh)
echo "DONE"
