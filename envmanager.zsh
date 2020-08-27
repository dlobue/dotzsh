
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

function load-asdf {
    # if ASDF_LOADED is unset
    if [ -z ${ASDF_LOADED+z} ]; then
        unset -f asdf
        local asdf_script=${HOME}/.asdf/asdf.sh
        [ -s "$asdf_script" ] && . "$asdf_script"
        . ~/.asdf/plugins/java/set-java-home.zsh
        export ASDF_LOADED=1
    fi
}

function asdf {
    if [ -z ${ASDF_LOADED+z} ]; then
        load-asdf
    else
        unset -f asdf
    fi
    asdf "$@"
}

function load-sdkman {
    # if SDKMAN_LOADED is unset
    if [ -z ${SDKMAN_LOADED+z} ]; then
        unset -f sdk
        source "$HOME/.sdkman/bin/sdkman-init.sh"
        export SDKMAN_LOADED=1
    fi
}

function sdk {
    if [ -z ${SDKMAN_LOADED+z} ]; then
        load-sdkman
    else
        unset -f sdk
    fi
    sdk "$@"
}
