
# Check if znap is installed
if [[ ! -d ~/.znap ]]; then
    git clone git@github.com:marlonrichert/zsh-snap.git ~/.znap
fi

zstyle ':znap:*' repos-dir ~/.zsh/plugins
source ~/.znap/znap.zsh


# znap source jonmosco/kube-ps1

# znap source zsh-users/zsh-completions
znap source larkery/zsh-histdb
znap source romkatv/zsh-defer
