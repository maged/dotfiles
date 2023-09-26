export ZSH_HOME=$HOME/dotfiles/zsh

# Clear all previous hooks to start fresh
precmd_functions=()

# Set global options for debug, profiling of zsh.
source $ZSH_HOME/debug.sh

# External plugins without the plugin manager
source $ZSH_HOME/zsh-auto-notify/auto-notify.plugin.zsh
source $ZSH_HOME/zsh-autocomplete/zsh-autocomplete.plugin.zsh

# History options
setopt APPEND_HISTORY
HISTSIZE=120000
SAVEHIST=100000
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS

# Load autocomplete
autoload -Uz compinit && compinit
autoload -Uz vcs_info

# Arrow keys to naviate history
bindkey '\e[A' history-search-backward
bindkey '\e[B' history-search-forward

# zsh-autocomplete options
# Go to menu first
bindkey '\t' menu-select "$terminfo[kcbt]" menu-select
bindkey -M menuselect '\t' menu-complete "$terminfo[kcbt]" reverse-menu-complete
zstyle -e ':autocomplete:*:*' list-lines '5'
zstyle ':autocomplete:*:*' list-lines '5'

# Limit number of lines shown by default

# Set default editor
export VISUAL=vim
export EDITOR=$VISUAL

# Prompt
# Add git info to prompt
# Only enable for git for now
zstyle ':vcs_info:*' enable git

precmd_vcs_info() {
  log_debug 'Running vcs_info'
  vcs_info
  BASE_PROMPT="${vcs_info_msg_0_}"
}

zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr '%F{2}●%f'
zstyle ':vcs_info:git:*' unstagedstr '%F{red}●%f'

BRANCH_STYLE="%F{232}%K{007}%b%k"

zstyle ':vcs_info:git:*' branch_style '%F{015}%K{252}%b%k'
zstyle ':vcs_info:git:*' formats "%u %c ${BRANCH_STYLE}"
# todo: use constants for colors
zstyle ':vcs_info:git:*' actionformats '%u %c ${BRANCH_STYLE}  %F{7}[%F{1}%a%F{5}%F{7}]%f'

precmd_functions+=( precmd_vcs_info )

zle-line-init(){
  # This method runs after the precmd and before user input.
  # Use it for profiling and setting RPROMPT.
  time=$(printf '%.3f' $(( $SECONDS - $start )))
  if ((time > 0.15 || Z_DEBUG_MODE == 1)) then
    RPROMPT='%F{088}[precmd: $time s]%f $BASE_PROMPT'
  else
    RPROMPT=$BASE_PROMPT
  fi
}

zle -N zle-line-init

# Expand the prompt
setopt prompt_subst

PS1='%F{033}%~%f %F{028}$%f '

# Notification settings (added through auto-notify plugin)
export AUTO_NOTIFY_TITLE="Done: %command"
export AUTO_NOTIFY_BODY="Command completed in %elapsed seconds with exit code %exit_code"
# No bell
unsetopt beep

# Alias-es

# Add color support to common commands
alias ls='ls --color=auto'
LS_COLORS="di=33"
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

# ls aliases
alias ll='ls -alF'
alias la='ls -A'

# git aliases
git() {
  # custom git method to define new sub-commands
  if [[ $@ == "branch-sorted" ]]; then
    
    # Sorts recently used branches
    command git for-each-ref --sort=-committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)' --color=always | less -r
  elif [[ $@ == "stash-list" ]]; then
    # Better formatted stash list
    command git stash list --pretty=format:'%Cred%ar %Cblue%<(10)%gd %C(white)%s'
  elif [[ $@ == "add" ]]; then
    # Raw 'git add' takes the last diff'd file
    LAST_COMMAND=$(history | tail -n2 | head -n1)
    WORD_1=$(echo $LAST_COMMAND | awk '{print $2}')
    WORD_2=$(echo $LAST_COMMAND | awk '{print $3}')
    WORD_3=$(echo $LAST_COMMAND | awk '{print $4}')
    if [[ $WORD_1 == "git" && $WORD_2 == "diff" ]]; then
      command git add $WORD_3
    elif [[ $WORD_1 == "gd" ]]; then
      command git add $WORD_2
    fi
  else
    command git "$@"
  fi
}

# Python3 aliases
alias python='python3'
alias pip='pip3'
