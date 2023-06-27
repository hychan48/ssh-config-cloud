#!/bin/bash
apt update
dpkg -l | grep -qw zsh || sudo apt-get install -y zsh
dpkg -l | grep -qw curl || sudo apt-get install -y curl
dpkg -l | grep -qw git || sudo apt-get install -y git

#oh my zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# y/n here ... todo

# zsh-suggestions plugin
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions)/' ~/.zshrc #fixm only works for base install
# validate
grep -q "plugins=.*zsh-autosuggestions" ~/.zshrc || echo "zsh-autosuggestions not found in ~/.zshrc"

:'
# reset ~/.zhrc
cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
grep plugin ~/.zshrc
source ~/.zshrc
grep "plugins=.*zsh-autosuggestions" ~/.zshrc
'