#!/usr/bin/env bash
set -euo pipefail

echo "🔧 Bootstrapping macOS for Ansible..."

# 1) Ensure Xcode Command Line Tools (GUI prompt)
if ! xcode-select -p >/dev/null 2>&1; then
  echo "➡️  Installing Xcode Command Line Tools..."
  xcode-select --install || true
  echo "⚠️  Complete the GUI installer, then re-run this script."
  exit 0
fi

# 2) Install Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "🍺 Installing Homebrew..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Ensure brew is in PATH for this shell
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# 3) Install Ansible via Homebrew
if ! command -v ansible >/dev/null 2>&1; then
  echo "🤖 Installing Ansible..."
  brew install ansible
fi

# 4) Run your real playbook
echo "🚀 Running Ansible playbook..."
ansible-playbook -i "localhost," -c local playbook.yml --ask-vault-pass -K
