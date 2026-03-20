# Mac setup and dotfiles
Tools and instructions to automate and maintain my setup and configurations after clean re-installation of MacOS.

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


# Automation using Ansible
This dotfiles setup uses Ansible, so the process is automated. Just make `bootstrap.sh` executable and run it.

Install the **Xcode Command Line Tools**

```bash
xcode-select --install
```

## Clone/download the repository
Clone the repository and hide it in Finder with `chflags`

```bash
cd ~
git clone https://github.com/birkirbrynjarsson/dotfiles
chflags hidden dotfiles
cd ~/dotfiles
```

## Run bootstrap.sh
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


# Additional steps/information

## SSH keys
Private SSH keys are stored encrypted and installed with ansible.

If the public **SSH-key** has been added to [GitHub](https://github.com/settings/ssh), the connection can be tested

```bash
ssh -T git@github.com
```

## GPG keys, Github
GPG keys are encrypted with ansible-vault and installed with ansible. The use of GPG keys to verify the user is set in the git_config playbook.

## Ruby and Gems

Install latest Ruby version and `colorls` for colorful `ls` with icons. Aliased to `lc` and `lcc`

```bash
rbenv install $(rbenv install -l | grep -v - | tail -1)
rbenv global $(rbenv install -l | grep -v - | tail -1)
```

Restart your terminal before installing gems

```bash
gem install colorls
```


## Node
Setup Node with nvm

```bash
mkdir ~/.nvm
nvm install --lts
```


## Python
With `pyenv` installed, get the latest version of python

```bash
PYTHON_LATEST=$(pyenv install --list | sed 's/^  //' | grep '^\d' | grep --invert-match 'dev\|a\|b' | tail -1)
PYTHON_CONFIGURE_OPTS="--enable-framework"
pyenv install $PYTHON_LATEST
pyenv global $PYTHON_LATEST
pip install --upgrade pip
```


## openpyn - NordVPN cli

With wget, openvpn and python3 installed using pyenv, install [openpyn](https://github.com/jotyGill/openpyn-nordvpn)
```bash
pip install openpyn
sudo brew services start openvpn
sudo openpyn --init
```


## Private Config files

~~I keep some config files, shell aliases and application preferences in a [private branch]~~(https://24ways.org/2013/keeping-parts-of-your-codebase-private-on-github/) of this repository and copy them into their designated destination after installing the apps. 
These files might contain Software Licenses, network addresses and other private data.
Since March 2026 this has been moved to using ansible-vault.


## Other Software
Here's a list of other software that doesn't have a homebrew package
```
Adobe Lightroom
Adobe Photoshop
Canon EOS Utility
```

## Stay up to date

Run these commands regularly to stay up to date

```bash
# Brew upgrade, update and cleanup
bubu
# npm update
npmu
```

## Credits
Thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators/contributors there. Many of the aliases, settings etc. are borrowed from the repositories found there.
