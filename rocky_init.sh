#!/bin/bash

# git config
git config --global user.name "xwj"
git config --global user.email "2514034568@qq.com"

# c_cpp
sudo yum -y gcc gcc-g++

# zsh and oh-my-zsh
sudo yum install -y zsh

sh -c "$(curl -fsSL https://gitee.com/shmhlsy/oh-my-zsh-install.sh/raw/master/install.sh)" 

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'plugins=(git z extract web-search zsh-syntax-highlighting zsh-autosuggestions)' >>~/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >>~/.zshrc
source ~/.zshrc

# ********************************************
#install nerd fonts
mkdir -p ~/.local/share/fonts

cd ~/.local/share/fonts && curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.tar.xz

mkdir JetBrainsMono
tar -xvf JetBrainsMono.tar.xz -C ~/.local/share/fonts/JetBrainsMono/

curl -OL https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Mononoki.tar.xz

mkdir Mononoki
tar -xvf Mononoki.tar.xz -C ~/.local/share/fonts/Mononoki/

# vim
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# ********************************************
# nvim and lazyvim
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim-linux64.tar.gz
sudo rm -rf /opt/nvim
sudo tar -C /opt -xzf nvim-linux64.tar.gz

echo 'export PATH="$PATH:/opt/nvim-linux64/bin"' >>~/.zshrc

source ~/.zshrc

# required
mv ~/.config/nvim{,.bak}

# optional but recommended
mv ~/.local/share/nvim{,.bak}
mv ~/.local/state/nvim{,.bak}
mv ~/.cache/nvim{,.bak}

git clone https://github.com/LazyVim/starter ~/.config/nvim

# python
sudo dnf install gcc openssl-devel bzip2-devel libffi-devel wget tar make
mkdir python
cd python
wget https://www.python.org/ftp/python/3.12.4/Python-3.12.4.tar.xz
tar -xvJf Python-3.12.4.tar.xz

cd Python-3.12.4
# ./configure --enable-optimizations
./configure --prefix=/usr/local/Python3
sudo make -j $(nproc)
sudo make altinstall

sudo ln -s /usr/local/python3/bin/python3 /usr/local/bin/python
sudo ln -s /usr/local/python3/bin/pip3 /usr/local/bin/pip

echo "export PATH=/usr/local/bin:$PATH" >>~/.zshrc
