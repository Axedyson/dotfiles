alias ll='ls -AlF'
export EDITOR='nvim'

export DISPLAY=$(awk '/nameserver / {print $2; exit}' /etc/resolv.conf 2>/dev/null):0
alias sudo_update='sudo apt update && sudo apt upgrade && sudo apt autoremove && sudo apt clean && sudo apt autoclean'
