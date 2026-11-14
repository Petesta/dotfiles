typeset -U path fpath

export LANG=${LANG:-en_US.UTF-8}

export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Cache tool init/completion output; regenerate only when the binary changes.
_zcache_dir="$XDG_CACHE_HOME/zsh"
_zcomp_dir="$_zcache_dir/completions"
[[ -d $_zcomp_dir ]] || mkdir -p "$_zcomp_dir"
fpath=("$_zcomp_dir" $fpath)

# _cached <outfile> <cmd> [args...]
_cached() {
  local out=$1; shift
  local bin=${commands[$1]}
  [[ -n $bin ]] || return 1
  local real=${bin:A} stamp
  [[ -r $out.stamp ]] && read -r stamp < "$out.stamp"
  if [[ ! -s $out || $stamp != $real || $real -nt $out ]]; then
    "$@" >| "$out" 2>/dev/null && print -r -- "$real" >| "$out.stamp"
  fi
}

# Completions are written to fpath before compinit and autoloaded on demand.
_cached "$_zcomp_dir/_uv" uv generate-shell-completion zsh
_cached "$_zcomp_dir/_uvx" uvx --generate-shell-completion zsh
_cached "$_zcomp_dir/_kubectl" kubectl completion zsh
_cached "$_zcomp_dir/_helm" helm completion zsh

autoload -Uz compinit
compinit -d "$_zcache_dir/zcompdump"
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'r:|=*' 'l:|=* r:|=*'

# History
HISTFILE="$HOME/.zsh_history"
HISTSIZE=50000
SAVEHIST=10000
setopt EXTENDED_HISTORY HIST_EXPIRE_DUPS_FIRST HIST_IGNORE_DUPS HIST_IGNORE_SPACE HIST_VERIFY SHARE_HISTORY

# Directories & misc
setopt AUTO_CD AUTO_PUSHD PUSHD_IGNORE_DUPS PUSHD_MINUS INTERACTIVE_COMMENTS

# Key bindings: emacs mode; Up/Down search history by the typed prefix
bindkey -e
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey '^[[A' up-line-or-beginning-search
bindkey '^[[B' down-line-or-beginning-search

export EDITOR='vim'
export EZA_CONFIG_DIR="$XDG_CONFIG_HOME/eza"
export PYTHONSTARTUP=$HOME/.pythonrc.py
export RIPGREP_CONFIG_PATH="$HOME/.ripgreprc"

# Highlighting of `man` pages
export LESS_TERMCAP_mb=$'\e[01;32m'
export LESS_TERMCAP_md=$'\e[01;36m'
export LESS_TERMCAP_me=$'\e[0m'
export LESS_TERMCAP_se=$'\e[0m'
export LESS_TERMCAP_so=$'\e[01;33m'
export LESS_TERMCAP_ue=$'\e[0m'
export LESS_TERMCAP_us=$'\e[01;31m'

if [[ ! -f $XDG_CONFIG_HOME/homebrew/brew.env ]]; then
  export HOMEBREW_NO_ANALYTICS=1
fi

alias cp='cp -iv'
alias du='du -h'
alias ln='ln -iv'
alias ls='ls -FGlAh'
alias mkdir='mkdir -pv'
alias mv='mv -iv'
alias localip='ipconfig getifaddr en0'
alias rmdots="find . -type f -name '*.swp' -delete"
alias now='date +"%T"'
alias nowdate='date +"%Y-%m-%d"'
alias pyserver='python -m http.server'

alias c='clear'
alias claer='clear'
alias clera='clear'

alias l='eza --all --group --icons --header'
alias ll='eza --long --all --icons --header'
alias lg='eza --long --all --group --icons --header'
alias lt='eza --long -all --group --header --icons --tree'
alias ltree='eza --long -all --group --header --icons --tree --level=2'

alias lolls='ls | lolcat'

alias node_globals='npm list -g --depth=0'

alias json2xml='yq -p json -o xml'
alias json2yml='yq -p json -o yaml'
alias xml2json='yq -p xml -o json'
alias xml2yml='yq -p xml -o yaml'
alias yml2json='yq -p yaml -o json'
alias yml2xml='yq -p yaml -o xml'

alias -s csv='csvlens --color-columns'
alias -s json='fx'
alias -s md='bat'
alias -s txt='bat'

urlencode() {
  local args="$@"
  jq -nr --arg v "$args" '$v|@uri'
}

weather() {
  curl -s "https://wttr.in/${1:-Cupertino}?m2F&format=v2"
}

y() {
  local tmp cwd
  tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return
  yazi "$@" --cwd-file="$tmp"
  cwd="$(command cat -- "$tmp")"
  rm -f -- "$tmp"
  if [[ -n $cwd && $cwd != "$PWD" ]]; then
    builtin cd -- "$cwd" || return
  fi
}

f() { fzf --bind 'enter:become(printf %s {} | pbcopy)' }

ff() {
  fzf --border-label ' Files ' --header-label ' File Type ' \
    --preview 'fzf-preview.sh {}' \
    --bind 'ctrl-/:change-preview-window(down|hidden|)' \
    --bind 'focus:transform-preview-label:[[ -n {} ]] && printf " Previewing [%s] " {}' \
    --bind 'focus:+transform-header:file --brief {} || echo "No file selected"' \
    "$@"
}

fv() { fzf --walker file,follow --bind 'enter:become(vim {})' }

# rbenv
_cached "$_zcache_dir/rbenv.zsh" rbenv init - --no-rehash zsh && source "$_zcache_dir/rbenv.zsh"

# fzf
export FZF_DEFAULT_OPTS_FILE="$XDG_CONFIG_HOME/fzf/fzfrc"

export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix --hidden --follow --exclude .git'

export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND -X eza -1 --icons=always --color=always --no-quotes"

export FZF_CTRL_T_OPTS="
  --ansi
  --accept-nth 2..
  --border-label ' Files '
  --header-label ' File Type '
  --preview 'fzf-preview.sh {2..}'
  --bind 'ctrl-/:change-preview-window(down|hidden|)'
  --bind 'focus:transform-preview-label:[[ -n {2..} ]] && printf \" Previewing [%s] \" {2..}'
  --bind 'focus:+transform-header:file --brief {2..} || echo \"No file selected\"'"

export FZF_CTRL_R_OPTS="
  --bind 'ctrl-y:execute-silent(echo -n {2..} | pbcopy)+abort'
  --header 'CTRL-Y: copy to clipboard'"

export FZF_ALT_C_OPTS="
  --walker-skip .git,node_modules,target
  --preview 'tree -C {}'"

_cached "$_zcache_dir/fzf.zsh" fzf --zsh && source "$_zcache_dir/fzf.zsh"

# fzf-git
[[ -r $XDG_CONFIG_HOME/fzf-git/fzf-git.sh ]] && source "$XDG_CONFIG_HOME/fzf-git/fzf-git.sh"

# jj dynamic completions (after compinit; uses compdef)
COMPLETE=zsh _cached "$_zcache_dir/jj.zsh" jj && source "$_zcache_dir/jj.zsh"

# zoxide (after compinit)
_cached "$_zcache_dir/zoxide.zsh" zoxide init zsh && source "$_zcache_dir/zoxide.zsh"

unset _zcomp_dir

path=(/Applications/Postgres.app/Contents/Versions/15/bin(N) $path)

# SDKMAN: put candidates on PATH now, load the slow `sdk` function on first use.
export SDKMAN_DIR="$HOME/.sdkman"
if [[ -s $SDKMAN_DIR/bin/sdkman-init.sh ]]; then
  path=($SDKMAN_DIR/candidates/*/current/bin(N) $path)
  [[ -d $SDKMAN_DIR/candidates/java/current ]] && export JAVA_HOME="$SDKMAN_DIR/candidates/java/current"
  sdk() {
    unfunction sdk
    source "$SDKMAN_DIR/bin/sdkman-init.sh"
    sdk "$@"
  }
fi

# Starship prompt
_cached "$_zcache_dir/starship.zsh" starship init zsh --print-full-init && source "$_zcache_dir/starship.zsh"

# Starship fit
[[ -r $XDG_CONFIG_HOME/starship-fit.zsh ]] && source "$XDG_CONFIG_HOME/starship-fit.zsh"

# Ghostty shell integration
if [[ -n "$GHOSTTY_RESOURCES_DIR" ]]; then
  source "$GHOSTTY_RESOURCES_DIR/shell-integration/zsh/ghostty-integration"
fi

# Must be last.
_zsh_hl="${HOMEBREW_PREFIX:-/opt/homebrew}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ -r $_zsh_hl ]] && source "$_zsh_hl"
unset _zsh_hl
