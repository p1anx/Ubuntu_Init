#!/bin/bash
#================================================
# download mihomo file and config
mkdir mihomo_setup
cd mihomo_setup
system_arch=$(uname -m)
case "$system_arch" in
    "aarch64")
        wget -O mihomo.gz "https://gitee.com/ClockOS/mihomo/releases/download/my_mihomo/mihomo-linux-arm64-v1.18.7.gz"
        ;;
    "amd64")
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
sudo cp mihomo /usr/local/bin
sudo cp config.yaml /etc/mihomo

#================================================
#set mihomo.service
mkdir mihomo.service && cd mihomo.service
git clone https://gitee.com/ClockOS/mihomo.git
sudo cp mihomo/mihomo.service /etc/systemd/system/

# reload systemd
systemctl daemon-reload
# enable mihomo
systemctl enable mihomo
# start mihomo
systemctl start mihomo

# set proxy on or off
a=$(echo $SHELL)
echo "shell:$a"
 
 #if [ "$(echo $SHELL) == /bin/bash" ]; then
 #    echo "bash"
 #elif [ "$(echo $SEHLL) == /bin/zsh" ]; then
 #    echo "zsh"
 #else
 #    echo "other"
 #fi
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
            source ~/.bashrc
            ;;
        *)
            echo "other"
            ;;
esac

