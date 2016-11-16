#!/bin/bash

readonly DIR=$(dirname $0)

if [[ $DIR != '.' ]]; then
  echo 'ERR: Setup needs to be run from within the dotfiles directory, exiting...'
  exit 1
fi

echo 'Dotfiles setup starting.'

declare -a files

files+=($(find . -name '.*' -type f -exec basename {} ';'))

for file in "${files[@]}"; do
  ln -sf "$DIR/$file" "$HOME/$file"
done; unset file

echo 'Dotfiles setup complete.'

declare -r bashrc="$HOME/.bashrc"

echo "Now sourcing $bashrc"

. "$bashrc"

echo "Done sourcing $bashrc"
