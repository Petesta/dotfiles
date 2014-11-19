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

HISTCONTROL=ignoredups:ignorespace
HISTSIZE=1000
HISTFILESIZE=2000

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

blue=$'\e[0;34m'
normal=$'\e[m'
red=$'\e[0;31m'
white=$'\e[1;37m'
PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

PS1='$red\]\u \[$white\]\[::$red\]\[ λ $white\]\[-> $red\]\w$git_branch \[\033[00m\]'

### Load aliases
if [ -f ~/.sh_aliases ]; then
   . ~/.sh_aliases
fi

### Load environment variables
if [ -f ~/.environment_variables ]; then
  . ~/.environment_variables
fi
