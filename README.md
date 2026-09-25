# Linux, CLI & WSL — Research Notes (Day 3)

**Internship task:** ApexaiQ Technologies Pvt. Ltd. — Software Development Intern
**Topic:** Research and understand Linux, the Command-Line Interface (CLI), and WSL (Windows Subsystem for Linux)

## Objective

Learn what Linux is, why it's used in development and industry, how the command line works, and how WSL lets Linux tools run on Windows — as groundwork for the development/automation work in this internship.

## Table of Contents

1. [What is Linux?](#1-what-is-linux)
2. [Why Use Linux?](#2-why-use-linux)
3. [Purpose of Linux](#3-purpose-of-linux)
4. [What is CLI?](#4-what-is-cli)
5. [Common Linux Commands](#5-common-linux-commands)
6. [Useful Linux Symbols](#6-useful-linux-symbols)
7. [What is WSL?](#7-what-is-wsl)
8. [Installing & Using WSL](#8-installing--using-wsl)
9. [Windows & Linux Paths in WSL](#9-windows--linux-paths-in-wsl)
10. [Putting It Together: Example Workflow](#10-putting-it-together-example-workflow)
11. [Key Takeaways](#11-key-takeaways)
12. [Sources](#12-sources)

---

## 1. What is Linux?

Linux is an **open-source operating system kernel**. A full Linux operating system pairs the kernel with utilities, libraries, a package manager, and applications — together called a **Linux distribution (distro)**: Ubuntu, Debian, Fedora, Linux Mint, Kali Linux, Arch Linux, etc.

Linux manages the computer's hardware and software: CPU, memory, files, users, processes, and network connections.

## 2. Why Use Linux?

- **Free and open source** — source code can be studied, modified, and redistributed
- **Stable** — runs for long periods with few restarts
- **Secure** — permissions, user separation, built-in security tooling
- **Customizable** — choice of desktop, tools, services, configuration
- **Efficient** — scales from servers down to low-resource devices
- **Developer-friendly** — ships with Python, Git, SSH, compilers, Bash, package managers
- **Dominant in servers/cloud** — most web servers, databases, containers, and cloud infrastructure run on Linux
- **Security tooling** — most cybersecurity distros (e.g. Kali Linux) are Linux-based

## 3. Purpose of Linux

Linux exists to run software and manage hardware. It lets users and applications:

1. Access files and storage
2. Run programs and background services
3. Manage memory and CPU usage
4. Connect to networks
5. Control users and permissions
6. Install and update software
7. Automate tasks via scripts
8. Host websites, APIs, databases, and applications

For a developer specifically, Linux is where you'd create virtual environments, install packages, run tests, use Git, and deploy applications.

## 4. What is CLI?

**CLI (Command-Line Interface)** is a text-based way to interact with a computer by typing commands instead of clicking through a GUI.

```bash
python --version
```

A CLI is made up of:

- **Terminal** — the window where commands are entered
- **Shell** — the program that interprets commands (e.g. **Bash**, short for "Bourne Again Shell")
- **Command** — an instruction such as `ls` or `mkdir`
- **Arguments/options** — extra flags that change a command's behavior

### CLI vs GUI

| CLI | GUI |
|---|---|
| Typed commands | Windows, buttons, menus |
| Fast for repeated tasks | Easier for beginners |
| Easy to automate with scripts | More visual |
| Common on servers | Common on desktop systems |
| Requires command knowledge | Requires less memorization |

## 5. Common Linux Commands

### Navigation & Files

| Command | Purpose | Example |
|---|---|---|
| `pwd` | Show current directory | `pwd` |
| `ls` | List files/folders | `ls -la` |
| `cd` | Change directory | `cd Documents` |
| `mkdir` | Create a directory | `mkdir project` |
| `touch` | Create an empty file | `touch app.py` |
| `cp` | Copy files/folders | `cp app.py backup.py` |
| `mv` | Move or rename | `mv old.py new.py` |
| `rm` | Delete files | `rm file.txt` |
| `rmdir` | Delete an empty directory | `rmdir test` |

> `rm -rf` deletes permanently — there's no recycle bin. Use with care.

### Reading & Searching

| Command | Purpose | Example |
|---|---|---|
| `cat` | Print file contents | `cat main.py` |
| `less` | Page through a long file | `less log.txt` |
| `head` | Show start of a file | `head file.txt` |
| `tail` | Show end of a file | `tail -f app.log` |
| `grep` | Search text | `grep "error" app.log` |
| `find` | Find files/folders | `find . -name "*.py"` |
| `which` | Locate a command | `which python` |

### System & Process

| Command | Purpose | Example |
|---|---|---|
| `clear` | Clear the terminal | `clear` |
| `history` | Show past commands | `history` |
| `whoami` | Show current user | `whoami` |
| `uname` | Show system info | `uname -a` |
| `df` | Show disk space | `df -h` |
| `du` | Show directory size | `du -sh .` |
| `top` | Live process viewer | `top` |
| `ps` | List processes | `ps aux` |
| `kill` | Stop a process | `kill 1234` |
| `man` | Open command docs | `man ls` |

### Permissions & Admin

| Command | Purpose | Example |
|---|---|---|
| `chmod` | Change permissions | `chmod +x script.sh` |
| `chown` | Change ownership | `sudo chown user file.txt` |
| `sudo` | Run with elevated privileges | `sudo apt update` |
| `passwd` | Change password | `passwd` |

> Use `sudo` only when necessary — it grants elevated privileges.

### Networking & Software

| Command | Purpose | Example |
|---|---|---|
| `ping` | Test connectivity | `ping example.com` |
| `curl` | Request/download data | `curl https://example.com` |
| `ssh` | Connect to a remote machine | `ssh user@server` |
| `ip` | Show network info | `ip addr` |
| `apt` | Manage software (Debian/Ubuntu) | `sudo apt install git` |
| `git` | Manage repositories | `git status` |
| `python` | Run Python | `python script.py` |

Typical update on Ubuntu/Debian:

```bash
sudo apt update
sudo apt upgrade
```

## 6. Useful Linux Symbols

| Symbol | Meaning | Example |
|---|---|---|
| `>` | Write output to a file (overwrite) | `command > output.txt` |
| `>>` | Append output to a file | `command >> output.txt` |
| `\|` | Pipe: send output of one command into the next | `ps aux \| grep python` |
| `&&` | Run the next command only if the first succeeds | `mkdir project && cd project` |

## 7. What is WSL?

**WSL (Windows Subsystem for Linux)** lets you run a Linux environment directly inside Windows — no virtual machine, no dual boot. It supports Bash and Linux CLI tools like `grep`, `sed`, and `awk`.

**WSL 2** uses a real Linux kernel, giving better compatibility than WSL 1.

With WSL you get Windows apps (VS Code, Chrome) *and* Linux tooling (Bash, Git, Python, `apt`) side by side.

## 8. Installing & Using WSL

Install (PowerShell, as Administrator):

```powershell
wsl --install
```

This installs WSL plus a default distro (commonly Ubuntu).

Open the default distro:

```powershell
wsl
```

Other useful commands:

```powershell
wsl --status              # WSL status
wsl --version              # Installed WSL version
wsl --list --verbose       # List distros + WSL version each uses
wsl --update                # Update WSL
wsl --shutdown              # Stop all running distros
wsl --install -d Ubuntu     # Install a specific distro
```

## 9. Windows & Linux Paths in WSL

Linux home directory inside WSL:

```bash
/home/your-username
```

Windows drives are mounted under `/mnt`:

```bash
/mnt/c
/mnt/d
```

Example — reaching the Windows Desktop from WSL:

```bash
cd /mnt/c/Users/YourName/Desktop
```

Open the current Linux folder in Windows Explorer:

```bash
explorer.exe .
```

For active development, it's usually faster to keep projects inside the Linux filesystem rather than under `/mnt`:

```bash
mkdir -p ~/projects
cd ~/projects
```

## 10. Putting It Together: Example Workflow

A simple Python setup inside WSL, combining everything above:

```bash
mkdir python-demo
cd python-demo

python3 -m venv .venv
source .venv/bin/activate

pip install pytest
touch test_example.py
pytest
```

- **Linux** — the operating environment
- **WSL** — runs that Linux environment inside Windows
- **Bash** — the shell interpreting the commands
- **CLI** — the text interface used to run them
- **Python / pytest** — the dev tools running on top

This exact workflow is automated in [`scripts/python_wsl_workflow.sh`](scripts/python_wsl_workflow.sh) — see below.

## 11. Key Takeaways

- Linux is the kernel; a distro is Linux + tools + package manager + apps
- The CLI (via a shell like Bash) is faster to automate than a GUI and is the default on servers
- A working command vocabulary — navigation, file ops, search, system/process, permissions, networking — covers most day-to-day tasks
- WSL bridges Windows and Linux, so development machines don't need dual boot or a full VM to use Linux tooling
- These fundamentals are the base for the automation/DevOps work expected later in the internship

## 12. Sources

- [GNU Bash Reference Manual](https://www.gnu.org/software/bash/manual/html_node/index.html)
- [Microsoft Learn — What is WSL](https://learn.microsoft.com/en-us/windows/wsl/about)
- [Microsoft Learn — Comparing WSL 1 and WSL 2](https://learn.microsoft.com/en-us/windows/wsl/compare-versions)
- [Microsoft Learn — Install WSL](https://learn.microsoft.com/en-us/windows/wsl/install)
- [Microsoft Learn — Basic WSL commands](https://learn.microsoft.com/en-us/windows/wsl/basic-commands)


