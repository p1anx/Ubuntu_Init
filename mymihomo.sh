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


