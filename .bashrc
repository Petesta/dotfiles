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
  PS1='\[$RED\]\u \[$WHITE\]:: \[$RED\]λ \[$WHITE\]-> \[$RED\]\w$git_branch$NORMAL'
  if [ -d ~/.git-radar ]; then
    PS1="$PS1\$(git-radar --bash --fetch) "
  fi
else
  PS1='\u :: λ -> \w$git_branch '
fi

################################################################################
#                             Sourcing dotfiles
################################################################################

files=(
  '.aliases',
  '.exports',
  '.git_completion',
  '.functions',
  '.sources'
)

for file in "${files[@]}"; do
  [ -r "${file}" ] && [ -f "${file}" ] && . "${file}"
done; unset file
