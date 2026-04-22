#!/usr/bin/env bash
set -euo pipefail

REPO_USER="MindFreak09-King"
REPO_NAME="codefreak-manager"
BRANCH="main"
RAW_BASE="https://raw.githubusercontent.com/${REPO_USER}/${REPO_NAME}/${BRANCH}"

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run as root."
  exit 1
fi

apt update
apt install -y curl

curl -fsSL "${RAW_BASE}/codefreak-manager" -o /usr/local/bin/codefreak-manager
chmod 755 /usr/local/bin/codefreak-manager

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
echo "Run manually with: sudo codefreak-manager"
echo "Or start service with: sudo systemctl start codefreak-manager"
