#!/bin/bash

# List of packages to install
curl -fsSL https://deb.nodesource.com/setup_22.x -o nodesource_setup.sh
sudo -E bash nodesource_setup.sh
echo "Updating package lists..."
sudo apt-get update
packages=(
  "curl"
  "build-essential"
  "git"
  "vim"
  "htop"
  "python3"
  "python3-pip"
  "python3-venv"
  "ripgrep"
  "gdb"
  "tree"
  "nodejs"
  "ninja-build"
  "cmake"
  "make"
  "unzip"
  "gettext"
  "glibc-gconv-extra"
  "xclip"
)

# Install each package
for package in "${packages[@]}"
do
  echo "Installing $package..."
  sudo apt-get install -y $package
done

echo "All packages installed successfully!"

echo "\n\n\n******Building Neovim******\n\n\n"
git clone https://github.com/neovim/neovim
cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo
cd build && cpack -G DEB && sudo dpkg -i nvim-linux64.deb

cp -r ~/nvim ~/.config/ && cd ~/.config/nvim/
nvim .

