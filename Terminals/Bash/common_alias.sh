alias cat='batcat'
alias plz='sudo'

nvim() {
    if [ $# -eq 0 ]; then
        command nvim -c "Ex"
    else
        command nvim $1
    fi
}
