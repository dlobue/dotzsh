
# source ~/.zsh/zsettings.zsh
source ~/.zplug/init.zsh

# -----------------
# zplug manages itself
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# zplug "jimeh/zsh-peco-history"

# https://github.com/softmoth/zsh-vim-mode
# zplug "softmoth/zsh-vim-mode"

# https://github.com/larkery/zsh-histdb
zplug "larkery/zsh-histdb", use:"{sqlite-history,histdb-interactive}.zsh"

# https://github.com/supercrabtree/k
zplug "supercrabtree/k", lazy:true

# https://github.com/mafredri/zsh-async
zplug "mafredri/zsh-async", from:"github", use:"async.zsh", lazy:true

# https://github.com/mollifier/anyframe
zplug "mollifier/anyframe", lazy:true

# https://github.com/lukechilds/zsh-better-npm-completion
zplug "lukechilds/zsh-better-npm-completion", defer:2

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


# zplug cbrock/sugar-free, use:sugar-free.zsh-theme, from:github, as:theme, defer:3

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
source ~/.zsh/zsh-vim-mode.plugin.zsh
source ~/.zsh/zprompt.zsh

autoload -Uz add-zsh-hook
add-zsh-hook precmd histdb-update-outcome

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

alias updatedb='sudo updatedb --prunefs tmpfs --prunepaths "/dev/ /lost+found/ /media/ /mnt/ /proc/ /sys/ /tmp/ /var/cache/ /var/db/ /var/log/ /var/lock/ /var/spool/ /var/mail/ /var/tmp/ /var/run/"'

alias update-mirrors="sudo reflector -l 8 --sort delay --sort rate --sort age --protocol http --protocol ftp --country United\ States --save /etc/pacman.d/mirrorlist"
function update-pacman {
    update-mirrors && sudo pacman -Syy
    # update-mirrors && sudo pacman -Syy ; ~/projects/scripts/xynes_workaround_script.sh
    #sed -i '/UPDATE/{s/^#\+//}' /etc/pacman.d/mirrorlist && pacman -Syy; sed -i '/UPDATE/{s/^/#/}' /etc/pacman.d/mirrorlist;
}


keychain --agents ssh,gpg ~/.ssh/id_rsa -Q -q
. ~/.keychain/`hostname`-sh


alias cgrep='cgrep --color --format="#f #n: #l"'
alias cgrpe=cgrep

# creates alias `curbranch` which can be used as an argument to git commands
alias -g curbranch=' `git symbolic-ref --short HEAD`'
alias -g curbr=curbranch

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
  ${HOME}/.npm/bin
  ${HOME}/node_modules/.bin
  ./node_modules/.bin
)
export PATH


function ssh-clear {
    sed -i '/'$1'/d' ~/.ssh/known_hosts
}

function load-nvm {
    if [ -z ${NVM_LOADED+z} ]; then
        #unset -f nvm node npm
        unset -f nvm
        export NVM_DIR=~/.nvm
        [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
        #[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion"
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
        # . aws_bash_completer
        export AWS_LOADED=1
    fi
}

function aws {
    load-aws
    aws "$@"
}

function _prompt_yn {
    while true; do
        read "yn?$1 [y|n] "
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

function xselbuf {
    local stripnl=0;
    while true; do
        case "$1" in
            -n)
                shift
                stripnl=1;;
            *)
                break;;
        esac
    done
    if [ $stripnl -eq 1 ]; then
        exec tr -d "\n" | xsel ${@}
    else
        exec xsel ${@}
    fi
}

function vim-process-swap {
    local swapfile_first=0
    local noninteractive=0
    while true; do
        case "$1" in
            ""|-h|--help)
                echo "usage: $0 file [swapfile [recoverfile]]" >&2
                return 1;;
            -s)
                shift
                swapfile_first=1;;
            -n)
                shift
                noninteractive=1;;
            *)
                break;;
        esac
    done
    local realfile=`readlink -f "$1"`
    local path=`dirname "$realfile"`
    local realname=$(/usr/bin/basename "$realfile")
    if [ $swapfile_first -eq 1 ]; then
        local swapfile=$realfile
        realname=${realname:1:-4}
        realfile="${path}/${realname}"
    else
        local swapfile=${2:-"${path}/.${realname}.swp"}
    fi
    local recoverfile=${3:-"${path}/${realname}-recovered"}
    local lastresort=0
    for f in "$realfile" "$swapfile"; do
        if [ ! -f "$f" ]; then
            echo "File $f does not exist." >&2
            return 1
        elif /usr/bin/fuser "$f"; then
            echo "File $f in use by process." >&2
            return 1
        fi
    done
    if [ -f "$recoverfile" ]; then
        echo "Recover file $recoverfile already exists. Delete existing recover file first." >&2
        return 1
    fi
    /usr/bin/vim -u /dev/null --noplugin -r "$swapfile" -c ":wq $recoverfile"
    if /usr/bin/cmp -s "$realfile" "$recoverfile"; then
        /usr/bin/rm "$swapfile" "$recoverfile"
    elif [ "$realfile" -nt "$swapfile" ] && [ `/usr/bin/stat -c%s "$realfile"` -gt `/usr/bin/stat -c%s "$recoverfile"` ]; then
        echo "Swapfile is older than realfile, and recovered file is smaller than realfile"
        if [ $noninteractive -eq 0 ] && _prompt_yn "Delete recovered file and swapfile without doing diff?"; then
            /usr/bin/rm "$swapfile" "$recoverfile"
        else
            lastresort=1
        fi
    else
        lastresort=1
    fi

    if [[ "$lastresort" -ne 0 ]]; then
        if [ $noninteractive -eq 1 ]; then
            echo "user interaction required for file ${recoverfile} ${realfile} ${swapfile}"
            return 1
        else
            /usr/bin/rm "$swapfile"
            /usr/bin/vimdiff "$recoverfile" "$realfile"
            if _prompt_yn "Delete recovered file?"; then
                /usr/bin/rm "$recoverfile"
            fi
        fi
    fi
}


# eval "`pip completion --zsh`"
# pip zsh completion start
function _pip_completion {
  local words cword
  read -Ac words
  read -cn cword
  reply=( $( COMP_WORDS="$words[*]" \
             COMP_CWORD=$(( cword-1 )) \
             PIP_AUTO_COMPLETE=1 $words[1] ) )
}
compctl -K _pip_completion pip
# pip zsh completion end
