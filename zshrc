
if [[ `uname` == "Darwin" ]]; then
  export LC_ALL=en_US.UTF-8
  export LANG=en_US.UTF-8
fi


# source ~/.zsh/zplug-init.zsh
source ~/.zsh/zinit-init.zsh
# source ~/.zsh/heroku-autocomp.zsh
source ~/.zsh/zexports.zsh
source ~/.zsh/zsettings.zsh
source ~/.zsh/zsh-vim-mode.plugin.zsh
source ~/.zsh/zprompt.zsh
source ~/.zsh/zfunctions.zsh
source ~/.zsh/zaliases.zsh
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
  ${HOME}/.krew/bin
  ./node_modules/.bin
  # TODO: cache the ruby gem dir location in a file somewhere and update it
  # every once in a while. use compinit cache in zsettings as example
  #$(ruby -r rubygems -e 'puts Gem.user_dir')/bin
  ${HOME}/.gem/ruby/2.7.0/bin
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

if type keychain &>/dev/null; then
  keychain --agents ssh,gpg ~/.ssh/id_rsa -Q -q
fi
[ -z "$HOSTNAME" ] && HOSTNAME=`uname -n`
[ -f $HOME/.keychain/$HOSTNAME-sh ] && \
       . $HOME/.keychain/$HOSTNAME-sh
[ -f $HOME/.keychain/$HOSTNAME-sh-gpg ] && \
       . $HOME/.keychain/$HOSTNAME-sh-gpg

# -----------------

if [ -f ~/.zalias ]; then
    source ~/.zalias
fi
if [ -f ~/.zenv ]; then
    source ~/.zenv
fi

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

if [[ -d ~/.kubech ]]; then
    source "$HOME/.kubech/kubech"
fi

if which direnv &>/dev/null; then
    eval "$(direnv hook zsh)"
fi
