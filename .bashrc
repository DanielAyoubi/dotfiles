# .bashrc
# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

  # Enable the subsequent settings only in interactive sessions
case $- in
  *i*) ;;
    *) return;;
esac

LS_COLORS="di=1;34:ex=1;31:*.sh=1;33:*.py=1;32"

# Uncomment the following line if you don't like systemctl's auto-paging feature:
#export SYSTEMD_PAGER=
bind '"\e[A"':history-search-backward > /dev/null 2>&1
bind '"\e[B"':history-search-forward  > /dev/null 2>&1
bind '"\e[1;3C": forward-word'
bind '"\e[1;3D": backward-word'

case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
        color_prompt=yes
    else
        color_prompt=yes
    fi
fi

#Aliases

# History
export HISTSIZE=10000
export HISTFILESIZE=20000
export HISTCONTROL=ignoreboth
shopt -s histappend
export HISTTIMEFORMAT="%F %T "
export HISTIGNORE="ls:bg:fg:exit:clear:lt:la"


# Functions
function test() { sbatch -p qtest --time 60:00 JKsend $1; }
change() {
  if [ "$#" -lt 3 ]; then
    echo "Usage: change <old_string> <new_string> <files>"
    return 1
  fi

  local old_string=$1
  local new_string=$2
  shift 2 # Shift the arguments so $@ starts with the file list

  for file in "$@"; do
    if [ ! -f "$file" ]; then
      echo "Error: File $file does not exist."
      continue
    fi

    sed -i "s@$old_string@$new_string@g" "$file"
  done
}

function show_jobs_with_dirs() {
    squeue --me --format "%Z %j" | awk 'NR>1' | sed 's/\/home\/danayo\///' | sort | uniq | while read -r line; do
        dir=$(echo "$line" | awk '{print $1}')
        job=$(echo "$line" | awk '{print $2}')
        echo "$dir - Job: $job"
    done
}

PREVIOUS_STATE_FILE="$HOME/.job_files"

cj() {
    local previous_status_file="$HOME/.job_status.txt"

    if [ ! -f "$previous_status_file" ]; then
        echo "Previous status file not found. Creating a new one."
        squeue --format="%.18i %.8T %.Z" --me > "$previous_status_file"
        return
    fi

    local current_status
    current_status=$(squeue --format="%.18i %.8T %.Z" --me)

    echo "Finished jobs:"
    while IFS= read -r line; do
        local job_id=$(echo "$line" | awk '{print $1}')
        local job_dir=$(echo "$line" | awk '{print $3}')

        if ! grep -q "$job_id" <<< "$current_status"; then
            echo "Job ID: $job_id, Directory: $job_dir"
        fi
    done < "$previous_status_file"

    echo "$current_status" > "$previous_status_file"
}

#PATHS
alias JKpython=' source /home/danayo/JKCS2.1/JKQC/JKCS/bin/activate; alias python=/home/danayo/JKCS2.1/JKQC/JKCS/bin/python3.9'
export PATH=/home/kubeckaj/Applications/crest/:$PATH
export PATH=/home/kubeckaj/Applications/XTB6.4/bin:$PATH
export PATH=/home/danayo/programs/mrcc:$PATH
export PYTHON3=/comm/swstack/core/python/3.9.4/bin/python3

PS1="\[\e[32m\]\w\[\e[m\] $ "
# PS1="\[\033[32m\][\w]\[\033[m\] \[\033[36m\]$ \[\033[m\]"

# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# nvm use 17.1.0
