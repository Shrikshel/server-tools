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

## Command Helper

### st docker

Docker management commands for containers and Compose stacks. Use `st docker` for all Docker-related operations, including starting, stopping, and managing stacks.

| Description                        | Full Command                      | Alias   |
|------------------------------------|-----------------------------------|---------|
| Docker Related Utilities           | st docker                         | st dc   |
| Docker Compose Related Utilities   | st docker compose                 | st dc c |
| Manage Docker Compose stacks       | st docker compose manage-stacks   | st dc c ms |
| Stop all running Docker containers | st docker compose stop-all        | st dc c stop |
| Start all stopped Docker containers| st docker compose start-all       | st dc c start |

### st rclone

Rclone utilities for syncing and managing files across cloud and local storage. Use `st rclone` for all rclone operations.

| Description                        | Full Command                      | Alias   |
|------------------------------------|-----------------------------------|---------|
| Rclone Related Utilities           | st rclone                         | st rc   |
| Perform a dry run of rclone sync   | st rclone dry-sync                | st rc ds|
| Perform rclone sync                | st rclone sync                    | st rc s |

### st restic

Restic backup and restore utilities. Use `st restic` for backup management and restoration tasks.

| Description                        | Full Command                      | Alias   |
|------------------------------------|-----------------------------------|---------|
| Restic Related Utilities           | st restic                         | st rs   |

### st ssh

SSH key and connection management. Use `st ssh` to generate keys and manage SSH-related tasks.

| Description                        | Full Command                      | Alias   |
|------------------------------------|-----------------------------------|---------|
| SSH Related Utilities              | st ssh                            | st s    |
| Generate SSH Key Pair              | st ssh keygen                     | st s k  |

### st config

Configuration management for server tools. Use `st config` to view, edit, verify, or source configuration files.

| Description                        | Full Command                      | Alias   |
|------------------------------------|-----------------------------------|---------|
| Configs Related to Server Tools    | st config                         | st conf |
| System Configs                     | st config show                    | st conf s |
| Edit System Configs                | st config edit                    | st conf e |
| Verify System Configs              | st config verify                  | st conf v |
| Source Configs                     | st config source                  | st conf so |

### st system

System management utilities for updates, upgrades, package installation, and more. Use `st system` for all system-level operations.

| Description                        | Full Command                      | Alias   |
|------------------------------------|-----------------------------------|---------|
| System Related Utilities           | st system                         | st sys  |
| Update System Packages             | st system update                  | st sys upd |
| Upgrade System Packages            | st system upgrade                 | st sys upg |
| Update & Upgrade System Packages   | st system update-upgrade          | st sys updu |
| Install Packages                   | st system install                 | st sys i |
| Uninstall Packages                 | st system uninstall               | st sys un |
| Install all packages               | st system install all             | st sys i all |
| Install Docker                     | st system install docker          | st sys i docker |
| Install btop                       | st system install btop            | st sys i btop |
| Install eza                        | st system install eza             | st sys i eza |
| Install neofetch                   | st system install neofetch        | st sys i neofetch |
| Install ncdu                       | st system install ncdu            | st sys i ncdu |
| Install duf                        | st system install duf             | st sys i duf |
| Install vnstat                     | st system install vnstat          | st sys i vnstat |
| Install ufw                        | st system install ufw             | st sys i ufw |
| Install bat                        | st system install bat             | st sys i bat |
| Install rclone                     | st system install rclone          | st sys i rclone |
| Install restic                     | st system install restic          | st sys i restic |
| Install restic profile             | st system install resticprofile   | st sys i resticprofile |
| Uninstall all packages             | st system uninstall all           | st sys un all |
| Uninstall Docker                   | st system uninstall docker        | st sys un docker |
| Uninstall btop                     | st system uninstall btop          | st sys un btop |
| Uninstall eza                      | st system uninstall eza           | st sys un eza |
| Uninstall neofetch                 | st system uninstall neofetch      | st sys un neofetch |
| Uninstall ncdu                     | st system uninstall ncdu          | st sys un ncdu |
| Uninstall duf                      | st system uninstall duf           | st sys un duf |
| Uninstall vnstat                   | st system uninstall vnstat        | st sys un vnstat |
| Uninstall ufw                      | st system uninstall ufw           | st sys un ufw |
| Uninstall bat                      | st system uninstall bat           | st sys un bat |
| Uninstall rclone                   | st system uninstall rclone        | st sys un rclone |
| Uninstall restic                   | st system uninstall restic        | st sys un restic |
| Uninstall restic profile           | st system uninstall resticprofile | st sys un resticprofile |

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

