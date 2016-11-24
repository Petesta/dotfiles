#!/bin/bash

readonly DIR=$(dirname $0)

declare -r colors="$DIR/.colors"
declare -r functions="$DIR/.functions"

if [[ -f $colors && -f $functions ]]; then
  . $colors
  . $functions
fi

if [[ $DIR != '.' && ! -f $colors || ! -f $functions ]]; then
  printf  'ERR: Setup needs to be run from withing the dotfiles directory'
  exit 1
elif [[ $DIR != '.' ]]; then
  p_error 'ERR: Setup needs to be run from within the dotfiles directory, exiting...'
  exit 1
else
  p_note 'Dotfiles setup starting.'

  declare -a files=($(find . -name '.*' -type f -exec basename {} ';'))

  for file in "${files[@]}"; do
    ln -sf "$DIR/$file" "$HOME/$file"
    if [ $? -eq 0 ]; then
      p_success "Symlinking $file"
    else
      p_error "ERR: symlinking $file"
    fi
  done; unset file

  p_note 'Dotfiles setup complete.'

  declare -r bashrc="$HOME/.bashrc"

  p_note "Now sourcing $bashrc"

  . "$bashrc"
  if [ $? -eq 0 ]; then
    p_success "Done sourcing $bashrc"
  else
    p_error "ERR: Problem sourcing $bashrc"
  fi
fi
