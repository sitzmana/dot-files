# Dotfiles Repository
my dotfiles

This repository contains a collection of **dotfiles** and installation scripts to bootstrap your development environment across **macOS**, **Linux**, and **Windows**. It uses **Dotbot** to manage symlinks and provides a unified `install.sh` that handles both system-level dependencies and personal configuration.

---

## Quick Start

1. **Clone** the repo and init submodules:

   ```bash
   git clone https://github.com/yourusername/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   git submodule update --init --recursive
   ```

2. **Run** the installer:

   ```bash
   ./install.sh
   ```

   - On **macOS**, this installs Homebrew (if needed), core CLI tools, casks, Nerd Font, Oh-My-Zsh, Starship, vim-plug for Vim/Neovim, and more.
   - On **Linux**, it uses `apt` or `yum` to install packages, sets up fonts, starship, vim-plug, etc.
   - On **Windows**, run `install/windows.ps1` in an elevated PowerShell to install via Winget and symlink profiles.

3. **Enjoy** a consistent shell, editor, prompt, and Git setup across all machines.

---

## Repository Structure

```text
.dotfiles/
├── install.sh             # Unified bootstrap script (macOS & Linux)
├── install.conf.yaml      # Dotbot configuration (symlinks & setup commands)
├── .dotbot/               # Dotbot submodule
├── zsh/                   # Zsh configuration
│   └── .zshrc
├── bash/                  # Bash configuration
│   └── .bashrc
├── vim/                   # Vim configuration
│   └── .vimrc
├── nvim/                  # Neovim configuration
│   └── init.vim
├── starship/              # Starship prompt configuration
│   └── starship.toml
├── powershell/            # PowerShell profile
│   └── Microsoft.PowerShell_profile.ps1
├── git/                   # Git configuration
│   ├── .gitconfig
│   ├── .gitignore_global
│   └── .gitmessage.txt    # Commit-message template
└── install/               # Legacy installers (optional)
    ├── macos.sh
    ├── linux.sh
    └── windows.ps1
```

---

## Supported Configurations

- **Shells**: Zsh (Oh-My-Zsh + plugins + zoxide + fzf), Bash, PowerShell (PSReadLine, posh-git, Terminal-Icons, PSFzf)
- **Prompts**: [Starship](https://starship.rs/)
- **Editors**: Vim & Neovim (vim-plug, NerdTree, fzf.vim, vim-gitgutter, vim-fugitive, etc.)
- **Terminal Fonts**: Hack Nerd Font (via Homebrew, apt/yum, or Winget)
- **CLI Tools**: git, fzf, jq, qrencode, bat, eza, zoxide, broot, nvm, Docker, Docker Compose, and more
- **Git**: Global `.gitconfig`, `.gitignore_global`, commit-message template

---

## Installation Details

- **macOS**: handled by Homebrew & casks. Legacy installer in `install/macos.sh`.
- **Linux**: supports Debian/Ubuntu (`apt`) and RHEL/CentOS (`yum`). Legacy installer in `install/linux.sh`.
- **Windows**: uses Winget and PowerShell. Installer located at `install/windows.ps1`.

> The unified `install.sh` calls the appropriate sections automatically.

---

## Customization

## Optional Workflows

This repository provides additional _optional_ workflows in the `workflows/` directory. Each workflow includes a manifest (e.g., Brewfile or package list), an `install.sh` installer script, and a `dotbot.conf.yaml` for symlinks and setup.

Examples of available workflows include:
- Python (`workflows/python/dotbot.conf.yaml`)
- Rust (`workflows/rust/dotbot.conf.yaml`)
- Ruby (`workflows/ruby/dotbot.conf.yaml`)
- Go (`workflows/go/dotbot.conf.yaml`)
- C/C++ (`workflows/cc/dotbot.conf.yaml`)
- JavaScript (`workflows/javascript/dotbot.conf.yaml`)
- .NET/C# (`workflows/dotnet/dotbot.conf.yaml`)
- Kubernetes (`workflows/kubernetes/dotbot.conf.yaml`)
- AWS (`workflows/cloud/aws/dotbot.conf.yaml`)
- Azure (`workflows/cloud/azure/dotbot.conf.yaml`)
- GCP (`workflows/cloud/gcp/dotbot.conf.yaml`)
- Terraform (`workflows/cloud/terraform/dotbot.conf.yaml`)
- SSH (`workflows/ssh/dotbot.conf.yaml`)
- GPG (`workflows/gpg/dotbot.conf.yaml`)

To enable a workflow, add its path under the `- include:` section of your top-level `install.conf.yaml`. For example:

```yaml
- include:
    workflows/python/dotbot.conf.yaml
    workflows/rust/dotbot.conf.yaml
    workflows/cloud/aws/dotbot.conf.yaml
```

Comment out or remove entries to disable specific workflows.

- **Modify** any file under its folder (e.g. `zsh/.zshrc`, `nvim/init.vim`).
- **Re-run** `./install.sh` to update symlinks and re-apply setup commands.
- **Add** new config files by updating `install.conf.yaml` and placing your dotfile in the repo.

