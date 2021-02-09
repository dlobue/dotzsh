
# Check if zplug is installed
# if [[ ! -d ~/.zplug ]]; then
#     git clone https://github.com/zplug/zplug ~/.zplug
#     source ~/.zplug/init.zsh && zplug update --self
# fi


# source ~/.zsh/zsettings.zsh
source ~/.zplug/init.zsh

# -----------------
# zplug manages itself
# zplug 'zplug/zplug', hook-build:'zplug --self-manage'

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

# source ~/.zsh/heroku-autocomp.zsh
source ~/.zsh/zsettings.zsh
source ~/.zsh/zsh-vim-mode.plugin.zsh
source ~/.zsh/zprompt.zsh
source ~/.zsh/zfunctions.zsh
source ~/.zsh/zaliases.zsh
source ~/.zsh/zexports.zsh
source ~/.zsh/envmanager.zsh

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
  ./node_modules/.bin
  # TODO: cache the ruby gem dir location in a file somewhere and update it
  # every once in a while. use compinit cache in zsettings as example
  #$(ruby -r rubygems -e 'puts Gem.user_dir')/bin
  /root/.gem/ruby/2.7.0/bin
)
export PATH

# rehash on USR1
TRAPUSR1() {
  rehash
}

autoload -Uz add-zsh-hook
# add-zsh-hook precmd histdb-update-outcome
# histdb fix
# export HISTDB_TABULATE_CMD=(sed -e $'s/\x1f/\t/g')

# original win title string: "\e]0;%~\a"
add-zsh-hook precmd _update_win_title() { print -Pn "\e]0;%(5~|%-1~/…/%3~|%4~)\a" }

keychain --agents ssh,gpg ~/.ssh/id_rsa -Q -q
. ~/.keychain/`hostname`-sh

# -----------------

# eval "`pip completion --zsh`"
# pip zsh completion start
# function _pip_completion {
#   local words cword
#   read -Ac words
#   read -cn cword
#   reply=( $( COMP_WORDS="$words[*]" \
#              COMP_CWORD=$(( cword-1 )) \
#              PIP_AUTO_COMPLETE=1 $words[1] ) )
# }
# compctl -K _pip_completion pip
# pip zsh completion end

# heroku autocomplete setup
# HEROKU_AC_ZSH_SETUP_PATH=~/.cache/heroku/autocomplete/zsh_setup && test -f $HEROKU_AC_ZSH_SETUP_PATH && source $HEROKU_AC_ZSH_SETUP_PATH;

# autoload -U +X bashcompinit && bashcompinit
# complete -o nospace -C /root/bin/terraform terraform

eval "$(direnv hook zsh)"
