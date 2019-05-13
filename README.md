# Mac setup and dotfiles
Tools and instructions to speed up and automate my setup and configurations after clean re-installation of MacOS.


## Requirements
Clean installation of MacOS, preferably _Mojave_ as that's what this setup has been tested on.


## Make your own
If you want to make your own setup based on this one I recommend the following steps:

- Fork the repository
- Edit the Brewfile
  - Some apps however are required for later steps (e.g. cask-fonts, font-meslo-nerd-font, iTerm2, nvm, python, rbenv)
- Edit settings.sh to suit your own preferences
- Edit mixin/aliases
  - PS. before you start adding your own aliases I recommend running `alias` and looking at what is already there, a lot of stuff comes with the Oh-My-Zsh plugins.
- Follow the manual setup guide


# Manual Setup
~~Unfortunately~~ it's a manual process, there's no single script that automates everything.  
However that's all cool as I enjoy going through the steps as well as maintaining this documentation.

Install the **Xcode Command Line Tools**

```bash
xcode-select --install
```

## Configure Git

```bash
git config --global user.name "Birkir Brynjarsson"  
git config --global user.email "*******@gmail.com"  
git config --global github.user birkirbrynjarsson
git config --global core.excludesfile ~/.gitignore
echo .DS_Store >> ~/.gitignore
```
Other configurations ~~I specify~~

```bash
git config --global github.token your_token_here
git config --global core.editor "code -w"
git config --global color.ui true
```

## Clone the repository
Clone the repository and hide it in Finder with `chflags`

```bash
cd ~
git clone https://github.com/birkirbrynjarsson/dotfiles
chflags hidden dotfiles
cd ~/dotfiles
```


## Install Applications

Install [**Homebrew**](https://brew.sh/)

```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```


Install applications from **Brewfile** and optionally a secondary file, `Brewfile2`

```bash
cd ~/dotfiles
brew bundle
brew bundle --file=Brewfile2
```

## SSH keys

With **1password** installed I get my **SSH-keys** from saved documents and move to `~/.ssh` and make sure permissions are correct

```bash
chmod 600 ~/.ssh/id_rsa
chmod 600 ~/.ssh/id_rsa.pub
chmod 700 ~/.ssh
```

If the public **SSH-key** has been added to [GitHub](https://github.com/settings/ssh), the connection can be tested

```bash
ssh -T git@github.com
```

## MacOS system preferences

Run `settings.sh` to apply custom preferences for Finder, Menu bar, Dock etc.

```bash
cd ~/dotfiles
chmod +x settings.sh
./settings.sh
```


## Make the shell awesome with iTerm2, Zsh & Oh-My-Zsh

![iTerm2 Screenshot](https://i.imgur.com/kgrwG9q.png "iTerm2 after customization")

Set preferences for iTerm2

```bash
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/dotfiles/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```

Install **[Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)**

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```

Install [**Powerlevel9**](https://github.com/bhilburn/powerlevel9k) theme

```bash
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```

Install custom zsh-plugins

[zsh-**autosuggestions**](https://github.com/zsh-users/zsh-autosuggestions), [zsh-**completions**](https://github.com/zsh-users/zsh-completions), [zsh-**history-substring-search**](https://github.com/zsh-users/zsh-history-substring-search) and [zsh-**syntax-highlighting**](https://github.com/zsh-users/zsh-syntax-highlighting)

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ${ZSH_CUSTOM}/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-history-substring-search ${ZSH_CUSTOM}/plugins/zsh-history-substring-search
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
```

### Zsh Profile

Source the ZSH profile (optionally restart Terminal/iTerm2 after creating the symlink)

```bash
rm ~/.zshrc
ln -s ~/dotfiles/.zshrc ~/
source ~/.zshrc
```

Install **Pygments** for colorized `cat` with `ccat` from the [_colorize_](https://github.com/robbyrussell/oh-my-zsh/tree/master/plugins/colorize) plugin.

```bash
pip3 install pygments
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
gem install bundler
gem install jekyll
```


## Node
Setup Node with nvm

```bash
mkdir ~/.nvm
nvm ls
nvm install lts/carbon
nvm install lts/dubnium
nvm alias default lts/carbon
nvm use default
```

Install global packages from `npmfile`

```bash
xargs -L1 npm i -g < ~/dotfiles/npmfile
```


## Python

```bash
pip3 install pyinstaller
```


## Visual Studio Code settings
I sync plugins and settings to Visual Studio Code with the [*Settings sync*](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) plugin. It requires a GitHub API Token with gist access. Check out the [configuration instructions](https://shanalikhan.github.io/2016/07/31/Visual-Studio-code-sync-setting-edit-manually.html). I store my GitHub API Token in a secure note with 1password.

My currently configured plugins can be found with:

```bash
curl -s https://api.github.com/gists/8b47741d950a86e46222eb8bfc293a9a \
| jq '.files."extensions.json".raw_url' \
| tr -d \" \
| xargs curl -s \
| grep name
```


## Dropbox Desktop sync

Sync your Desktop between workstations, further instructions [here](https://www.imore.com/how-sync-your-documents-desktop-and-any-other-folder-dropbox)

```bash
ln -s ~/Desktop ~/Dropbox/
```


## Private Config files

I keep some config files, shell aliases and application preferences in a [private branch](https://24ways.org/2013/keeping-parts-of-your-codebase-private-on-github/) of this repository and copy them into their designated destination after installing the apps. 
These files might contain Software Licenses or other private data.

### Spotify CLI

The `spotify` cli requires configuration.
Add CLIENT_ID and CLIENT_SECRET to `~/.shpotify.cfg`, get this information by [creating an 'application'](https://developer.spotify.com/my-applications/#!/applications/create).

```bash
echo 'CLIENT_ID="urCl13nt1D"' > ~/.shpotify.cfg
echo 'CLIENT_SECRET="urCl13nt53cret"' >> ~/.shpotify.cfg
```

## Post installation cleanup

Cleanup and update Brew installations (Run this command regularly to update software)

```bash
bubu
```

## Credits
Thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators/contributors there. Many of the aliases, settings etc. are borrowed from the repositories found there.
