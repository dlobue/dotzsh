
if [ -f /usr/share/git/completion/git-prompt.sh ]; then
    . /usr/share/git/completion/git-prompt.sh
fi

export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=0
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

PROMPT=$'%{$fg[blue]%}%m %{$reset_color%}%{$fg[green]%}[%~]%{$reset_color%}$(__git_ps1 " (%s)") \
%{$fg[blue]%}%{$fg[blue]%}❯%{$reset_color%} '
