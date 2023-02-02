
function ssh-clear {
    sed -i '/'$1'/d' ~/.ssh/known_hosts
}


function tarcp {
    local USE_SUDO
    local USE_SPARSE
    while true; do
        case "$1" in
            --sparse)
                USE_SPARSE="--sparse"
                shift;;
            -s|--sudo)
                USE_SUDO=sudo
                shift;;
            *)
                break;;
        esac
    done
    local dest="$argv[${#argv}]"
    local to_copy=($argv[1,${#argv}-1])
    $USE_SUDO tar c $USE_SPARSE $to_copy |
    pv -eTprab -s `$USE_SUDO du -scb $to_copy | awk '$2=="total"{print $1}'` -i 1 |
    $USE_SUDO tar x $USE_SPARSE -C $dest
}


function _prompt_yn {
    while true; do
        read "yn?$1 [y|n] "
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}


function vim-process-swap {
    local swapfile_first=0
    local noninteractive=0
    while true; do
        case "$1" in
            ""|-h|--help)
                echo "usage: $0 file [swapfile [recoverfile]]" >&2
                return 1;;
            -s)
                shift
                swapfile_first=1;;
            -n)
                shift
                noninteractive=1;;
            *)
                break;;
        esac
    done
    local realfile=`readlink -f "$1"`
    local path=`dirname "$realfile"`
    local realname=$(/usr/bin/basename "$realfile")
    if [ $swapfile_first -eq 1 ]; then
        local swapfile=$realfile
        realname=${realname:1:-4}
        realfile="${path}/${realname}"
    else
        local swapfile=${2:-"${path}/.${realname}.swp"}
    fi
    local recoverfile=${3:-"${path}/${realname}-recovered"}
    local lastresort=0
    for f in "$realfile" "$swapfile"; do
        if [ ! -f "$f" ]; then
            echo "File $f does not exist." >&2
            return 1
        elif /usr/bin/fuser "$f"; then
            echo "File $f in use by process." >&2
            return 1
        fi
    done
    if [ -f "$recoverfile" ]; then
        echo "Recover file $recoverfile already exists. Delete existing recover file first." >&2
        return 1
    fi
    /usr/bin/vim -u /dev/null --noplugin -r "$swapfile" -c ":wq $recoverfile"
    if /usr/bin/cmp -s "$realfile" "$recoverfile"; then
        /usr/bin/rm "$swapfile" "$recoverfile"
    elif [ "$realfile" -nt "$swapfile" ] && [ `/usr/bin/stat -c%s "$realfile"` -gt `/usr/bin/stat -c%s "$recoverfile"` ]; then
        echo "Swapfile is older than realfile, and recovered file is smaller than realfile"
        if [ $noninteractive -eq 0 ] && _prompt_yn "Delete recovered file and swapfile without doing diff?"; then
            /usr/bin/rm "$swapfile" "$recoverfile"
        else
            lastresort=1
        fi
    else
        lastresort=1
    fi

    if [[ "$lastresort" -ne 0 ]]; then
        if [ $noninteractive -eq 1 ]; then
            echo "user interaction required for file ${recoverfile} ${realfile} ${swapfile}"
            return 1
        else
            /usr/bin/rm "$swapfile"
            /usr/bin/vimdiff "$recoverfile" "$realfile"
            if _prompt_yn "Delete recovered file?"; then
                /usr/bin/rm "$recoverfile"
            fi
        fi
    fi
}


function xselbuf {
    local stripnl=0;
    while true; do
        case "$1" in
            -n)
                shift
                stripnl=1;;
            *)
                break;;
        esac
    done
    if [ $stripnl -eq 1 ]; then
        exec tr -d "\n" | xsel ${@}
    else
        exec xsel ${@}
    fi
}


# function load-aws {
#     if [ -z ${AWS_LOADED+z} ]; then
#         unset -f aws
#         if type aws_zsh_completer.sh &>/dev/null; then
#           . aws_zsh_completer.sh
#         fi
#         export AWS_LOADED=1
#     fi
# }


# function aws {
#     if [ -z ${AWS_LOADED+z} ]; then
#         load-aws
#     else
#         unset -f aws
#     fi
#     aws "$@"
# }


function convert-to-submodule {
    pushd "$1";
    local repo_url=`git remote -v | awk '{print $2}' | head`;
    popd;
    git submodule add $repo_url "$1";
    git commit -m "add `basename $1` submodule"
    git submodule absorbgitdirs $1
}


# Bash Colors index
# ------------------------------------------------
function color_index() {
  # Show an index of all available bash colors
  echo -e "\n              Usage: \\\033[*;**(;**)m"
  echo -e   "            Default: \\\033[0m"
  local blank_line="\033[0m\n     \033[0;30;40m$(printf "%41s")\033[0m"
  echo -e "$blank_line" # Top border
  for STYLE in 2 0 1 4 9; do
    echo -en "     \033[0;30;40m "
    # Display black fg on white bg
    echo -en "\033[${STYLE};30;47m${STYLE};30\033[0;30;40m "
    for FG in $(seq 31 37); do
        CTRL="\033[${STYLE};${FG};40m"
        echo -en "${CTRL}"
        echo -en "${STYLE};${FG}\033[0;30;40m "
    done
    echo -e "$blank_line" # Separators
  done
  echo -en "     \033[0;30;40m "
  # Background colors
  echo -en "\033[0;37;40m*;40\033[0;30;40m \033[0m" # Display white fg on black bg
  for BG in $(seq 41 47); do
      CTRL="\033[0;30;${BG}m"
      echo -en "${CTRL}"
      echo -en "*;${BG}\033[0;30;40m "
  done
  echo -e "$blank_line" "\n" # Bottom border
}

function color_table() {
  for i in {0..255}; do
    print -Pn "%K{$i}  %k%F{$i}${(l:3::0:)i}%f " ${${(M)$((i%6)):#3}:+$'\n'}
  done
}


function toggle-kube-ps1-enabled {
  if [[ "${KUBE_PS1_ENABLED}" == "off" ]]; then
    export KUBE_PS1_ENABLED=on
  else
    export KUBE_PS1_ENABLED=off
  fi
}


function toggle-kube-ps1-ctx {
  if [[ "${KUBE_PS1_CONTEXT_ENABLE}" == true ]]; then
    export KUBE_PS1_CONTEXT_ENABLE=false
  else
    export KUBE_PS1_CONTEXT_ENABLE=true
    _kube_ps1_get_context
  fi
}


function = 
{
  echo "$@" | bc -l
}

alias calc="="
