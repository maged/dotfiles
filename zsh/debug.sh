# Set debug_mode to 1 to output debug message and profiling info
Z_DEBUG_MODE=0
Z_PROFILING=1

# log_debug <msg>
log_debug() {
  if ((Z_DEBUG_MODE == 1)) then
    echo $1
  fi
}

if ((Z_PROFILING == 1)) then
  # Setting seconds, start to type float to allow precise profiling.
  zmodload zsh/zprof
  typeset -F SECONDS start
fi

start_profiling() {
  start=$SECONDS
  log_debug "Starting profile at $start"
}

if (( Z_PROFILING == 1 )) then
  precmd_functions+=( start_profiling )
fi

# Helper functions to show all spectrum colors on the terminal
function spectrum_fg_ls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}
  for code in {000..255}; do
    print -P -- "$code: %K{007}%F{$code}${ZSH_SPECTRUM_TEXT}%f%k"
  done
}

# Helper function to show all spectrum colors on the terminal
function spectrum_bg_ls() {
  setopt localoptions nopromptsubst
  local ZSH_SPECTRUM_TEXT=%F{232}${ZSH_SPECTRUM_TEXT:-Arma virumque cano Troiae qui primus ab oris}%f
  for code in {000..255}; do
    print -P -- "$code: %K{$code}${ZSH_SPECTRUM_TEXT}%k"
  done
}
