#!/bin/bash

GREEN=$'\e[0;32m'
RED=$'\e[0;31m'

echoToFile() {
  printf "*$2*\n\n" >> $2
  printf "Author: $1\n\n" >> $2
  printf "License: Same terms as Vim itself (see |license|)\n\n" >> $2
  printf "INTRODUCTION:                                    *$plugin_name*\n" >> $2
}

vimTemplate() {
  echo 'What is the name of your Vim plugin? This will be used to generate a template.'
  read plugin_name
  echo 'Author name?'
  read author_name

  if [[ "$plugin_name" =~ ^[A-Za-z0-9-]+$ ]]
  then
    echo -e "$GREEN Generating Vim template for plugin creation."
    echo -e "$GREEN Running mkdir $plugin_name"
    mkdir $plugin_name
    echo -e "$GREEN Running: mkdir -p $plugin_name/autoload"
    mkdir -p $plugin_name/autoload

    echo -e "$GREEN Running: touch $plugin_name/autoload/$plugin_name.vim"
    touch $plugin_name/autoload/$plugin_name.vim
    echo -e "$GREEN Running: mkdir -p $plugin_name/doc"
    mkdir -p $plugin_name/doc
    echo -e "$GREEN Running: touch $plugin_name/doc/$plugin_name.txt"
    touch $plugin_name/doc/$plugin_name.txt
    echo -e "$GREEN Running: mkdir -p $plugin_name/plugin"
    mkdir -p $plugin_name/plugin

    echoToFile "$author_name" $plugin_name/doc/$plugin_name.txt

    echo -e "$GREEN Vim template creation for plugin $plugin_name complete!"
  else
    echo -e "$RED Plugin name should only include alphanumeric characters."
  fi
}

scalaTree () {
  echo 'What is the name of your Scala project?'
  read project_name

  if [[ "$project_name" = "${project_name%[[:space]]*}" ]]
  then
    mkdir project
    echo -e "$GREEN mkdir project"
    mkdir -p src/scala/$project_name
    echo -e "$GREEN mkdir -p src/scala/$project_name"

    touch build.sbt
    echo -e "$GREEN touch build.sbt";
    touch project/build.properties
    echo -e "$GREEN touch project/build.properties";
    touch project/build.sbt
    echo -e "$GREEN touch project/build.sbt";
  else
    echo -e "$RED Project name cannot contain whitespace characters!"
  fi
}
