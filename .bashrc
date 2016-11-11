################################################################################
#                             Exports
################################################################################

export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

# Added by the Heroku Toolbelt
if [ -d /usr/local/heroku ]; then
  export PATH="/usr/local/heroku/bin:$PATH"
fi

# Postgres
if [ -d /Applications/Postgres.app/Contents/Versions/9.4 ]; then
  export PATH="/Applications/Postgres.app/Contents/Versions/9.4/bin:$PATH"
fi

# rbenv
if [ -d ~/.rbenv ]; then
  export PATH="$HOME/.rbenv/bin:$PATH"
  eval "$(rbenv init -)"
fi

# JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

# Default editor is Vim
export EDITOR=vim

# Colors on for all grep functions
export GREP_OPTIONS='--color=auto'

# FASD
eval "$(fasd --init auto)"

# Configurations for command `history`
HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%d/%m/%y %T "

# Append to the history file, don't overwrite it
shopt -s histappend

################################################################################
#                             Prompt
################################################################################

# Set the prompt
function find_git_branch {
  local dir=. head
  until [ "$dir" -ef / ]; do
    if [ -f "$dir/.git/HEAD" ]; then
      head=$(< "$dir/.git/HEAD")
      if [[ $head == ref:\ refs/heads/* ]]; then
        git_branch=" (${head#*/*/})"
      elif [[ $head != '' ]]; then
        git_branch=' (detached)'
      else
        git_branch=' (unknown)'
      fi
      return
    fi
    dir="../$dir"
  done
  git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Load up shell colors and define prompt
if [ -f ~/.sh_colors ]; then
  . ~/.sh_colors
  PS1='\[$RED\]\u \[$WHITE\]:: \[$RED\]\λ \[$WHITE\]-> \[$RED\]\w$git_branch $NORMAL'
else
  PS1='\u :: λ -> \w$git_branch '
fi

################################################################################
#                             Source Shell Files
################################################################################

# Load aliases
if [ -f ~/.sh_aliases ]; then
  . ~/.sh_aliases
fi

# Load user defined functions
if [ -f ~/.sh_functions ]; then
  . ~/.sh_functions
fi

# Load environment variables
if [ -f ~/.environment_variables ]; then
  . ~/.environment_variables
fi

# Git completion
if [ -f ~/.git_completion ]; then
  . ~/.git_completion
fi

# Highlighting of `man` pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Begin bold
export LESS_TERMCAP_me=$'\E[0m'           # End mode
export LESS_TERMCAP_se=$'\E[0m'           # End standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # Begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # End underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Begin underline
