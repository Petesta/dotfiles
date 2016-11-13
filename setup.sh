#!/bin/bash

readonly DIR=$(dirname $0)

declare -a files

if [[ $DIR != '.' ]]; then
  echo 'ERR: Setup needs to be run from within the dotfiles directory, exiting...'
  exit 1
fi

echo 'Dotfiles setup starting.'

files+=($(find . -name '.*' -type f -exec basename {} ';'))

for $file in "${files[@]}"; do
  ln -sf "$DIR/$file" "$HOME/$file"
done

echo 'Dotfiles setup complete.'
