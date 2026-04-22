# CodeFreak SSH Manager

Simple SSH Manager for VPS with expiry system and bulk account support.

## Features

- Create SSH Account
- Bulk Account Creation
- Delete Account
- Edit Account
- List Account
- Extend Account
- Change Password
- Restart SSH
- Reboot VPS
- Uninstall SSH Manager

## Quick Install

```bash
curl -fsSL https://raw.githubusercontent.com/MindFreak09-King/codefreak-manager/main/install-codefreak.sh -o installer.sh
chmod +x installer.sh
sudo ./installer.sh

```

## Usage

```bash
sudo codefreak-manager
```

## Bulk Account Format

Create a CSV file like this:

```csv
username,password,days
user1,Pass123,30
user2,Pass456,0
user3,Test789,7
```

- `days = 0` means no expiry
- `days = 30` means the account expires in 30 days

## Notes

- This tool is for managing SSH accounts on your own VPS
- Run it as root
- Recommended for Debian/Ubuntu-based servers

## License

MIT
