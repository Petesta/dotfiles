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

### Load up Git completion
source ~/.git-completion.sh 2>/dev/null

BABY_BLUE=$'\e[1;34m'
BLUE=$'\e[0;34m'
BLUE_GREEN=$'\e[1;32m'
GREEN=$'\e[0;32m'
NORMAL=$'\e[00m'
RED=$'\e[0;31m'
WHITE=$'\e[1;37m'

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000
HISTTIMEFORMAT="%d/%m/%y %T "

### Append to the history file, don't overwrite it
shopt -s histappend

### Colors on for all grep functions
export GREP_OPTIONS='--color=auto'

### Extract compressed files
extract () {
  if [ -f $1 ]; then
    case $1 in
      *.tar.bz2) tar xvjf $1   ;;
      *.tar.gz)  tar xvzf $1   ;;
      *.bz2)     bunzip2 $1    ;;
      *.rar)     unrar x $1    ;;
      *.gz)      gunzip $1     ;;
      *.tar)     tar xvf $1    ;;
      *.tbz2)    tar xvjf $1   ;;
      *.tgz)     tar xvzf $1   ;;
      *.zip)     unzip $1      ;;
      *.Z)       uncompress $1 ;;
      *.7z)      7z x $1       ;;
      *)         echo "Don't know how to extract '$1'..." ;;
    esac
  else
    echo "'$1' is not a valid file!"
  fi
}

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

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

PS1='\[$RED\]\u \[$WHITE\]::\[$RED\]\[ λ $WHITE\]\[-> $RED\]\w$git_branch $NORMAL\]'

### Load aliases
if [ -f ~/.sh_aliases ]; then
  . ~/.sh_aliases
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
