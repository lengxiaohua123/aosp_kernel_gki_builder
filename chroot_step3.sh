#!/bin/bash

cd /usr/lib/firmware/
ldconfig

cat > /etc/systemd/system/resizefs.service << 'EOF'
[Unit]
Description=Expand root filesystem to fill partition
After=local-fs.target

[Service]
Type=oneshot
ExecStart=/usr/bin/bash -c 'exec /usr/sbin/resize2fs $(findmnt -nvo SOURCE /)'
ExecStartPost=/usr/bin/systemctl disable resizefs.service
RemainAfterExit=true

[Install]
WantedBy=default.target
EOF

systemctl enable resizefs.service

cat > /etc/systemd/system/serial-getty@ttyGS0.service << EOF
[Unit]
Description=Serial Console Service on ttyGS0

[Service]
ExecStart=-/usr/sbin/agetty -L 115200 ttyGS0 xterm+256color
Type=idle
Restart=always
RestartSec=0

[Install]
WantedBy=multi-user.target
EOF
systemctl enable serial-getty@ttyGS0.service
#如果串口登录失效，可能是g_serial模块没有加载
echo g_serial >> /etc/modules

