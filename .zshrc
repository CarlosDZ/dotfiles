# ============================
#  History Configuration
# ============================
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000

setopt APPEND_HISTORY
setopt SHARE_HISTORY
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_REDUCE_BLANKS
setopt HIST_SAVE_NO_DUPS
setopt HIST_VERIFY

# ============================
#   ENV File Setup
# ============================
set -a
source ~/.env
set +a

# ============================
#  Snowl ZSH Configuration
# ============================

# Kittys startup message
if [[ "$TERM" == "xterm-kitty" ]]; then
  /bin/cat "$HOME/.config/kitty/bigshot.txt"
  echo
fi

# Completion Enabled
autoload -Uz compinit
compinit

# Autosuggestions Enabled
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

# Syntax highlighting Enabled
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# FZF integration
[ -f /usr/share/fzf/key-bindings.zsh ] && source /usr/share/fzf/key-bindings.zsh
[ -f /usr/share/fzf/completion.zsh ] && source /usr/share/fzf/completion.zsh

# ============================
#  Personal alias hehe
# ============================

alias ls='ls --color=auto'
alias ssh-on='sudo systemctl start sshd'
alias ssh-off='sudo systemctl stop sshd'
alias mongo-cedh='mongosh mongodb+srv://$CEDHWEB_USER:$CEDHWEB_PASSWORD@cluster0.en3l1.mongodb.net/test?appName=Cluster0'

# ==============================================
#  Personal functions (and some overwrites too)
# ==============================================

# Overwrite cat to try and fix the command prompt apearing just after the text
cat() {
  /bin/cat "$@"
  echo
}

# Port lookup
portprocess() {
  if [[ -z "$1" ]]; then
    echo "WRONG || Uso: portprocess <PORT>"
    return 1
  fi
  lsof -i :"$1"
}

# I always forget that -9 is the flag to kill a process anyway soooo
hardkill() {
  if [[ -z "$1" ]]; then
    echo "WRONG || Uso: hardkill <PID>"
    return 1
  fi
  kill -9 "$1"
}

# ============================
#  Env Variables
# ============================

export NVM_DIR="$HOME/.nvm"
[[ -s "/usr/share/nvm/init-nvm.sh" ]] && source "/usr/share/nvm/init-nvm.sh"

export PATH="$PATH:$HOME/.local/bin"

# ============================
#  Prompt
# ============================

parse_git_branch() {
  local branch
  branch=$(git symbolic-ref --short HEAD 2>/dev/null)

  if [[ -n "$branch" ]]; then
    echo "$branch "
  fi
}

setopt prompt_subst

# I liiiike colors and knowing my fucking git branch
PROMPT='%F{46}(%n@%m %F{21}%~%F{46})%f $(parse_git_branch)>> '


# Load Angular CLI autocompletion.
source <(ng completion script)
