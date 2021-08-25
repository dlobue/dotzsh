autoload -U vcs_info
precmd_functions+=(vcs_info)


export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=0
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"

zstyle ':vcs_info:*' actionformats '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{3}|%F{1}%a%F{5}]%f '
# zstyle ':vcs_info:*' formats       '%F{5}(%f%s%F{5})%F{3}-%F{5}[%F{2}%b%F{5}]%f '
zstyle ':vcs_info:*' formats ' (%b)'
zstyle ':vcs_info:(sv[nk]|bzr):*' branchformat '%b%F{1}:%F{3}%r'

# zstyle ':vcs_info:git:*' check-for-changes true


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
# PROMPT=$'%{$fg[blue]%}%m %{$reset_color%}%{$fg[green]%}[$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)]%{$reset_color%}$(__git_ps1 " (%s)")$(kube_ps1) \
# PROMPT=$'%{$fg[blue]%}%m %{$reset_color%}%{$fg[green]%}[$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)]%{$reset_color%}$(__git_ps1 " (%s)") \

# PROMPT=$'%{$fg[blue]%}%m %{$reset_color%}%{$fg[green]%}[$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)]%{$reset_color%}${vcs_info_msg_0_} \
# %{$fg[blue]%}%{$fg[blue]%}❯%{$reset_color%} '

# PROMPT=$'%{$fg[cyan]%}hekate %{$reset_color%}%{$fg[green]%}[%(5~|%-1~/…/%3~|%4~)]%{$reset_color%}$(__git_ps1 " (%s)")$(kube_ps1) \
# %{$fg[blue]%}%{$fg[blue]%}❯%{$reset_color%} '

# PROMPT=$'%F{blue}%m %f%F{green}[$(/home/dominic/projects/zsh-reference/path-shorteners/short_path/short_path)]%f${vcs_info_msg_0_} \
PROMPT=$'%F{cyan}hekate %f%F{green}[${pretty_path:-UNSET}]%f${vcs_info_msg_0_} \
%F{blue}❯%f '
