alias sctl="systemctl"
alias sctls="systemctl start"
alias sctlp="systemctl stop"

alias psh="poetry env activate"
alias pin="poetry install"


alias k="kubectl"
alias ka="kubectl apply -f"
alias kg="kubectl get"
alias kd="kubectl describe"
alias ke="kubectl edit"
alias delk="kubectl delete"
alias kl="kubectl logs"
alias klf="kubectl logs -f"
alias krr="kubectl rollout restart"

alias hla= "helm ls -A"
alias hls= "helm ls"
alias hup="helm upgrade --install"
alias unh="helm uninstall"
alias hgm="helm get manifest"
alias hgv="helm get values"
alias hsr="helm search repo"

alias ht="helm template this " 
alias ht.="helm template this ." 

alias nvsmi="nvidia-smi"

alias salias="source ~/aliases.zsh"
alias ealias="nvim ~/aliases.zsh"
alias etmux="nvim ~/.tmux.conf"
alias stmux="tmux source ~/.tmux.conf"
alias envim="nvim ~/.config/nvim"
alias ehypr="nvim ~/.config/hypr"


alias vi="nvim"
alias vim="nvim"
alias v="vi"
alias v.="nvim ."
alias nvim.="nvim ."

alias copy="wl-copy"

alias ses="~/.config/scripts/tmux_sessionizer"

alias tfp="tofu plan"
alias tfa="tofu apply"
alias detf="tofu destroy"

ksk() {
    secret_name=$1
    key=$2
    namespace=${3:-default}
    kubectl get secret $secret_name -n $namespace -o jsonpath="{.data.${key}}" | base64 --decode
}
