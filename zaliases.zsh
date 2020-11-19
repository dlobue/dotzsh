alias grep="grep -I --no-messages --exclude='*.min.js' --color=auto"
alias grpe=grep
alias pgrpe="pgrep"
alias ls="ls --color=auto -N"
alias beep='echo -en "\007"'
alias vim-noop='vim -u /dev/null --noplugin'
alias ssh='TERM=xterm-256color \ssh'

alias enable_capslock="setxkbmap -option"
alias disable_capslock="setxkbmap -option ctrl:nocaps"

alias unlock_scalyr="pass show fscrypt/scalyr| fscrypt unlock ~/priv/scalyr --unlock-with=/root:6f3e5def14c5fc03 --quiet"

alias updatedb='sudo updatedb --prunefs tmpfs --prunepaths "/dev/ /lost+found/ /media/ /mnt/ /proc/ /sys/ /tmp/ /var/cache/ /var/db/ /var/log/ /var/lock/ /var/spool/ /var/mail/ /var/tmp/ /var/run/"'

alias update-mirrors="sudo reflector -l 8 --sort delay --sort rate --sort age --protocol http --protocol ftp --country United\ States --save /etc/pacman.d/mirrorlist"
alias update-pacman="update-mirrors && sudo pacman -Syy"
#function update-pacman {
#    update-mirrors && sudo pacman -Syy
#    # update-mirrors && sudo pacman -Syy ; ~/projects/scripts/xynes_workaround_script.sh
#    #sed -i '/UPDATE/{s/^#\+//}' /etc/pacman.d/mirrorlist && pacman -Syy; sed -i '/UPDATE/{s/^/#/}' /etc/pacman.d/mirrorlist;
#}


alias cgrep='cgrep --color --format="#f #n: #l"'
alias cgrpe=cgrep

# creates alias `curbranch` which can be used as an argument to git commands
alias -g curbranch=' `git symbolic-ref --short HEAD`'
alias -g curbr=curbranch


alias cljsbuild="lein trampoline cljsbuild $@"

alias k=kubectl
compdef k='kubectl'
