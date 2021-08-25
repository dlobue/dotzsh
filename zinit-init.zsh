source ~/.zinit/bin/zinit.zsh

zinit ice blockf atpull'zinit creinstall -q .'
zinit light zsh-users/zsh-completions

# zinit light zdharma/fast-syntax-highlighting

# zplug "larkery/zsh-histdb"
zinit light "larkery/zsh-histdb"

# zplug "jonmosco/kube-ps1", use:"kube-ps1.sh"
zinit light "jonmosco/kube-ps1"

# zplug "mafredri/zsh-async", from:"github", use:"async.zsh", lazy:true
zinit light "mafredri/zsh-async"

zinit wait lucid light-mode id-as'direnv' atclone'direnv hook zsh > direnv-hook.zsh' atpull'%atclone' nocompile'!' compile'direnv-hook.zsh' src'direnv-hook.zsh' pick'direnv-hook.zsh' for zdharma/null



# zinit ice atclone'PYENV_ROOT="$PWD" ./libexec/pyenv init - > zpyenv.zsh' \
#     atinit'export PYENV_ROOT="$PWD"' atpull"%atclone" \
#     as'command' pick'bin/pyenv' src"zpyenv.zsh" nocompile'!'
# zinit light pyenv/pyenv

# zinit ice as"program" pick"$ZPFX/sdkman/bin/sdk" id-as'sdkman' run-atpull \
#     atclone"wget https://get.sdkman.io/?rcupdate=false -O scr.sh; SDKMAN_DIR=$ZPFX/sdkman bash scr.sh" \
#     atpull"SDKMAN_DIR=$ZPFX/sdkman sdk selfupdate" \
#     atinit"export SDKMAN_DIR=$ZPFX/sdkman; source $ZPFX/sdkman/bin/sdkman-init.sh"
# zinit light zdharma/null
