
function load-nvm {
    # if NVM_LOADED is unset
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
    if [ -z ${NVM_LOADED+z} ]; then
        load-nvm
    else
        unset -f nvm
    fi
    nvm "$@"
}

function load-rvm {
    # if RVM_LOADED is unset
    if [ -z ${RVM_LOADED+z} ]; then
        #unset -f rvm
        local rvm_script=${rvm_path}/scripts/rvm
        [ -s "$rvm_script" ] && . "$rvm_script"
        export RVM_LOADED=1
    fi
}

function rvm {
    if [ -z ${RVM_LOADED+z} ]; then
        load-rvm
    else
        unset -f rvm
    fi
    rvm "$@"
}

function load-jenv {
    # if JENV_LOADED is unset
    if [ -z ${JENV_LOADED+z} ]; then
        unset -f jenv
        eval "$(jenv init -)"
        export JENV_LOADED=1
    fi
}

function jenv {
    if [ -z ${JENV_LOADED+z} ]; then
        load-jenv
    else
        unset -f jenv
    fi
    jenv "$@"
}

function load-pyenv {
    # if PYENV_LOADED is unset
    if [ -z ${PYENV_LOADED+z} ]; then
        unset -f pyenv
        eval "$(pyenv init -)"
        eval "$(pyenv virtualenv-init -)"
        export PYENV_LOADED=1
    fi
}

function pyenv {
    if [ -z ${PYENV_LOADED+z} ]; then
        load-pyenv
    else
        unset -f pyenv
    fi
    pyenv "$@"
}
