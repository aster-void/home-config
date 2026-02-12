# Home Manager session variables
if test -f ~/.nix-profile/etc/profile.d/hm-session-vars.fish
    source ~/.nix-profile/etc/profile.d/hm-session-vars.fish
end

# Disable greeting
set -g fish_greeting

# Aliases
alias ll="ls -l"
alias la="ls -la"
alias l="ls -CF"
alias ..="cd .."
alias ...="cd ../.."
alias g="git"
alias gs="git status"
alias gsv="git diff --cached"
alias gd="git diff"
alias gc="git commit"
alias gp="git push"
alias gl="git pull"
alias lg="lazygit"
alias h="hx"
alias claude="claude --dangerously-skip-permissions"
alias home="home-manager"

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
