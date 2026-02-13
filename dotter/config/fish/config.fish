# Home Manager session variables
if test -f ~/.nix-profile/etc/profile.d/hm-session-vars.fish
    source ~/.nix-profile/etc/profile.d/hm-session-vars.fish
end

# Disable greeting
set -g fish_greeting

# Aliases
alias ..="cd ../"
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"

alias h="hx"
alias h.="hx ."

alias g="git"
alias gf="git fetch --prune"
alias gs="git status -s"
alias gp="git push"
alias gl="git pull"
alias gsv="git diff --cached"
alias gd="git diff"
alias lg="lazygit"

alias claer="clear"
alias cl="clear"

alias sl="ls"
alias ls="ez"
alias ez="eza --icons --group-directories-first"
alias l="ls"

alias flake="nix flake"
alias home="home-manager"
alias nixgc="nix-collect-garbage"
alias yz="yazi"
alias zel="zellij"
alias sd="shutdown"

alias claude="claude --dangerously-skip-permissions"

# Tool integrations
fzf --fish | source
zoxide init fish | source
mise activate fish | source
direnv hook fish | source
starship init fish | source

# Ghostty shell integration
if set -q GHOSTTY_RESOURCES_DIR
    source "$GHOSTTY_RESOURCES_DIR/shell-integration/fish/vendor_conf.d/ghostty-shell-integration.fish"
end
