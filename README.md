# dotfiles

My personal macOS configuration and dotfiles, managed with Ansible.

## Overview

This repository automates the setup and configuration of a macOS system using Ansible. It manages:

- **Homebrew** - Package management and application installation
- **Git** - Global Git configuration and SSH keys
- **GPG** - GNU Privacy Guard setup and key management
- **SSH** - SSH configuration and key management
- **macOS Defaults** - System preferences and settings
- **Dotfiles** - Shell configuration files (.zshrc, .vimrc, etc.)

## Quick Start

```bash
git clone https://github.com/birkir/dotfiles.git
cd dotfiles
bash bootstrap.sh
```

The bootstrap script will:
1. Install Xcode Command Line Tools (if needed)
2. Install Homebrew
3. Install Ansible
4. Run the Ansible playbook

## Structure

```
roles/              # Ansible roles for configuration
home/               # Dotfiles for home directory
zsh/                # Zsh configuration files
playbook.yml        # Main Ansible playbook
bootstrap.sh        # Bootstrap script
```

## Tags

Run specific roles with tags:

```bash
ansible-playbook playbook.yml --tags homebrew -K
ansible-playbook playbook.yml --tags git
ansible-playbook playbook.yml --tags ssh --ask-vault-pass
```

Use the ansible flags `-K` to become sudo and `--ask-vault-pass` to decrypt the vaulted files used in some roles.

## Vault

Sensitive files are encrypted with Ansible Vault. You'll be prompted for the vault password during setup.

## Requirements

- macOS
- Internet connection
- Sudo access

## Make your own
If you want to make your own setup based on this one I recommend the following steps:

- Fork the repository
- Edit the Brewfile found in `roles/homebrew/files`
  - Some apps however are required for later steps
- Edit the git_config role with your own user and settings in mind
- Edit or remove the macos_defaults according to your own preferences
- Edit zsh exports, aliases and functions found in the `zsh/` folder
  - PS. before you start adding your own aliases I recommend running `alias` and looking at what is already there, a lot of stuff comes with the Oh-My-Zsh plugins.
- Remove or update the ssh and gnupg roles with your own keys
- Remove any other .vault file and the task using it. This is encrypted data which is unusable without the password.

## Installation steps on a brand new MacOS setup

### 1. Install the **Xcode Command Line Tools**
```bash
xcode-select --install
```

### 2. Clone/download the repository
Clone the repository and hide it in Finder with `chflags`

```bash
cd ~
git clone https://github.com/birkirbrynjarsson/dotfiles
chflags hidden dotfiles
cd ~/dotfiles
```

### 3. Run bootstrap.sh
```bash
chmod +x bootstrap.sh
./bootstrap.sh
```

### Caveats

If you get the error 'compaudit insecure directories', then run the following:
```bash
compaudit | xargs chmod g-w
compaudit | xargs chmod o-w
```

## Additional steps/information

### SSH keys
If the public **SSH-key** has been added to [GitHub](https://github.com/settings/ssh), the connection can be tested

```bash
ssh -T git@github.com
```

### Ruby and Gems

Install latest Ruby version and `colorls` for colorful `ls` with icons. Aliased to `lc` and `lcc`

```bash
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)
```

Restart your terminal before installing gems

```bash
gem install colorls
```

### Node
Setup Node with nvm

```bash
mkdir ~/.nvm
nvm install --lts
```

### Python
With `pyenv` installed, get the latest version of python

```bash
PYTHON_LATEST=$(pyenv install --list | sed 's/^  //' | grep '^\d' | grep --invert-match 'dev\|a\|b' | tail -1)
PYTHON_CONFIGURE_OPTS="--enable-framework"
pyenv install $PYTHON_LATEST
pyenv global $PYTHON_LATEST
pip install --upgrade pip
```

## Credits
Thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators/contributors there. Many of the aliases, settings etc. are borrowed from the repositories found there.