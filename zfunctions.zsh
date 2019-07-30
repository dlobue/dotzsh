
function ssh-clear {
    sed -i '/'$1'/d' ~/.ssh/known_hosts
}


function tarcp {
    local USE_SUDO
    case "$1" in
        -s)
            shift
            USE_SUDO=sudo;;
        *)
            break;;
    esac
    local dest="$argv[${#argv}]"
    local to_copy=($argv[1,${#argv}-1])
    $USE_SUDO tar c $to_copy |
    pv -eTprab -s `$USE_SUDO du -scb $to_copy | awk '$2=="total"{print $1}'` -i 1 |
    $USE_SUDO tar x -C $dest
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


function load-aws {
    if [ -z ${AWS_LOADED+z} ]; then
        unset -f aws
        # . aws_bash_completer
        export AWS_LOADED=1
    fi
}


function aws {
    load-aws
    aws "$@"
}