PROMPT='%F{blue}[%~]%f %F{white}$ %f'
LS_COLORS='di=34:ex=33:*.sh=31:*.py=32:*.pyc=32:*.pdf=33:*.zip=35:*.tar=35:*.gz=35:*.bz2=35:*.xz=35:*.jpg=36:*.jpeg=36:*.png=36:*.gif=36:*.bmp=36:*.mp3=36:*.wav=36:*.ogg=36:*.flac=36:*.mkv=36:*.mp4=36:*.avi=36:*.mov=36:*.flv=36:'
export LS_COLORS

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit && compinit
zmodload -i zsh/complist

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^[[A' history-search-backward
bindkey '^[[B' history-search-forward
bindkey '^[w' kill-region
bindkey -M menuselect '^M' .accept-line
bindkey "^[[1;3C" forward-word   
bindkey "^[[1;3D" backward-word 
WORDCHARS='*?[]~=&;!#$%^(){}<>'


# History settings
HISTSIZE=100000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
HISTORY_IGNORE="(ls|cd|pwd|reload|mv)"

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu select
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

# Aliases
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias 2d='cd ../../'
alias 3d='cd ../../../'
alias 4d='cd ../../../../'
alias ls='lsd'
alias reload='source ~/.zshrc'
alias vi='nvim'
alias la='ls -A'
alias l='ls -1'
alias lt='eza --color=always --long --icons=always --no-user --sort=time'
alias tg='tree -if | grep'
alias nv='NVIM_APPNAME=LazyVim nvim'
alias py='python3'

# Shell integrations
eval "$(fzf --zsh)"
eval "$(zoxide init --cmd cd zsh)"

# Ensure this function is available for searching history upwards
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

# PATHS
export PATH="/opt/homebrew/opt/python@3.11/libexec/bin:$PATH"
export PATH="/opt/homebrew/bin:$PATH"


# show_file_or_dir_preview="if [ -d {} ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"
# export FZF_CTRL_T_OPTS="--preview '$show_file_or_dir_preview'"
# export FZF_ALT_C_OPTS="--preview 'eza --tree --color=always {} | head -200'"

# Advanced customization of fzf options via _fzf_comprun function
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo ${}'"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "$show_file_or_dir_preview" "$@" ;;
  esac
}

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
source "${HOME}/.environment_variables" 
