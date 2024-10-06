# Set PATH, MANPATH, etc., for Homebrew.
if [[ $(uname -m) == 'arm64' ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi
