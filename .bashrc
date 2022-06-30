export EDITOR='nvim'
alias sudo_update='sudo apt update && sudo apt -y upgrade && sudo apt autoremove && sudo apt clean'
alias login='eval `keychain --clear --eval --agents ssh id_ed25519`'
export GPG_TTY=$(tty)
