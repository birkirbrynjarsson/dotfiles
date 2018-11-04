# Mac setup
Tools and instructions to speed up and automate my setup after clean re-installation of MacOS

## Requirements
Clean installation of MacOS

## Usage
Install the **Xcode Command Line Tools**

```bash
xcode-select --install
```
Setup **git**
```bash
git config --global user.name "Birkir Brynjarsson"
git config --global user.email "*******@gmail.com"
```
Install **[Homebrew](https://brew.sh/)**
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Clone the repository and install from **Brewfile**
```bash
git clone https://github.com/birkirbrynjarsson/.setup
cd .setup
brew bundle
```
Set preferences for iTerm2
```bash
defaults write com.googlecode.iterm2.plist PrefsCustomFolder -string "~/.setup/iterm2"
defaults write com.googlecode.iterm2.plist LoadPrefsFromCustomFolder -bool true
```
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
Change default shell to **Zsh**
```bash
chsh -s /bin/zsh
```
Install **[Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)**
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
Install **powerlevel9** theme
```bash
git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
```
Install zsh-autosuggestions, zsh-completions and zsh-syntax-highlighting
```bash
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-completions ~/.oh-my-zsh/custom/plugins/zsh-completions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
```
