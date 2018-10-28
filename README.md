# Mac setup
Tools to automate my setup after clean re-installation of MacOS

## Requirements
Clean installation of MacOS

## Usage
Install the Xcode Command Line Tools

```bash
xcode-select --install
```
Install [Homebrew](https://brew.sh/)
```bash
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
```
Clone the repository and install from Brewfile
```bash
git clone https://github.com/birkirbrynjarsson/.setup
cd .setup
brew bundle
```
Change default shell to Zsh
```bash
chsh -s /bin/zsh
```
Install [Oh-My-Zsh](https://github.com/robbyrussell/oh-my-zsh)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
```
