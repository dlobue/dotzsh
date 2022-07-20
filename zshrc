if [[ `uname` == "Darwin" ]]; then
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


path+=(
  '/usr/lib/go/site/bin'
  '/usr/share/git/remote-helpers'
  ${HOME}/.go/bin
  ${HOME}/.cargo/bin
  ${HOME}/.rvm/bin
  ${HOME}/.jenv/bin
  ${HOME}/.pyenv/bin
  ${HOME}/bin
  ${HOME}/.local/bin
  ${HOME}/.node_modules/bin
  ${HOME}/.npm/bin
  ${HOME}/node_modules/.bin
  ${HOME}/.krew/bin
  ./node_modules/.bin
  # TODO: cache the ruby gem dir location in a file somewhere and update it
  # every once in a while. use compinit cache in zsettings as example
  #$(ruby -r rubygems -e 'puts Gem.user_dir')/bin
  ${HOME}/.gem/ruby/2.6.0/bin
)
export PATH
fpath+=(
    ~/.zsh/autocomp.d
)


# this works. it allows me to override where specific plugins are kept so I can
# reuse my existing pyenv and asdf.
autoload -Uz add-zsh-hook zsh_directory_name_generic
function zdn_mywrapper() {
  local -A zdn_top=(
    asdf  ~/.asdf
    asdf-vm/asdf ~/.asdf
    pyenv ~/.pyenv
    pyenv/pyenv ~/.pyenv
  )
  zsh_directory_name_generic "$@"
}
add-zsh-hook zsh_directory_name zdn_mywrapper

# source ~/.zsh/zplug-init.zsh
# source ~/.zsh/zinit-init.zsh
source ~/.zsh/znap-init.zsh
# source ~/.zsh/heroku-autocomp.zsh
source ~/.zsh/zexports.zsh
# source ~/.zsh/zprompt.zsh
# znap prompt

# znap eval starship 'starship init zsh --print-full-init'
# znap prompt

znap source romkatv/powerlevel10k
# znap prompt romkatv/powerlevel10k


source ~/.zsh/zsettings.zsh
source ~/.zsh/zsh-vim-mode.plugin.zsh

source ~/.zsh/zfunctions.zsh
source ~/.zsh/zaliases.zsh

autoload -Uz zmv
alias zcp='zmv -C'
alias zln='zmv -L'


##
# Use `znap compdef` to install generated completion functions:
# znap compdef is deprecated
#
# znap compdef _kubectl 'kubectl completion  zsh'
# znap compdef _rustup  'rustup  completions zsh'
# znap compdef _cargo   'rustup  completions zsh cargo'
# These functions are regenerated automatically when any of the commands for
# which they generate completions is newer than the function cache.

# znap compdef _argocd 'argocd completion zsh'
# znap compdef _kustomize 'kustomize completion zsh'

# `znap source` finds the right file automatically, but you can also specify
# one (or more) explicitly:
zsh-defer znap source asdf-vm/asdf asdf.sh

# TODO defer this...?
fpath+=(
    ~[asdf-vm/asdf]/completions
    # ~[asdf-community/asdf-direnv]/completions
    ~[zsh-users/zsh-completions]/src
    ~[spwhitt/nix-zsh-completions]
    # ~/.zsh/autocomp.d
)
[ -s "~[asdf-vm/asdf]/plugins/java/set-java-home.zsh" ] && zsh-defer source ~[asdf-vm/asdf]/plugins/java/set-java-home.zsh


# Here, the first arg does not refer to a repo, but is simply used as an
# identifier for the cache file.
zsh-defer znap eval pyenv-init ${${:-=pyenv}:A}' init -'
zsh-defer znap eval pyenv-init-path ${${:-=pyenv}:A}' init --path'
zsh-defer znap eval pyenv-virtualenv-init ${${:-=pyenv}:A}' virtualenv-init -'

# Another way to automatically invalidate a cache is to simply include a
# variable as a comment. Here, the caches below will get invalidated whenever
# the Python version changes.
zsh-defer znap eval pip-completion    "pip completion --zsh             # $PYENV_VERSION"
# znap eval pipx-completion   "register-python-argcomplete pipx # $PYENV_VERSION"
# znap eval pipenv-completion "pipenv --completion              # $PYENV_VERSION"


# source ~/.zsh/envmanager.zsh

# rehash on USR1
TRAPUSR1() {
  rehash
}
function rehash-all() {
  pkill -USR1 zsh
}

TRAPUSR2() {
  znap restart
}
function restart-all() {
  pkill -USR2 zsh
}

typeset -g pretty_path="%(5~|%-1~/…/%3~|%4~)"

# original win title string: "\e]0;%~\a"
# function _update_win_title() { print -Pn "\e]0;%(5~|%-1~/…/%3~|%4~)\a" }
# function _update_win_title() { print -Pn "\e]0;$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)\a" }
function _update_win_title() {
  # typeset -g pretty_path="$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)"
  print -Pn "\e]0;${pretty_path}\a"
}
precmd_functions+=(_update_win_title)

# Enable run-help builtin for zsh help in the terminal
autoload -Uz run-help
(( ${+aliases[run-help]} )) && unalias run-help


# if type keychain &>/dev/null; then
#   keychain --agents ssh,gpg ~/.ssh/id_rsa -Q -q
# fi
# [ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
# [ -f $HOME/.keychain/$HOSTNAME-sh ] && \
#        . $HOME/.keychain/$HOSTNAME-sh
# [ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
#        . $HOME/.keychain/$HOSTNAME-sh-gpg

# -----------------

if [ -f ~/.zalias ]; then
    source ~/.zalias
fi
# put custom exports in ~/.zshenv

# heroku autocomplete setup
# HEROKU_AC_ZSH_SETUP_PATH=~/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

if [[ -d ~/.kubech ]]; then
    zsh-defer source "$HOME/.kubech/kubech"
fi

# zsh-defer znap fpath _kustomize 'kustomize completion zsh'
# zsh-defer znap fpath _argocd 'argocd completion zsh'
# zsh-defer znap fpath _helm 'helm completion zsh'
# znap fpath _jira 'jira --completion-script-zsh'

zsh-defer znap eval _awless 'awless completion zsh'

zsh-defer znap eval direnv ${${:-=direnv}:A}' hook zsh'

# if which direnv &>/dev/null; then
#     eval "$(direnv hook zsh)"
# fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
