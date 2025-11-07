#### Bash It

# If not running interactively, don't do anything
case $- in
  *i*) ;;
    *) return;;
esac

# Path to the bash it configuration
export BASH_IT="${HOME}/.bash_it"

# Lock and Load a custom theme file.
# Leave empty to disable theming.
# location /.bash_it/themes/
export BASH_IT_THEME='bobby'

# (Advanced): Change this to the name of your remote repo if you
# cloned bash-it with a remote other than origin such as `bash-it`.
# export BASH_IT_REMOTE='bash-it'

# Your place for hosting Git repos. I use this for private repos.
export GIT_HOSTING='git@git.domain.com'

# Don't check mail when opening terminal.
unset MAILCHECK

# Change this to your console based IRC client of choice.
export IRC_CLIENT='irssi'

# Set this to the command you use for todo.txt-cli
export TODO='t'

# Set this to false to turn off version control status checking within the prompt for all themes
export SCM_CHECK=true

# Set Xterm/screen/Tmux title with only a short hostname.
# Uncomment this (or set SHORT_HOSTNAME to something else),
# Will otherwise fall back on $HOSTNAME.
# export SHORT_HOSTNAME=$(hostname -s)

# Set Xterm/screen/Tmux title with only a short username.
# Uncomment this (or set SHORT_USER to something else),
# Will otherwise fall back on $USER.
# export SHORT_USER=${USER:0:8}

# Set Xterm/screen/Tmux title with shortened command and directory.
# Uncomment this to set.
# export SHORT_TERM_LINE=true

# Set vcprompt executable path for scm advance info in prompt (demula theme)
# https://github.com/djl/vcprompt
# export VCPROMPT_EXECUTABLE=~/.vcprompt/bin/vcprompt

# (Advanced): Uncomment this to make Bash-it reload itself automatically
# after enabling or disabling aliases, plugins, and completions.
# export BASH_IT_AUTOMATIC_RELOAD_AFTER_CONFIG_CHANGE=1

# Uncomment this to make Bash-it create alias reload.
# export BASH_IT_RELOAD_LEGACY=1

# Load Bash It
source "$BASH_IT"/bash_it.sh

#### Aliases

# Custom
alias rmdots="find . -name \"*.swp\" -exec rm -rf {} \\;"
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
alias lolls='ls | lolcat'
alias pyserver='python -m http.server'
alias json2xml='yq -p json -o xml'
alias json2yml='yq -p json -o yaml'
alias xml2json='yq -p xml -o json'
alias xml2yml='yq -p xml -o yaml'
alias yml2json='yq -p yaml -o json'
alias yml2xml='yq -p yaml -o xml'

# Unix commands
alias cp='cp -iv'
alias ll='ls -al'
alias ln='ln -iv'
alias ls='ls -FGlAhp'
alias mkdir='mkdir -pv'
alias mv='mv -iv'

# Ruby
alias be='bundle exec'

# IP addresses
alias localip="ipconfig getifaddr en0"

# Typos
alias c='clear'
alias claer='clear'
alias clera='clear'
alias im='vim'
alias rpsec='rspec'

#### Export

# Default editor Vim
export EDITOR=vim

# Tell grep to highlight matches
export GREP_OPTIONS='—color=auto'

# Terminal history
export HISTCONTROL=ignorespace:ignoredups
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTTIMEFORMAT="%d/%m/%y %T "

# Highlighting of `man` pages
export LESS_TERMCAP_mb=$'\E[01;31m'       # Begin blinking
export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # Begin bold
export LESS_TERMCAP_me=$'\E[0m'           # End mode
export LESS_TERMCAP_se=$'\E[0m'           # End standout-mode
export LESS_TERMCAP_so=$'\E[38;5;246m'    # Begin standout-mode - info box
export LESS_TERMCAP_ue=$'\E[0m'           # End underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m' # Begin underline

export LC_ALL=${LC_ALL:-en_US.UTF-8}
export LANG=${LANG:-en_US.UTF-8}

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Disable Homebrew analytics
if [ ! -f $XDG_CONFIG_HOME/homebrew/brew.env ]; then
  export HOMEBREW_NO_ANALYTICS=1
fi

#### shopt

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

function urlencode() {
  local args="$@"
  jq -nr --arg v "$args" '$v|@uri'
}

function weather() {
  curl -s "https://wttr.in/${1:-Cupertino}?m2F&format=v2"
}

function y() {
  local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
  yazi "$@" --cwd-file="$tmp"
  if cwd="$(command cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
    builtin cd -- "$cwd"
  fi
  rm -f -- "$tmp"
}

if command -v pipenv 1>/dev/null 2>&1; then
  eval "$(_PIPENV_COMPLETE=bash_source pipenv)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(~/.rbenv/bin/rbenv init - bash)"
fi

if command -v fzf 1>/dev/null 2>&1; then
  eval "$(fzf --bash)"
fi

if command -v zoxide 1>/dev/null 2>&1; then
  eval "$(zoxide init bash)"
fi

if command -v jj 1>/dev/null 2>&1; then
  source <(jj util completion bash)
fi

if command -v uv 1>/dev/null 2>&1; then
  eval "$(uv generate-shell-completion bash)"
fi

if command -v kubectl 1>/dev/null 2>&1; then
  source <(kubectl completion bash)
fi

if command -v helm 1>/dev/null 2>&1; then
  source <(helm completion bash)
fi
