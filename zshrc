
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

# source ~/.zsh/heroku-autocomp.zsh
source ~/.zsh/zsettings.zsh
source ~/.zsh/zsh-vim-mode.plugin.zsh
source ~/.zsh/zprompt.zsh
source ~/.zsh/zfunctions.zsh
source ~/.zsh/envmanager.zsh

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
  ${HOME}/.cargo/bin
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
  # TODO: cache the ruby gem dir location in a file somewhere and update it
  # every once in a while. use compinit cache in zsettings as example
  #$(ruby -r rubygems -e 'puts Gem.user_dir')/bin
  /root/.gem/ruby/2.6.0/bin
)
export PATH

# rehash on USR1
catch_signal_usr1() {
  trap catch_signal_usr1 USR1
  rehash
}
trap catch_signal_usr1 USR1


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

export LS_COLORS="rs=0:di=01;34:ln=01;36:mh=00:pi=40;33:so=01;35:do=01;35:bd=40;33;01:cd=40;33;01:or=40;31;01:mi=00:su=37;41:sg=30;43:ca=30;41:tw=30;42:ow=34;42:st=37;44:ex=01;32:*.tar=01;31:*.tgz=01;31:*.arc=01;31:*.arj=01;31:*.taz=01;31:*.lha=01;31:*.lz4=01;31:*.lzh=01;31:*.lzma=01;31:*.tlz=01;31:*.txz=01;31:*.tzo=01;31:*.t7z=01;31:*.zip=01;31:*.z=01;31:*.dz=01;31:*.gz=01;31:*.lrz=01;31:*.lz=01;31:*.lzo=01;31:*.xz=01;31:*.zst=01;31:*.tzst=01;31:*.bz2=01;31:*.bz=01;31:*.tbz=01;31:*.tbz2=01;31:*.tz=01;31:*.deb=01;31:*.rpm=01;31:*.jar=01;31:*.war=01;31:*.ear=01;31:*.sar=01;31:*.rar=01;31:*.alz=01;31:*.ace=01;31:*.zoo=01;31:*.cpio=01;31:*.7z=01;31:*.rz=01;31:*.cab=01;31:*.wim=01;31:*.swm=01;31:*.dwm=01;31:*.esd=01;31:*.jpg=01;35:*.jpeg=01;35:*.mjpg=01;35:*.mjpeg=01;35:*.gif=01;35:*.bmp=01;35:*.pbm=01;35:*.pgm=01;35:*.ppm=01;35:*.tga=01;35:*.xbm=01;35:*.xpm=01;35:*.tif=01;35:*.tiff=01;35:*.png=01;35:*.svg=01;35:*.svgz=01;35:*.mng=01;35:*.pcx=01;35:*.mov=01;35:*.mpg=01;35:*.mpeg=01;35:*.m2v=01;35:*.mkv=01;35:*.webm=01;35:*.ogm=01;35:*.mp4=01;35:*.m4v=01;35:*.mp4v=01;35:*.vob=01;35:*.qt=01;35:*.nuv=01;35:*.wmv=01;35:*.asf=01;35:*.rm=01;35:*.rmvb=01;35:*.flc=01;35:*.avi=01;35:*.fli=01;35:*.flv=01;35:*.gl=01;35:*.dl=01;35:*.xcf=01;35:*.xwd=01;35:*.yuv=01;35:*.cgm=01;35:*.emf=01;35:*.ogv=01;35:*.ogx=01;35:*.aac=00;36:*.au=00;36:*.flac=00;36:*.m4a=00;36:*.mid=00;36:*.midi=00;36:*.mka=00;36:*.mp3=00;36:*.mpc=00;36:*.ogg=00;36:*.ra=00;36:*.wav=00;36:*.oga=00;36:*.opus=00;36:*.spx=00;36:*.xspf=00;36:"

