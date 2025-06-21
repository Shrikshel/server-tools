<p align="center">
  <img src="https://raw.githubusercontent.com/Shrikshel/server-tools/main/assets/logo.png" width="200" alt="Server Tools Logo" style="border-radius: 10px;"/>
</p>

# Server Tools (`st`)

A modern, user-friendly command-line tool for managing headless Ubuntu servers, powered by [Bashly](https://bashly.dannyb.co/). The `st` CLI provides a suite of commands to simplify common server administration tasks, including package management, system info, disk and SMART stats, and more.

---

## Table of Contents

- [Installation & Uninstallation](#installation--uninstallation)
- [Features](#features)
- [Usage](#usage)
- [Command Helper](#command-helper)
  - [st docker](#st-docker)
  - [st rclone](#st-rclone)
  - [st restic](#st-restic)
  - [st ssh](#st-ssh)
  - [st config](#st-config)
  - [st system](#st-system)
- [Configuration](#configuration)
- [Requirements](#requirements)
- [Why use st?](#why-use-st)
- [License](#license)

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

```bash
st system update            # Update system packages
st system upgrade           # Upgrade system packages
st system update-upgrade    # Update & upgrade together
st system info              # Show system info
st system disk              # Show disk usage
st system smart             # Show SSD SMART stats
st system install docker    # Install Docker
st system uninstall btop    # Uninstall btop
```

---

## Command Helper

### st docker

Docker management commands for containers and Compose stacks:

| Description                        | Full Command                      | Alias         |
|------------------------------------|-----------------------------------|---------------|
| Docker Related Utilities           | `st docker`                       | `st dc`       |
| Docker Compose Related Utilities   | `st docker compose`               | `st dc c`     |
| Manage Docker Compose stacks       | `st docker compose manage-stacks` | `st dc c ms`  |
| Stop all running containers        | `st docker compose stop-all`      | `st dc c stop`|
| Start all stopped containers       | `st docker compose start-all`     | `st dc c start`|

### st rclone

Rclone utilities for syncing and managing cloud/local storage:

| Description                     | Full Command           | Alias      |
|---------------------------------|------------------------|------------|
| Rclone Related Utilities        | `st rclone`            | `st rc`    |
| Dry run of rclone sync          | `st rclone dry-sync`   | `st rc ds` |
| Perform rclone sync             | `st rclone sync`       | `st rc s`  |

### st restic

Restic backup and restore utilities:

| Description             | Full Command      | Alias    |
|-------------------------|-------------------|----------|
| Restic Related Utilities| `st restic`       | `st rs`  |

### st ssh

SSH key and connection management:

| Description            | Full Command       | Alias   |
|------------------------|--------------------|---------|
| SSH Related Utilities  | `st ssh`           | `st s`  |
| Generate SSH Key Pair  | `st ssh keygen`    | `st s k`|

### st config

Manage server tool configuration files:

| Description               | Full Command          | Alias      |
|---------------------------|-----------------------|------------|
| Config Tools              | `st config`           | `st conf`  |
| Show Config               | `st config show`      | `st conf s`|
| Edit Config               | `st config edit`      | `st conf e`|
| Verify Config             | `st config verify`    | `st conf v`|
| Source Config             | `st config source`    | `st conf so`|

### st system

System management utilities for packages, updates, and diagnostics:

| Description                     | Full Command                      | Alias         |
|----------------------------------|-----------------------------------|---------------|
| System Utilities                | `st system`                       | `st sys`      |
| Update System Packages          | `st system update`                | `st sys upd`  |
| Upgrade System Packages         | `st system upgrade`               | `st sys upg`  |
| Update & Upgrade Packages       | `st system update-upgrade`        | `st sys updu` |
| Install Packages                | `st system install`               | `st sys i`    |
| Uninstall Packages              | `st system uninstall`             | `st sys un`   |
| Install All Packages            | `st system install all`           |               |
| Uninstall All Packages          | `st system uninstall all`         |               |
| Install Docker                  | `st system install docker`        |               |
| Install btop                    | `st system install btop`          |               |
| Install eza                     | `st system install eza`           |               |
| Install neofetch                | `st system install neofetch`      |               |
| Install ncdu                    | `st system install ncdu`          |               |
| Install duf                     | `st system install duf`           |               |
| Install vnstat                  | `st system install vnstat`        |               |
| Install ufw                     | `st system install ufw`           |               |
| Install bat                     | `st system install bat`           |               |
| Install rclone                  | `st system install rclone`        |               |
| Install restic                  | `st system install restic`        |               |
| Install resticprofile           | `st system install resticprofile` |               |
| Uninstall the above             | `st system uninstall <package>`   |               |

---

## Configuration

`st` reads config from `$HOME/.config/.st.conf` (or the path in `ST_CONFIG_FILE`).

To edit the config:

```bash
nano $HOME/.config/.st.conf
# OR if you use a custom path
nano "$ST_CONFIG_FILE"
```

Example:

```bash
# ~/.config/.st.conf
NO_COLOR=1
```

---

## Requirements

- Ubuntu/Debian-based Linux
- Bash 4+
- `sudo` privileges

---

## Why use st?

- **Saves time**: Run common admin tasks with single commands  
- **Reduces errors**: Built-in, tested scripts  
- **Great for headless servers**: No GUI needed  
- **Easy to extend**: Modular Bashly CLI

---

## License

MIT License

---

_Server Tools (`st`) — Effortless server management for everyone!_