source ~/.zinit/bin/zinit.zsh

# zplug 'zsh-users/zsh-completions'
# zinit ice blockf
zinit light zsh-users/zsh-completions
# zinit creinstall zsh-users/zsh-completions   # install

# zinit light zdharma/fast-syntax-highlighting

# zplug "larkery/zsh-histdb"
zinit light "larkery/zsh-histdb"

# zplug "jonmosco/kube-ps1", use:"kube-ps1.sh"
zinit light "jonmosco/kube-ps1"

# zplug "mafredri/zsh-async", from:"github", use:"async.zsh", lazy:true
zinit light "mafredri/zsh-async"
