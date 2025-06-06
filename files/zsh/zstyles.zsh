# Disable compatibility with Antibody
zstyle ':antidote:compatibility-mode' 'antibody'

# Fix pasting speed
# ref https://github.com/zsh-users/zsh-autosuggestions/issues/238
zstyle ':bracketed-paste-magic' active-widgets '.self-*'

# Disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# Set descriptions format to enable group support
zstyle ':completion:*:descriptions' format '[%d]'

# Matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# Pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Make it colourful
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# Use fzf-tab for completions
zstyle ':completion:*' menu no

# Add preview to the completions
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --bind=ctrl-n:down,ctrl-p:up,ctrl-y:accept
