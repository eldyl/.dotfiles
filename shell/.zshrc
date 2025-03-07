# If not running interactively, don't do anything
[[ $- != *i* ]] && return

#------------------------
#   Prompt string
#------------------------
# TODO: You will not want all of this information for large repos, it slows
# things down
autoload -Uz vcs_info
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:git*' formats "%F{#9ece6a}(%f%F{#94DAE6}:%b%F{#9ece6a})%f%u%c%m"
zstyle ':vcs_info:git*' actionformats "%F{#9ece6a}(%f%F{#94DAE6}:%b%F{#9ece6a})%f%u%c%m"
zstyle ':vcs_info:*' unstagedstr '%F{#f7768e}󰇂%f '
zstyle ':vcs_info:*' stagedstr '%F{#9ece6a}+%f '
precmd() {
    vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        PS1="%F{#317490}[%F{#c0caf5}%n@%m%F{#317490}]%f %5 %F{#317490}[%F{#c0caf5}%~%F{#317490}]%f % %F{#317490}>%f "
    else
        PS1="%F{#317490}[%F{#c0caf5}%n@%m%F{#317490}]%f %3 %F{#317490}[%F{#c0caf5}%~%F{#317490}]%f ${vcs_info_msg_0_}%  %F{#317490}>%f "
    fi

    RPROMPT="%F{#c0caf5}%T%f"

}


zstyle ':vcs_info:git*+set-message:*' hooks git-st
+vi-git-st() {
    local ahead behind
    local -a gitstatus

    # Exit early in case the worktree is on a detached HEAD
    git rev-parse ${hook_com[branch]}@{upstream} >/dev/null 2>&1 || return 0

    local -a ahead_and_behind=(
        $(git rev-list --left-right --count HEAD...${hook_com[branch]}@{upstream} 2>/dev/null)
    )

    local changes_made

    ahead=${ahead_and_behind[1]}
    behind=${ahead_and_behind[2]}

    (( $ahead )) && gitstatus+=( "%F{#94DAE6}+${ahead}%f " )
    (( $behind )) && gitstatus+=( "%F{#f7768e}-${behind}%f " )

    hook_com[misc]+=${(j:/:)gitstatus}
}


#---------------
#   Check OS
#---------------

L='Linux'
M='Darwin'
OS=$(uname -s)

############################
#~~~~ Set zsh defaults ~~~~#
############################

export OS
export LANG=en_US.UTF-8
export LC_COLLATE=C
export SHELL=/bin/zsh
source "$HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh"
export fpath=($HOME/.zsh/zsh-autocomplete/zsh-autocomplete.plugin.zsh $fpath)
export TERM=wezterm
export EDITOR=nvim
export BROWSER=brave
export GPG_TTY=$(tty) # add gpg key to TTY

bindkey -v # select using vi mode
setopt COMBINING_CHARS # Assume terminal shows these chars correctly
unsetopt BEEP # Never make noise

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Allows autocomplete
autoload -Uz compinit
compinit

#--------------------------
#       Set Environment
#--------------------------

# Homebrew for mac
[[ "$OS" == "$M" ]] && export PATH="/opt/homebrew/bin:$PATH"

# Include cargo for rust
export PATH="$HOME/.cargo/bin:$PATH"
# Include backtrace
export RUST_BACKTRACE=1

# Include pip for python
export PATH="$HOME/.local/bin:$PATH"

# pnpm
export PNPM_HOME="$HOME/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "$HOME/.bun/_bun" ] && source "$HOME/.bun/_bun"

# Deno
. "$HOME/.deno/env"

# Android dev
[[ "$OS" == "$L" ]] && export ANDROID_HOME="$HOME/Utils/Android/sdk"
[[ "$OS" == "$L" ]] && export CAPACITOR_ANDROID_STUDIO_PATH="/opt/android-studio/bin/studio.sh"

# .NET
export PATH="$PATH:$HOME/.dotnet/tools"
DOTNET_CLI_TELEMETRY_OPTOUT=1

#------------------
#~~~~ Aliases ~~~~#
#------------------

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias ip='ip --color=auto'

# Common commands
alias pn='pnpm'
alias buns='bun start'
alias thebook='rustup docs --book'
alias cwa='cargo watch -x check -x test -x run'

# Access sudo crontab
[[ "$OS" == "$L" ]] &&  alias sudocrontab="su -c $(printf "%q " "crontab -e")"

# Git
alias gs='git status'
alias ga='git add'
alias gd='git diff'
alias gcm='git commit -m'
alias gco='git checkout'
alias gpush='git push'
alias gpull='git pull'

#------------------------
#    Keybindings 
#------------------------

# Create a zkbd compatible hash
typeset -g -A key
# Select keys
key[Delete]="${terminfo[kdch1]}"
# Set key value
[[ -n "${key[Delete]}"    ]] && bindkey -- "${key[Delete]}"     delete-char
# Make sure terminal is in application mode
if (( ${+terminfo[smkx]} && ${+terminfo[rmkx]} )); then
	autoload -Uz add-zle-hook-widget
	function zle_application_mode_start { echoti smkx }
	function zle_application_mode_stop { echoti rmkx }
	add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
	add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi
