# ~/.zsh_profile
[[ -f ~/.zshrc ]] && . ~/.zshrc

if [[ $(uname -s) = "Linux" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi
