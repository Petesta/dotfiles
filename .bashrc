export PATH="/usr/local/bin:/usr/local/sbin:$PATH"

### Added by the Heroku Toolbelt
export PATH="/usr/local/heroku/bin:$PATH"

### Cassandra
export PATH="/Users/Petesta/Downloads/apache-cassandra-2.0.7/bin:$PATH"

### JAVA_HOME
export JAVA_HOME=$(/usr/libexec/java_home)

### rbenv
export PATH="$HOME/.rbenv/bin:$PATH"
eval "$(rbenv init -)"

### FASD
eval "$(fasd --init auto)"

### Default editor is Vim
export EDITOR=vim

### Colors on for all grep functions
export GREP_OPTIONS='--color=auto'

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%d/%m/%y %T "

### Append to the history file, don't overwrite it
shopt -s histappend

### Set the prompt
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

### Load up shell colors
if [ -f ~/.sh_colors ]; then
  . ~/.sh_colors
fi

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

PS1='\[$RED\]\u \[$WHITE\]::\[$RED\]\[ λ $WHITE\]\[-> $RED\]\w$git_branch $NORMAL\]'

### Load aliases
if [ -f ~/.sh_aliases ]; then
  . ~/.sh_aliases
fi

### Load user defined functions
if [ -f ~/.sh_functions ]; then
  . ~/.sh_functions
fi

### Load environment variables
if [ -f ~/.environment_variables ]; then
  . ~/.environment_variables
fi

### Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

### PVM
if [ -f ~/utils/pvm/pvm.sh ]; then
  . ~/utils/pvm/pvm.sh
  [[ -r $PVM_DIR/bash_completion ]] && . $PVM_DIR/bash_completion
fi
