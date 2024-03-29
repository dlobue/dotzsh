# See http://zsh.sourceforge.net/Doc/Release/Options.html.

# =============================================================================
# Misc
# =============================================================================

# allow expansion in prompts
setopt prompt_subst
# display PID when suspending processes as well
setopt longlistjobs
# try to avoid the 'zsh: no matches found...'
setopt nonomatch
# report the status of backgrounds jobs immediately
setopt notify

# allow use of comments in interactive code
setopt interactivecomments

# whenever a command completion is attempted, make sure the entire command path
# is hashed first.
# setopt hash_list_all

# in order to use #, ~ and ^ for filename generation grep word
# *~(*.gz|*.bz|*.bz2|*.zip|*.Z) -> searches for word not in compressed files
# don't forget to quote '^', '~' and '#'!
setopt extended_glob

# Enable ksh-style globbing
# ?(pattern-list) matches zero or one occurrences of the given patterns
# *(pattern-list) matches zero or more occurrences of the given patterns
# +(pattern-list) matches one or more occurrences of the given patterns
# @(pattern-list) matches exactly one of the given patterns
# !(pattern-list) matches anything except one of the given patterns
# ex- `ls -lad !(*.p@(df|s))` directory listing of all non-pdf and ps files
setopt kshglob

# don't error out when unset parameters are used
setopt unset

# Trigger the completion after a glob * instead of expanding it.
setopt globcomplete

# automatically remove duplicates from these arrays
# typeset -U path cdpath fpath manpath

# avoid "beep"ing
setopt nobeep

# disable bracketed paste. disabling this allows pasting multiple commands into the terminal.
unset zle_bracketed_paste

# Long running processes should return time after they complete. Specified
# in seconds.
export REPORTTIME=10
export TIMEFMT="%U user %S system %P cpu %*Es total"

# Words are delimited by whitespace
autoload -U select-word-style
select-word-style whitespace

# =============================================================================
# Changing Directories
# =============================================================================

# If a command is issued that can't be executed as a normal command, and the
# command is the name of a directory, perform the cd command to that directory.
# setopt auto_cd

# Make cd push the old directory onto the directory stack.
# setopt auto_pushd

# Don't push multiple copies of the same directory onto the directory stack.
# setopt pushd_ignore_dups

# =============================================================================
# Completion
# =============================================================================

# If a completion is performed with the cursor within a word, and a full
# completion is inserted, the cursor is moved to the end of the word.
setopt always_to_end

# If unset, the cursor is set to the end of the word if completion is started.
# Otherwise it stays there and completion is done from both ends.
setopt complete_in_word

# Don't beep on an ambiguous completion.
unsetopt list_beep

setopt bash_auto_list
setopt list_ambiguous

# doesn't seem to work...
# Autocomplete aliases
# setopt completealiases

# Characters which are also part of a word.
# See 4.3.4 of http://zsh.sourceforge.net/Guide/zshguide04.html.
#WORDCHARS=''

# See http://zsh.sourceforge.net/Doc/Release/Completion-System.html.
# fpath=(~/.zsh/autocomp.d $fpath)
# fpath+=/usr/share/zsh/vendor-completions
# fpath+=/usr/share/zsh/site-functions

# fpath+=~/.zsh/autocomp.d
# fpath+=~/.asdf/completions
# zmodload zsh/complist
# autoload -Uz compinit
# if [[ -n ~/.zcompdump(#qN.mh+24) ]]; then
#   compinit
# else
#   compinit -C
# fi

# Menu selection will be started unconditionally.
# zstyle ':completion:*' menu select

# Try smart-case completion, then case-insensitive, then partial-word, and then
# substring completion.
# See http://zsh.sourceforge.net/Doc/Release/Completion-Widgets.html#Completion-Matching-Control.
# zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}' 'm:{a-zA-Z}={A-Z}{a-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'

# Make sure the terminal is in application mode, which zle is active. Only then
# are the values from $terminfo valid.
# See http://zshwiki.org/home/zle/bindkeys#reading_terminfo.
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }

  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

# Shift-Tab: Perform menu completion, like menu-complete, except that if a menu
# completion is already in progress, move to the previous completion rather than
# the next.
# See http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Completion.
# [ -n "${terminfo[kcbt]}" ] && bindkey "${terminfo[kcbt]}" reverse-menu-complete

# Set LS_COLORS.
# if [ -x /usr/bin/dircolors ]; then
#   test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
# fi
# If the zsh/complist module is loaded, this style can be used to set color
# specifications.
if [ -z "$LS_COLORS" ]; then
  zstyle ':completion:*' list-colors 'di=34:ln=35:so=32:pi=33:ex=31:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43:'
else
  zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
fi

# =============================================================================
# History
# =============================================================================

# this is default, but set for share_history
setopt append_history
# save each command's beginning timestamp and the duration to the history file
setopt extended_history

# If the internal history needs to be trimmed to add the current command line,
# setting this option will cause the oldest history event that has a duplicate
# to be lost before losing a unique event from the list.
setopt hist_expire_dups_first

# When searching for history entries in the line editor, do not display
# duplicates of a line previously found, even if the duplicates are not
# contiguous.
setopt hist_find_no_dups

# Do not enter command lines into the history list if they are duplicates of the
# previous event.
setopt hist_ignore_dups

# Whenever the user enters a line with history expansion, don't execute the line
# directly; instead, perform history expansion and reload the line into the
# editing buffer.
# setopt hist_verify
setopt no_hist_verify

# This options works like APPEND_HISTORY except that new history lines are added
# to the $HISTFILE incrementally (as soon as they are entered), rather than
# waiting until the shell exits.
setopt inc_append_history

# Share your history across all your terminal windows
setopt share_history
#setopt noclobber

# Do not save commands prefixed with a space to history
setopt hist_ignore_space

# Remove superfluous blanks from each command line being added to the history list.
setopt hist_reduce_blanks

# See 2.5.4 of http://zsh.sourceforge.net/Guide/zshguide02.html.
[ -z "$HISTFILE" ] && HISTFILE=$HOME/.zsh_history
# HISTSIZE=10000
# SAVEHIST=10000
HISTSIZE=100000000000
SAVEHIST=100000000000

# =============================================================================
# Input/Output
# =============================================================================

# If this option is unset, output flow control via start/stop characters
# (usually assigned to ^S/^Q) is disabled in the shell's editor.
unsetopt flow_control

# =============================================================================
# Key Bindings
# =============================================================================

# See
# http://pubs.opengroup.org/onlinepubs/7908799/xcurses/terminfo.html#tag_002_001_003_003
# for the table of terminfo, and see
# http://zsh.sourceforge.net/Doc/Release/Zsh-Line-Editor.html#Standard-Widgets
# for standard widgets of zsh.

# Home
# [ -n "${terminfo[khome]}" ] && bindkey "${terminfo[khome]}" beginning-of-line
# End
# [ -n "${terminfo[kend]}" ] && bindkey "${terminfo[kend]}" end-of-line
# Backspace
# [ -n "${terminfo[kbs]}" ] && bindkey "${terminfo[kbs]}" backward-delete-char
# Delete
# [ -n "${terminfo[kdch1]}" ] && bindkey "${terminfo[kdch1]}" delete-char
# Up-arrow
# [ -n "${terminfo[kcuu1]}" ] && bindkey "${terminfo[kcuu1]}" up-line-or-history
# Down-arrow
# [ -n "${terminfo[kcud1]}" ] && bindkey "${terminfo[kcud1]}" down-line-or-history
# Left-arrow
# [ -n "${terminfo[kcub1]}" ] && bindkey "${terminfo[kcub1]}" backward-char
# Right-arrow
# [ -n "${terminfo[kcuf1]}" ] && bindkey "${terminfo[kcuf1]}" forward-char
