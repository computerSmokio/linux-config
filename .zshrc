
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

ZSH_THEME="powerlevel10k/powerlevel10k"

source /usr/share/zsh-antidote/antidote.zsh
antidote load

function cwfb(){
    cargo watch -c -q -x "fmt" -x "build"
}
function cwfr(){
    cargo watch -c -q -x "fmt" -x "run"
}
function cwft(){
    cargo watch -c -q -x "fmt" -x "test"
}

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
[[ -s /home/smokio/.rsvm/rsvm.sh ]] && . /home/smokio/.rsvm/rsvm.sh # This loads RSVM

export DEVPATH=$HOME/development
export PATH=$HOME/.local/bin:$PATH

source <(fzf --zsh)

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/home/smokio/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
eval "$(zoxide init zsh --cmd cd)"
alias k="kubectl"
source <(kubectl completion zsh)
alias tmux=zellij
export KUBE_EDITOR=nvim
export EDITOR=$KUBE_EDITOR

[[ -s "/home/smokio/.gvm/scripts/gvm" ]] && source "/home/smokio/.gvm/scripts/gvm"
