#!/bin/bash

#================================================
# zsh
#================================================
# 检测系统类型
if grep -q "Ubuntu" /etc/os-release; then
  # Ubuntu 系统
  echo "this is ubuntu"
  sudo apt update
  sudo apt install -y zsh vim tmux fzf tar wget
elif grep -q "Rocky" /etc/os-release; then
  # Rocky Linux 系统
  echo "this is rocky linux"
  sudo dnf update
  sudo dnf config-manager --set-enabled crb
  sudo dnf install -y epel-release
  sudo dnf install -y zsh 
  sudo dnf install -y tar 
  sudo dnf install -y wget
  sudo dnf install -y vim
  sudo dnf install -y tmux
  sudo dnf install -y fzf
else
  echo "不支持当前系统。"
  exit 1
fi

sh -c "$(curl -fsSL https://gitee.com/shmhlsy/oh-my-zsh-install.sh/raw/master/install.sh)" 
echo 'ZSH_THEME="bira"' >> ~/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc
echo "zsh 已成功安装。"
#================================================
# download mihomo file and config
#================================================
mihomo_dir=~/mihomo_setup
mkdir $mihomo_dir
cd $mihomo_dir
system_arch=$(uname -m)
if [ -f "/usr/local/bin/mihomo" ] && [ -f "/etc/mihomo/config.yaml" ]; then
    echo "========================"
    echo "mihomo is ok"
    echo "config.yaml is ok"
    echo "========================"
else
    case "$system_arch" in
        "aarch64")
            wget -O mihomo.gz "https://gitee.com/ClockOS/mihomo/releases/download/my_mihomo/mihomo-linux-arm64-v1.18.7.gz"
            ;;
        "x86_64")
            wget -O mihomo.gz "https://gitee.com/ClockOS/mihomo/releases/download/my_mihomo/mihomo-linux-amd64-v1.18.7.gz"
            ;;
        *)
            echo "mihomo config failed"
            ;;
    esac
    gunzip mihomo.gz
    chmod +x mihomo
    # download clash config file
    wget -O config.yaml "https://ea8i3.no-mad-world.club/link/mnvbvGMuoVslKjYg?clash=3&extend=1"

    sudo mkdir /etc/mihomo
    sudo cp $mihomo_dir/mihomo /usr/local/bin
    sudo cp config.yaml /etc/mihomo
fi


#set mihomo.service
mkdir $mihomo_dir/mihomo.service && cd $mihomo_dir/mihomo.service
git clone https://gitee.com/ClockOS/mihomo.git
sudo cp mihomo/mihomo.service /etc/systemd/system/

# reload systemd
sudo systemctl daemon-reload
# enable mihomo
sudo systemctl enable mihomo
# start mihomo
sudo systemctl start mihomo
# reload mihomo
sudo systemctl reload mihomo

sudo systemctl status mihomo

# set proxy on or off
a=$(echo $SHELL)
echo "shell:$a"
 
case "$a" in
    "/bin/bash")
#块写入内容
#以下内容必须从开头第一列开始直到EOF结尾，不然会报错
        cat << EOF >> ~/.bashrc 
# set proxy on or off
# 开启代理
function pon(){
   export all_proxy=socks5://127.0.0.1:7890  # 注意你的端口号可能不是7890，注意修改
   export http_proxy=http://127.0.0.1:7890
   export https_proxy=http://127.0.0.1:7890
   echo -e "已开启代理"
}
# 关闭代理
function poff(){
    unset all_proxy
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}
EOF
        cat << EOF >> ~/.zshrc 
# set proxy on or off
# 开启代理
function pon(){
   export all_proxy=socks5://127.0.0.1:7890  # 注意你的端口号可能不是7890，注意修改
   export http_proxy=http://127.0.0.1:7890
   export https_proxy=http://127.0.0.1:7890
   echo -e "已开启代理"
}
# 关闭代理
function poff(){
    unset all_proxy
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}
EOF
        source ~/.bashrc
        source ~/.zshrc
        ;;
    "/usr/bin/zsh")
        cat << EOF >> ~/.zshrc
# set proxy on or off
# 开启代理
function pon(){
   export all_proxy=socks5://127.0.0.1:7890  # 注意你的端口号可能不是7890，注意修改
   export http_proxy=http://127.0.0.1:7890
   export https_proxy=http://127.0.0.1:7890
   echo -e "已开启代理"
}
# 关闭代理
function poff(){
    unset all_proxy
    unset http_proxy
    unset https_proxy
    echo -e "已关闭代理"
}
EOF
            source ~/.zshrc
            ;;
        *)
            echo "================================="
            echo "error: proxy config failed!!!!!"
            echo "================================="
            ;;
esac
# 开启代理
#pon
# run mihomo
# mihomo -d /etc/mihomo
#================================================
# git config
#================================================
git config --global user.name "xwj"
git config --global user.email "2514034568@qq.com"

#================================================
# oh my zsh
#================================================
#sh -c "$(wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh -O -)"

# chsh -s /usr/bin/zsh  # 将 zsh 作为默认 shell
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

echo 'plugins=(git z extract web-search zsh-syntax-highlighting zsh-autosuggestions)' >> ~/.zshrc
echo 'source $ZSH/oh-my-zsh.sh' >> ~/.zshrc


#================================================
# vim
#================================================
git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh
