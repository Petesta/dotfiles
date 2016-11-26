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

# Load up shell colors and define prompt
if [ -f ~/.sh_colors ]; then
  . ~/.sh_colors
  if [ -d ~/.git-radar ]; then
    PS1='\[$RED\]\u \[$WHITE\]:: \[$RED\]λ \[$WHITE\]-> \[$RED\]\w\[$NORMAL\]'
    PS1="$PS1\$(git-radar --bash --fetch) "
  else
    PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"
    PS1='\[$RED\]\u \[$WHITE\]:: \[$RED\]λ \[$WHITE\]-> \[$RED\]\w$git_branch\[$NORMAL\] '
  fi
else
  PS1='\u :: λ -> \w$git_branch '
fi

################################################################################
#                             Sourcing dotfiles
################################################################################

for file in ~/.{aliases,colors,exports,git_completion,functions,sources}; do
  [ -r $file ] && . $file
done; unset file
