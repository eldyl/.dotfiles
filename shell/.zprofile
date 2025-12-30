if [[ $(uname -s) = "Linux" ]]; then
    export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
fi

if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" -eq 1 ] && uwsm check may-start; then
    exec uwsm start hyprland.desktop
fi
