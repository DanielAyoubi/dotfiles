PROMPT='%F{blue}[%~]%f %F{white}$ %f'

# Colors
LS_COLORS='di=34:ex=33:*.sh=31:*.py=32:*.pdf=33:*.zip=35:*.jpg=36:*.png=36:'
export LS_COLORS

# Zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[[ ! -d "$ZINIT_HOME" ]] && { mkdir -p "$(dirname $ZINIT_HOME)"; git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"; }
source "${ZINIT_HOME}/zinit.zsh"

# Plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
autoload -Uz compinit && compinit
zmodload -i zsh/complist

# Keybindings
bindkey -e
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
WORDCHARS='*?[]~=&;!#$%^(){}<>'

autoload -U up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search
bindkey "^[[B" down-line-or-beginning-search

# History
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=$HISTSIZE
setopt appendhistory sharehistory hist_ignore_space hist_ignore_all_dups hist_reduce_blanks

# Aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='eza --color=always --long --icons=always --no-user --sort=time'
alias lsa='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'
alias py='python3'
alias vi='nvim'
alias reload='source ~/.zshrc'
alias ff="fzf --preview 'bat --style=numbers --color=always {}'"
alias img='kitty +kitten icat'


# FZF integration
show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
_fzf_comprun() {
  local command=$1; shift
  case "$command" in
    cd) fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    ssh) fzf --preview 'dig {}' "$@" ;;
    *) fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# PATH
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:/opt/homebrew/bin:$PATH"

# Misc
export EDITOR="nvim"
export SUDO_EDITOR="$EDITOR"
export BAT_THEME=ansi

# Compression helpers
compress() { tar -czf "${1%/}.tar.gz" "${1%/}"; }
alias decompress="tar -xzf"

# iTerm2
test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"


. "$HOME/.local/share/../bin/env"
