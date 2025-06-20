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
- **Quick install/uninstall for popular utilities** (Docker, btop, eza, neofetch, ncdu, duf, vnstats, ufw)
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

## Configuration

`st` can be configured via a config file. By default, it looks for `~/.config/.bashly.conf`. You can override this by setting the `ST_CONFIG_FILE` environment variable.

Example config:
```bash
# ~/.config/.bashly.conf
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

