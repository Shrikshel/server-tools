# Server Tools (st)

A modern, user-friendly command-line tool for managing headless Ubuntu servers, powered by [Bashly](https://bashly.dannyb.co/). The `st` CLI provides a suite of commands to simplify common server administration tasks, including package management, system info, disk and SMART stats, and more.

---

## Installation & Uninstallation

To install `st` and all supporting scripts, run:

```bash
curl -sL https://raw.githubusercontent.com/Shrikshel/server-tools/main/scripts/install.sh | bash
```

To uninstall:

```bash
curl -sL https://raw.githubusercontent.com/Shrikshel/server-tools/main/scripts/uninstall.sh | bash
```

---

## Features

- **Easy system updates and upgrades**
- **Quick install/uninstall for popular utilities** (Docker, btop, eza, neofetch, ncdu, duf, vnstat, ufw)
- **Colorful, readable output** for all commands
- **System information and health checks**
- **Disk usage and SMART status reports**
- **Modular and extensible command structure**

---

## Usage

After installation, use the `st` command:

```bash
st [COMMAND] [SUBCOMMAND] [OPTIONS]
```

### Example Commands

- Update system packages:
  ```bash
  st system update
  ```
- Upgrade system packages:
  ```bash
  st system upgrade
  ```
- Update & upgrade together:
  ```bash
  st system update-upgrade
  ```
- Show system info:
  ```bash
  st system info
  ```
- Show disk usage:
  ```bash
  st system disk
  ```
- Show SSD SMART stats:
  ```bash
  st system smart
  ```
- Install a package (e.g., Docker):
  ```bash
  st system install docker
  ```
- Uninstall a package (e.g., btop):
  ```bash
  st system uninstall btop
  ```

---

## Command Aliases

| Alias         | Full Command                        | Description                        |
|---------------|-------------------------------------|------------------------------------|
| st dc         | st docker                          | Docker Related Utilities           |
| st dc c       | st docker compose                  | Docker Compose Related Utilities   |
| st dc c ms    | st docker compose manage-stacks    | Manage Docker Compose stacks       |
| st dc c stop  | st docker compose stop-all         | Stop all running Docker containers |
| st dc c start | st docker compose start-all        | Start all stopped Docker containers|
| st rc         | st rclone                          | Rclone Related Utilities           |
| st rc ds      | st rclone dry-sync                 | Perform a dry run of rclone sync   |
| st rc s       | st rclone sync                     | Perform rclone sync                |
| st rs         | st restic                          | Restic Related Utilities           |
| st s          | st ssh                             | SSH Related Utilities              |
| st s k        | st ssh keygen                      | Generate SSH Key Pair              |
| st conf       | st config                          | Configs Related to Server Tools    |
| st conf s     | st config show                     | System Configs                     |
| st conf e     | st config edit                     | Edit System Configs                |
| st conf v     | st config verify                   | Verify System Configs              |
| st conf so    | st config source                   | Source Configs                     |
| st sys        | st system                          | System Related Utilities           |
| st sys upd    | st system update                   | Update System Packages             |
| st sys upg    | st system upgrade                  | Upgrade System Packages            |
| st sys updu   | st system update-upgrade           | Update & Upgrade System Packages   |
| st sys i      | st system install                  | Install Packages                   |
| st sys un     | st system uninstall                | Uninstall Packages                 |
| st sys i all  | st system install all              | Install all packages               |
| st sys i docker | st system install docker         | Install Docker                     |
| st sys i btop | st system install btop             | Install btop                       |
| st sys i eza  | st system install eza              | Install eza                        |
| st sys i neofetch | st system install neofetch     | Install neofetch                   |
| st sys i ncdu | st system install ncdu             | Install ncdu                       |
| st sys i duf  | st system install duf              | Install duf                        |
| st sys i vnstat | st system install vnstat         | Install vnstat                     |
| st sys i ufw  | st system install ufw              | Install ufw                        |
| st sys i bat  | st system install bat              | Install bat                        |
| st sys i rclone | st system install rclone         | Install rclone                     |
| st sys i restic | st system install restic         | Install restic                     |
| st sys i resticprofile | st system install resticprofile | Install restic profile      |
| st sys un all | st system uninstall all            | Uninstall all packages             |
| st sys un docker | st system uninstall docker      | Uninstall Docker                   |
| st sys un btop | st system uninstall btop          | Uninstall btop                     |
| st sys un eza | st system uninstall eza            | Uninstall eza                      |
| st sys un neofetch | st system uninstall neofetch  | Uninstall neofetch                 |
| st sys un ncdu | st system uninstall ncdu          | Uninstall ncdu                     |
| st sys un duf | st system uninstall duf            | Uninstall duf                      |
| st sys un vnstat | st system uninstall vnstat      | Uninstall vnstat                   |
| st sys un ufw | st system uninstall ufw            | Uninstall ufw                      |
| st sys un bat | st system uninstall bat            | Uninstall bat                      |
| st sys un rclone | st system uninstall rclone      | Uninstall rclone                   |
| st sys un restic | st system uninstall restic      | Uninstall restic                   |
| st sys un resticprofile | st system uninstall resticprofile | Uninstall restic profile   |

---

## Configuration

`st` can be configured via a config file. By default, it looks for `$HOME/.config/.st.conf`. You can override this by setting the `ST_CONFIG_FILE` environment variable.

To edit the config file with nano:

```bash
nano $HOME/.config/.st.conf
```

Or, if you use a custom config location:

```bash
nano "$ST_CONFIG_FILE"
```

Example config:
```bash
# $HOME/.config/.st.conf
NO_COLOR=1  # Disable colored output
```

---

## Requirements

- Ubuntu (or other Debian-based Linux)
- Bash 4+
- `sudo` privileges for package management

---

## Why use st?

- **Saves time**: One command for many routine server tasks
- **Reduces errors**: Consistent, tested scripts
- **Great for headless servers**: No GUI required
- **Easy to extend**: Add your own commands via Bashly

---

## License

MIT License

---

*Server Tools (st) — Effortless server management for everyone!*

