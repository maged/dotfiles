# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=10000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='\[\e[0;32m\]\u@\h\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$\[\e[m\] \[\e[1;37m\]'
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'
    LS_COLORS="di=33" 
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias l='ls -lh'
alias ll='ls -alF'
alias la='ls -A'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

set bell-style none
export VISUAL=vim
export EDITOR="$VISUAL"

# Custom git commands.
git() {
  if [[ $@ == "branch-sorted" ]]; then
    command git for-each-ref --sort=-committerdate refs/heads/ --format='%(color: red)%(committerdate:short) %(color: cyan)%(refname:short)' --color=always | less -r
  elif [[ $@ == "stash-list" ]]; then
    command git stash list --pretty=format:'%Cred%ar %Cblue%<(10)%gd %C(white)%s'
  elif [[ $@ == "add" ]]; then
    LAST_COMMAND=$(history | tail -n2 | head -n1)
    WORD_1=$(echo $LAST_COMMAND | awk '{print $2}')
    WORD_2=$(echo $LAST_COMMAND | awk '{print $3}')
    WORD_3=$(echo $LAST_COMMAND | awk '{print $4}')
    if [[ $WORD_1 == "git" && $WORD_2 == "diff" ]]; then
      command git add $WORD_3
    elif [[ $WORD_1 == "gd" ]]; then
      command git add $WORD_2
    fi
  elif [[ $@ == "review" ]]; then
    git_review()
  else
    command git "$@"
  fi
}

alias gd='git diff'
alias ga='git add'
alias gs='git status'
alias gp='git push'
alias gu='git pull'
alias gl='git log --graph --pretty='\''%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'\'
alias gds='git diff --staged'
alias gg='git grep -pnI --break'
alias ggi='git grep -ipnI --break'
alias gpt='git push --tags'
alias gu='git pull --rebase'
alias gs='git status'
alias gh='git stash'
alias ghp='git stash pop'
alias gcm='git commit -m'
alias gk='git checkout'
alias gr='git rebase'
alias gri='git rebase --interactive'
alias grc='git rebase --continue'
alias gts='git tag -l'
alias gta='git tag -a'


function ggsed() {
  PREV=$1;
  NEW=$2;
  echo "New: $NEW; Prev: $PREV"
  git grep "$PREV" | wc -l;
  git grep -l "$PREV" | xargs sed -i "s/$PREV/$NEW/g";
}

function ssh-pf() {
  CMD="ssh $1"
  shift
  for port in $@; do
    CMD="$CMD -L $port:localhost:$port "
  done
  echo "$CMD"
  eval "$CMD"
}

function git_review() {
  # Get a list of all files that have changed (not yet staged for commit)
  changed_files=$(git diff --name-only)
  
  # Check if there are no changed files
  if [ -z "$changed_files" ]; then
    echo "No changes detected."
    exit 0
  fi
  
  # Iterate over each file
  for file in $changed_files; do
      echo "Showing changes for: $file"
      # Show the file diff
      git diff "$file"
  
      # Ask the user if they want to add this file to the staging area
      read -p "Add this file to the staging area? (y/n/q) " answer
  
      case $answer in
          [Yy] ) git add "$file";;
          [Qq] ) echo "Exiting."; exit;;
          * ) echo "Skipping $file";;
      esac
  done
  
  echo "Finished processing all files."
}

export convoke=/Users/maged/code/convoke
