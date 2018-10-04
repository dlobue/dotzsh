
# source ~/.zsh/zsettings.zsh
source ~/.zplug/init.zsh

# -----------------

# zplug "jimeh/zsh-peco-history"

# https://github.com/softmoth/zsh-vim-mode
zplug "softmoth/zsh-vim-mode"

# https://github.com/supercrabtree/k
zplug "supercrabtree/k"

# https://github.com/mafredri/zsh-async
zplug "mafredri/zsh-async", from:"github", use:"async.zsh"

# https://github.com/mollifier/anyframe
zplug "mollifier/anyframe"

# -----------------

# https://github.com/caiogondim/bullet-train.zsh
# zplug "caiogondim/bullet-train.zsh", use:bullet-train.zsh-theme, defer:3 # defer until other plugins like oh-my-zsh is loaded

# BULLETTRAIN_PROMPT_ORDER defines order of prompt segments. Use zsh array syntax to specify your own order, e.g:
# BULLETTRAIN_PROMPT_ORDER=(
#   git
#   context
#   dir
#   time
# )

# https://github.com/geometry-zsh/geometry
# zplug "geometry-zsh/geometry"

# https://github.com/denysdovhan/spaceship-prompt
# zplug denysdovhan/spaceship-prompt, use:spaceship.zsh, from:github, as:theme

# https://github.com/stevelacy/cordial-zsh-theme
# zplug stevelacy/cordial-zsh-theme, use:cordial.zsh-theme, from:github, as:theme

# uhhhh
# https://github.com/channprj/dotfiles-macOS/blob/master/custom-zsh-theme/dpoggi-timestamp.zsh-theme

# https://github.com/Saleh7/igeek-zsh-theme
# zplug Saleh7/igeek-zsh-theme, use:igeek.zsh-theme, from:github, as:theme

# https://github.com/igormp/Imp
# zplug igormp/Imp, use:imp.zsh-theme, from:github, as:theme

# https://github.com/tylerreckart/hyperzsh
# zplug tylerreckart/hyperzsh, use:hyperzsh.zsh-theme, from:github, as:theme

# The prompt
# PROMPT='$(_user_host)$(_python_venv)%{$fg[cyan]%}%c $(git_prompt_info)%{$reset_color%}$(git_prompt_short_sha)%{$fg[magenta]%}$(_git_time_since_commit)$(git_prompt_status)${_return_status}➜ '

# Prompt with SHA
# PROMPT='$(_user_host)$(_python_venv)%{$fg[cyan]%}%c $(git_prompt_info)%{$reset_color%}$(git_prompt_short_sha)%{$fg[magenta]%}$(_git_time_since_commit)$(git_prompt_status)${_return_status}➜ '

# zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme, defer:3

PURE_CMD_MAX_EXEC_TIME=10
PURE_GIT_PULL=0
PURE_GIT_UNTRACKED_DIRTY=0


zplug cbrock/sugar-free, use:sugar-free.zsh-theme, from:github, as:theme, defer:3

# ------------

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose

source ~/.zsh/zsettings.zsh


export SSH_ASKPASS=/usr/bin/ksshaskpass
export PAGER=less
export LESS=FXRi
export EDITOR=vim

export LESSOPEN="|~/lesspipe.sh %s"

alias grep="grep -I --no-messages --exclude='*.min.js' --color=auto"
alias grpe=grep
alias pgrpe="pgrep"
alias ls="ls --color=auto -N"
alias beep='echo -en "\007"'
alias vim-noop='vim -u /dev/null --noplugin'

alias enable_capslock="setxkbmap -option"
alias disable_capslock="setxkbmap -option ctrl:nocaps"

alias updatedb='updatedb --prunefs tmpfs --prunepaths "/dev/ /lost+found/ /media/ /mnt/ /proc/ /sys/ /tmp/ /var/cache/ /var/db/ /var/log/ /var/lock/ /var/spool/ /var/mail/ /var/tmp/ /var/run/"'

alias update-mirrors="reflector -l 8 --sort delay --sort rate --sort age --protocol http --protocol ftp --country United\ States --save /etc/pacman.d/mirrorlist"
function update-pacman {
    #reflector -l 8 --sort delay --sort rate --sort age --protocol http --protocol ftp --country United\ States --save /etc/pacman.d/mirrorlist 
    update-mirrors && pacman -Syy
    # update-mirrors && pacman -Syy && ~/projects/scripts/xynes_workaround_script.sh
    #sed -i '/UPDATE/{s/^#\+//}' /etc/pacman.d/mirrorlist && pacman -Syy; sed -i '/UPDATE/{s/^/#/}' /etc/pacman.d/mirrorlist;
}


keychain --agents ssh,gpg ~/.ssh/id_rsa -Q -q
. ~/.keychain/`hostname`-sh


alias cgrep='cgrep --color --format="#f #n: #l"'
alias cgrpe=cgrep

export NVIM_TUI_ENABLE_TRUE_COLOR=1
export LEIN_ROOT=true
export BOOT_AS_ROOT=yes


export NOSEIPDB=' --ipdb --ipdb-failures'

export PGHOST='localhost'
export PGUSER='engine'

export GOPATH=${HOME}/.go:${HOME}/projects/go-reference
export rvm_ignore_gemrc_issues=1
export rvm_path="${HOME}/.rvm"
#export NODE_PATH=/usr/lib/jsctags:$NODE_PATH

alias cljsbuild="lein trampoline cljsbuild $@"


path+=(
  '/usr/lib/go/site/bin'
  '/usr/share/git/remote-helpers'
  ${HOME}/.go/bin
  ${HOME}/.rvm/bin
  ${HOME}/.jenv/bin
  ${HOME}/.pyenv/bin
  ${HOME}/bin
  ${HOME}/bin/mongobin
  ${HOME}/.local/bin
  ${HOME}/.node_modules/bin
  ${HOME}/node_modules/.bin
  ./node_modules/.bin
)
export PATH



function load-nvm {
    if [ -z ${NVM_LOADED+z} ]; then
        #unset -f nvm node npm
        unset -f nvm
        export NVM_DIR=~/.nvm
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        [ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
        export NVM_LOADED=1
    fi
}

function nvm {
    load-nvm
    nvm "$@"
}

function load-rvm {
    if [ -z ${RVM_LOADED+z} ]; then
        #unset -f rvm
        local rvm_script=${rvm_path}/scripts/rvm
        [ -s "$rvm_script" ] && . "$rvm_script"
        export RVM_LOADED=1
    fi
}

function rvm {
    load-rvm
    rvm "$@"
}

function load-jenv {
    if [ -z ${JENV_LOADED+z} ]; then
        unset -f jenv
        eval "$(jenv init -)"
        export JENV_LOADED=1
    fi
}

function jenv {
    load-jenv
    jenv "$@"
}

function load-pyenv {
    if [ -z ${PYENV_LOADED+z} ]; then
        unset -f pyenv
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        export PYENV_LOADED=1
    fi
}

function pyenv {
    load-pyenv
    pyenv "$@"
}

function load-aws {
    if [ -z ${AWS_LOADED+z} ]; then
        unset -f aws
        . aws_bash_completer
        export AWS_LOADED=1
    fi
}

function aws {
    load-aws
    aws "$@"
}





# autoload -U promptinit; promptinit

# optionally define some options

# prompt pure

