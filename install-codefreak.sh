#!/usr/bin/env bash
set -euo pipefail

REPO="MindFreak09-King/codefreak-manager"
RAW="https://raw.githubusercontent.com/$REPO/main"

if [[ "$EUID" -ne 0 ]]; then
  echo "Please run as root."
  exit 1
fi

apt update
apt install -y curl

echo "[INFO] Downloading CodeFreak Manager..."

curl -fsSL "$RAW/codefreak-manager" -o /usr/local/bin/codefreak-manager
chmod +x /usr/local/bin/codefreak-manager

echo "[INFO] Creating service..."

cat > /etc/systemd/system/codefreak-manager.service << 'EOF'
[Unit]
Description=CodeFreak SSH Manager Service
After=network.target

[Service]
Type=simple
ExecStart=/usr/local/bin/codefreak-manager
Restart=on-failure
StandardInput=tty
TTYPath=/dev/tty

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable codefreak-manager.service

echo "[OK] Installation complete!"
echo "Run: sudo codefreak-manager"
