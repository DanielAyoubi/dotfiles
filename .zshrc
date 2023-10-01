# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

LS_COLORS="di=1;34:ex=1;33:*.sh=1;37:*.py=1;92:*.cs=1;35:*.pdf=1;33:*.xlsx=32:*.svg=1;37"
# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
export CLICOLOR=1
export LS_COLORS
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS} 
zstyle ':completion:*' list-colors 'di=31:py=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

# ZSH_THEME="eastwood"
zmodload -i zsh/complist
bindkey -M menuselect '^M' .accept-line
plugins=(git zsh-autosuggestions)

ZSH_THEME="powerlevel10k/powerlevel10k"
source $ZSH/oh-my-zsh.sh
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word
if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
    export MOZ_ENABLE_WAYLAND=1
fi


(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]=none
ZSH_HIGHLIGHT_STYLES[path_prefix]=none

############ ALIASES #################
HIST_IGNORE_SPACE=true
alias ls=' lsd'
alias update='sudo pacman -Syu'
alias reload='source ~/.zshrc'
alias vi='nvim'
# alias nv='nvim'
alias py='python3'
alias gh='history | grep'
alias c=' clear'
alias la='ls -A'
alias l='ls -1'
alias ff="firefox &"
alias osync='onedrive --synchronize &'
alias togrendel='f(){ scp -r "$@" danayo@grendel.cscaa.dk:~/packages/; unset -f f; }; f'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias display='display -density 235'
alias codi='codium'
alias vpn='sudo openconnect --user=au584144@uni.au.dk --protocol=anyconnect --background remote.au.dk/au-access'
alias icat='kitty +kitten icat'
alias vpn_disconnect='sudo kill $(ps aux | grep openconnect | grep -v grep | awk '"'"'{print $2}'"'"')'
alias zat='zathura --fork'
alias pdf='termpdf.py'
alias tg='tree -if | grep'
alias wifi='nmtui'
alias nv="NVIM_APPNAME=LazyVim nvim"
alias p4='lp -d 4.sal-printer'
alias grendel='kitty +kitten ssh -YC -o ServerAliveInterval=60 -o ServerAliveCountMax=10 danayo@grendel.cscaa.dk'

########################################

export PATH="~/.dotnet/tools:$PATH"
export PATH="usr/local/texlive/2022/bin/x86_64-linux:$PATH"
export PATH="$HOME/.local/bin:$PATH"
source /home/daniel/.oh-my-zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
echo -ne "\033]50;CursorShape=block\a"

function nvims() {
  items=("default" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim $@
}

# bindkey -s ^a "nvims\n"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
