#!/usr/bin/env bash
set -euo pipefail

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root."
  exit 1
fi

install -m 755 codefreak-manager /usr/local/bin/codefreak-manager

cat > /etc/systemd/system/codefreak-manager.service <<'EOF'
[Unit]
Description=CodeFreak SSH Manager Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/codefreak-manager
Restart=on-failure
StandardInput=tty
TTYPath=/dev/tty
RemainAfterExit=no

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable codefreak-manager.service

echo "[OK] Installed CodeFreak SSH Manager"
echo "Run manually with: codefreak-manager"
echo "Or start service with: systemctl start codefreak-manager"
