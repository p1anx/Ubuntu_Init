#!/bin/bash

sudo apt update

sudo apt install curl -y

# ********************************************
# git config
sudo apt install git -y

git config --global user.name "xwj"
git config --global user.email "2514034568@qq.com"

# ********************************************
# zsh
sudo apt install zsh -y

sh -c "$(curl -fsSL https://gitee.com/shmhlsy/oh-my-zsh-install.sh/raw/master/install.sh)"

git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions

git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

echo 'POWERLEVEL9K_DISABLE_CONFIGURATION_WIZARD=true' ~/.zshrc >>!

# sed -i '12c\ZSH_THEME="bira"' ~/.zshrc
sed -i '18c\ZSH_THEME="powerlevel10k/powerlevel10k"' ~/.zshrc
sed -i '81c\plugins=(git z extract web-search zsh-syntax-highlighting zsh-autosuggestions)' ~/.zshrc
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

# ********************************************
# vim
sudo apt install vim -y
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

# ********************************************
# ssh
sudo apt install openssh-server -y
sudo /etc/init.d/ssh start
ssh-keygen -t rsa -C "2514034568@qq.com" #-t表示类型选项，这里采用rsa加密算法
# ssh-copy-id ldz@192.168.0.1 #使用ssh-copy-id命令将公钥复制到远程主机

# ********************************************
# pythoh and pip
sudo add-apt-repository ppa:deadsnakes/ppasudo
sudo apt update
sudo apt install python3.12 -y

sudo apt install python3-pip -y

# ********************************************
# sublime-text
wget -qO - https://download.sublimetext.com/sublimehq-pub.gpg | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/sublimehq-archive.gpg >/dev/null
echo "deb https://download.sublimetext.com/ apt/stable/" | sudo tee /etc/apt/sources.list.d/sublime-text.list
sudo apt-get update
sudo apt-get install sublime-text

# ********************************************
sudo apt instlal tmux -y

# ********************************************
# node and npm
sudo apt install nodejs -y
sudo apt install npm -y

# vscode
curl https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo mv microsoft.gpg /etc/apt/trusted.gpg.d/microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
sudo apt-get update
sudo apt-get install code

