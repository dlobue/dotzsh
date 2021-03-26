export ZPLUG_LOG_TRACE=false

# Check if zplug is installed
if [[ ! -d ~/.zplug ]]; then
    git clone git@github.com:zplug/zplug.git ~/.zplug
    source ~/.zplug/init.zsh && zplug update --self-manage
fi

source ~/.zplug/init.zsh

# -----------------
# zplug manages itself
zplug 'zplug/zplug', hook-build:'zplug --self-manage'

# https://github.com/zsh-users/zsh-completions
zplug 'zsh-users/zsh-completions'

# https://github.com/larkery/zsh-histdb
zplug "larkery/zsh-histdb"
# zplug "larkery/zsh-histdb", use:"sqlite-history.zsh"
# zplug "larkery/zsh-histdb", use:"{sqlite-history,histdb-interactive}.zsh"

# https://github.com/mafredri/zsh-async
zplug "mafredri/zsh-async", from:"github", use:"async.zsh", lazy:true

# https://github.com/lukechilds/zsh-better-npm-completion
# zplug "lukechilds/zsh-better-npm-completion", defer:2

# https://github.com/jonmosco/kube-ps1
zplug "jonmosco/kube-ps1", use:"kube-ps1.sh"

# -----------------

# Install plugins if there are plugins that have not been installed
if ! zplug check --verbose; then
    printf "Install? [y/N]: "
    if read -q; then
        echo; zplug install
    fi
fi

# Then, source plugins and add commands to $PATH
zplug load --verbose
