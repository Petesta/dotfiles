#!/bin/bash

readonly DOTFILES_DIR=$(dirname $0)

declare -r COLORS="$DOTFILES_DIR/.colors"
declare -r FUNCTIONS="$DOTFILES_DIR/.functions"

if [[ -f $COLORS && -f $FUNCTIONS ]]; then
  . $COLORS
  . $FUNCTIONS
fi

declare -r ERR_SETUP='ERR: Setup needs to be run from within the dotfiles directory, exiting...'

if [[ $DOTFILES_DIR != '.' && ! -f $COLORS || ! -f $FUNCTIONS ]]; then
  printf "✖ $ERR_SETUP\n"
  exit 1
elif [[ $DOTFILES_DIR != '.' ]]; then
  p_error "$ERR_SETUP"
  exit 1
else
  p_note 'Dotfiles setup starting.'

  declare -ar FILES=($(find . -name '.*' -type f -exec basename {} ';'))

  for file in "${FILES[@]}"; do
    ln -sf "$DOTFILES_DIR/$file" "$HOME/$file"
    if [ $? -eq 0 ]; then
      p_success "Symlinking $file"
    else
      p_error "ERR: Symlinking $file"
    fi
  done; unset file

  p_note 'Dotfiles setup complete.'

  declare -r BASHRC="$HOME/.bashrc"

  p_note "Now sourcing $BASHRC"

  . $BASHRC
  if [ $? -eq 0 ]; then
    p_success "Done sourcing $BASHRC"
  else
    p_error "ERR: Problem sourcing $BASHRC"
  fi
fi
