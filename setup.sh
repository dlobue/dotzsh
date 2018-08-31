#!/usr/bin/sh

ln -s .zsh/zshrc ../.zshrc
curl -sL --proto-redir -all,https https://raw.githubusercontent.com/zplug/installer/master/installer.zsh | zsh
