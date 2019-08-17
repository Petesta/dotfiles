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
export TODO="t"

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

#### alias

# Custom
alias rmdots="find . -name \"*.swp\" -exec rm -rf {} \\;"

# Unix commands
alias cp='cp -iv'
alias ll='ls -al'
alias ls='ls -FGlAhp'
alias mkdir='mkdir -p'
alias mv='mv -iv'

# Colorize grep commands
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'
alias grep='grep --color=auto'

# Ruby
alias be='bundle exec'

# IP addresses
alias localip='ipconfig getifaddr en0'

# Typos
alias c='clear'
alias claer='clear'
alias clera='clear'
alias im='vim'
alias rpsec='rspec'

#### export

# Default editor Vim
export EDITOR=vim

# Terminal history
export HISTCONTROL=ignoredups:ignorespace
export HISTSIZE=5000
export HISTFILESIZE=5000
export HISTTIMEFORMAT='%d/%m/%y %T '

## Highlighting of `man` pages

# Begin blinking
export LESS_TERMCAP_mb=$'\E[01;31m'

# Begin bold
export LESS_TERMCAP_md=$'\E[01;38;5;74m'

# End mode
export LESS_TERMCAP_me=$'\E[0m'

# End standout-mode
export LESS_TERMCAP_se=$'\E[0m'

# Begin standout-mode - info box
export LESS_TERMCAP_so=$'\E[38;5;246m'

# End underline
export LESS_TERMCAP_ue=$'\E[0m'

# Begin underline
export LESS_TERMCAP_us=$'\E[04;38;5;146m'

# Disable Homebrew analytics
export HOMEBREW_NO_ANALYTICS=1

#### shopt

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

if command -v pipenv 1>/dev/null 2>&1; then
  eval "$(pipenv --completion)"
fi

if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

if command -v rbenv 1>/dev/null 2>&1; then
  eval "$(rbenv init -)"
fi
