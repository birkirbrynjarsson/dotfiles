# Mac setup and dotfiles
Tools and instructions to speed up and automate my setup and configurations after clean re-installation of MacOS.


## Requirements
Clean installation of MacOS, preferably _Mojave_ as that's what this setup has been tested on.


## Make your own
If you want to make your own setup based on this one I recommend the following steps:

- Fork the repository
- Edit the Brewfile
  - Some apps however are required for later steps (e.g. cask-fonts, font-meslo-nerd-font, iTerm2, nvm, python, rbenv)
- Edit settings.sh to your preference
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
Check out [creating a personal access token](https://help.github.com/articles/creating-a-personal-access-token-for-the-command-line/)

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


Install applications from **Brewfile**

```bash
cd ~/dotfiles
brew bundle
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


### Ruby

Install Ruby and `colorls` for colorful `ls` with icons. Aliased to `lc` and `lcc`

```bash
rbenv install 2.5.3
rbenv global 2.5.3
```

Restart your terminal before installing gems

```bash
gem install bundler
gem install colorls
```


## Node
Setup Node with nvm and install global packages

```bash
mkdir ~/.nvm
nvm install 8.12.0
nvm install 10.13.0
nvm alias default 8.12.0
nvm use default
npm install -g @angular/cli
npm install -g fb-messenger-cli
```


## Visual Studio Code settings
I sync plugins and settings to Visual Studio Code with the [*Settings sync*](https://marketplace.visualstudio.com/items?itemName=Shan.code-settings-sync) plugin. It requires a GitHub API Token with gist access. Check out the [configuration instructions](https://shanalikhan.github.io/2016/07/31/Visual-Studio-code-sync-setting-edit-manually.html)

Take a look at which plugins I use with:

```bash
curl https://gist.githubusercontent.com/birkirbrynjarsson/8b47741d950a86e46222eb8bfc293a9a/raw/4f7d7b697c724a4abdb36cceb75fb5ffa00944a2/extensions.json | grep name
```


## Dropbox Desktop sync

Sync your Desktop between workstations

```bash
ln -s ~/Desktop ~/Dropbox/
```


## Other preferences and private files

### Spotify CLI

The `spotify` cli requires configuration.
Add CLIENT_ID and CLIENT_SECRET to `~/.shpotify.cfg`, get this information by [creating an 'application'](https://developer.spotify.com/my-applications/#!/applications/create).

```bash
echo 'CLIENT_ID="urCl13nt1D"' > ~/.shpotify.cfg
echo 'CLIENT_SECRET="urCl13nt53cret"' >> ~/.shpotify.cfg
```

### Private branch or Mackup

I keep some application preferences in a [private branch](https://24ways.org/2013/keeping-parts-of-your-codebase-private-on-github/) of this repository and move them into `~/Library/Preferences/` after installing the apps. 
These files might contain Software Licenses or other private data.  
The `.shpotify.cfg`, *iStat Menus* settings and *Bartender.plist* are examples of such private files.

Another tool that might be worth taking a look at is [mackup](https://github.com/lra/mackup) which:
- Back ups your application settings in a safe directory (e.g. Dropbox)
- Syncs your application settings among all your workstations
- Restores your configuration on any fresh install in one command line

If you try out mackup, do create a `.mackup.cfg` and explicitly list the applications you want it used with. Mackup stores preferences in a cloud service (e.g. Dropbox) and symlinks everything from there, so be cautious and dont just run `mackup backup` unless you're sure.

### Syncing with mackup

Symlink the mackup config and custom configurations to ~/

```bash
cp ~/dotfiles/.mackup.cfg ~/
cp -R ~/dotfiles/.mackup ~/
```

Restore from mackup, given that the files have been synced with dropbox where the preference files are stored (`~/Dropbox/Mackup/`) after running `mackup backup` initially.

```bash
cd ~
mackup restore
```

## Post installation cleanup

Cleanup Brew installations

```bash
bubu
```

## Credits
Many thanks to the [dotfiles community](http://dotfiles.github.io/) and the creators/contributors there. My aliases, settings and more are sourced from many of the repositories which can be found there.
