autoload -Uz colors
colors

if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    . /usr/share/git/completion/git-prompt.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=0
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

# (<symbol>|<context>:<namespace>)
# ${PREFIX}<symbol>${SEPARATOR}<context>${DIVIDER}<namespace>${SUFFIX}
export KUBE_PS1_ENABLED=off
export KUBE_PS1_SYMBOL_ENABLE=false
export KUBE_PS1_CONTEXT_ENABLE=true
export KUBE_PS1_PREFIX=" {"
export KUBE_PS1_SUFFIX="}"
export KUBE_PS1_NS_COLOR=null
export KUBE_PS1_CTX_COLOR=magenta
# goes between context and namespace
# export KUBE_PS1_DIVIDER=":"

# PROMPT=$'%{$fg[blue]%}%m %{$reset_color%}%{$fg[green]%}[%(5~|%-1~/…/%3~|%4~)]%{$reset_color%}$(__git_ps1 " (%s)")$(kube_ps1) \
PROMPT=$'%{$fg[blue]%}%m %{$reset_color%}%{$fg[green]%}[$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)]%{$reset_color%}$(__git_ps1 " (%s)")$(kube_ps1) \
%{$fg[blue]%}%{$fg[blue]%}❯%{$reset_color%} '
