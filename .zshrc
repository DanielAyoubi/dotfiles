# History settings
HISTFILE=~/.zsh_history
HISTSIZE=100000
SAVEHIST=100000
HISTFILESIZE=100000
setopt appendhistory
setopt INC_APPEND_HISTORY
setopt HIST_IGNORE_DUPS
HISTORY_IGNORE="(ls|cd|pwd|reload|mv)"

# Autoload and compinit
autoload -Uz compinit && compinit
zmodload -i zsh/complist
autoload -U select-word-style
select-word-style bash

# Completion settings
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' menu select

# Key bindings
bindkey -M menuselect '^M' .accept-line
bindkey "^[[1;3C" forward-word
bindkey "^[[1;3D" backward-word
# bindkey "^[[1;5C" forward-word
# bindkey "^[[1;5D" backward-word

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down

WORDCHARS=${WORDCHARS//*?_-.[]~=/&;!#$%^(){}<>>}

# Alias definitions
alias ..='cd ..'
alias ...='cd ../../'
alias ....='cd ../../../'
alias .....='cd ../../../../'
alias ......='cd ../../../../../'
alias 2d='cd ../../'
alias 3d='cd ../../../'
alias 4d='cd ../../../../'
alias ls='lsd'
alias update='sudo pacman -Syu'
alias reload='source ~/.zshrc'
alias vi='nvim'
alias py='python3'
alias gh='history 1 | grep'
alias c='clear'
alias la='ls -A'
alias l='ls -1'
alias lt='ls -vlrth'
alias grep='grep --color=auto'
alias ff='firefox &'
alias osync='onedrive --synchronize &'
alias togrendel='f(){ scp -r "$@" danayo@grendel.cscaa.dk:~/packages/; unset -f f; }; f'
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias display='display -density 235'
alias codi='codium'
alias vpn='sudo openconnect --user=au584144@uni.au.dk --useragent=AnyConnect --background --reconnect-timeout=10000 --no-external-auth remote.au.dk/au-access'
alias icat='kitty +kitten icat'
alias vpn_disconnect='sudo kill $(ps aux | grep openconnect | grep -v grep | awk '"'"'{print $2}'"'"')'
alias zat='zathura --fork'
alias pdf='termpdf.py'
alias tg='tree -if | grep'
alias wifi='nmtui'
alias yay='paru'
alias nv='NVIM_APPNAME=LazyVim nvim'
alias p4='lp -d 4.sal-printer'
alias grendel='ssh -YC -o ServerAliveInterval=240 -o ServerAliveCountMax=100 danayo@grendel.cscaa.dk'
alias py='python3'
alias reload='source ~/.bashrc'
alias sqq='squeue --format="%.18i %.9P %.30j %.8u %.8T %.10M %.9l %.6D %R" --me'
alias gh='history | grep'
alias tg='tree -if | grep'
alias mol='molden -l'
alias fullcharge='sudo tlp fullcharge'
alias mg='sshfs danayo@grendel.cscaa.dk:/home/danayo/ ~/grendel -o reconnect,ServerAliveInterval=15,ServerAliveCountMax=3'
alias speciale='cd /home/daniel/Dropbox/speciale ; vi main.tex'



# Exported PATH
export PATH="~/.dotnet/tools:$PATH"
export PATH="usr/local/texlive/2022/bin/x86_64-linux:$PATH"
export PATH="$HOME/.local/bin:$PATH"
export PATH=/usr/local/texlive/2022/bin/x86_64-linux:$PATH

# Source
source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

echo -ne "\033]50;CursorShape=block\a"
PROMPT='%F{blue}[%~]%f %F{white}$ %f'

# Function for selecting Neovim config
function nvims() {
  items=("default" "LazyVim")
  config=$(printf "%s\n" "${items[@]}" | fzf --prompt=" Neovim Config  " --height=~50% --layout=reverse --border --exit-0)
  if [[ -z $config ]]; then
    echo "Nothing selected"
    return 0
  elif [[ $config == "default" ]]; then
    config=""
  fi
  NVIM_APPNAME=$config nvim "$@"
}
bindkey -s '^a' 'nvims\n'
export EDITOR=nvim
sh ~/.config/scripts/set_kitty_font.sh
export TERMINAL=kitty

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/usr/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/usr/etc/profile.d/conda.sh" ]; then
        . "/usr/etc/profile.d/conda.sh"
    else
        export PATH="/usr/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

# fzf
eval "$(fzf --zsh)"
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'
