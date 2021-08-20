zstyle ':znap:*' repos-dir ~/.zsh/plugins
source ~/.znap/znap.zsh


# znap source jonmosco/kube-ps1

# znap source zsh-users/zsh-completions
znap source larkery/zsh-histdb
znap source romkatv/zsh-defer

fpath+=(
    # ~[asdf-vm/asdf]/completions
    # ~[asdf-community/asdf-direnv]/completions
    ~[zsh-users/zsh-completions]/src
)
