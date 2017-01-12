#!/bin/bash

declare -r DOTFILES_GITHUB_URL='https://github.com/Petesta/dotfiles.git'

declare -ar MAC_PACKAGES=(
  'ack'
  'awsebcli'
  'ctags-exuberant'
  'elasticsearch17'
  'git'
  'imagemagick'
  'leiningen'
  'node'
  'packer'
  'rbenv'
  'redis'
  'sbt'
  'scala'
  'tree'
  'vim'
  'watch'
)

declare -ar CENTOS_PACKAGES=(
  'git'
  'ImageMagick'
  'tree'
  'vim'
)

declare -ar UBUNTU_PACKAGES=(
  'ack-grep'
  'bc'
  'exuberant-ctags'
  'git'
  'postgresql'
  'postgresql-contrib'
  'python-software-properties'
  'redis-server'
  'sbt'
  'scala'
  'tree'
  'vim'
)

function generate_ssh_for_github() {
  local -r ssh_dir="$HOME/.ssh"
  if [ ! -d $ssh_dir ]; then
    mkdir $ssh_dir
  fi
  if [ -n "$(find "$HOME/.ssh" -name id_rsa*)" ]; then
    ssh-keygen -t rsa -b 4096 -C 'iPetesta@gmail.com'
    eval "$(ssh-agent -s)"
    ssh-add "$HOME/.ssh/id_rsa"
  fi
}

function clone_dotfiles() {
  local -r git_dir="$HOME/Git"
  local -r dotfiles_dir=$(basename $DOTFILES_GITHUB_URL)
  if [[ ! -d $git_dir && ${dotfiles_dir%.*} ]]; then
    mkdir $git_dir
    git clone $DOTFILES_GITHUB_URL $git_dir
  fi
}

function install_xcode() {
  if [ ! xcode-select --print-path &> /dev/null ]; then
    xcode-select --install &> /dev/null

    until [ xcode-select --print-path &> /dev/null ]; do
      sleep 5
    done

    printf 'Install Xcode command line tools\n'

    sudo xcode-select -switch /Applications/Xcode.app/Contents/Developer
    printf 'Make `xcode-select` developer directory point to Xcode\n'

    sudo xcodebuild -license
    printf 'Agree with the Xcode command line tools license\n'
  fi
}

function uninstall_brew() {
  if [ $(type -p brew) ]; then
    printf 'Uninstalling `brew`\n'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  fi
}

function install_brew() {
  if [ ! $(type -p brew) ]; then
    printf 'Installing `brew`.\n'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  fi
}

function mac_setup() {
  printf 'Beginning Mac setup\n'

  install_brew
  if [ ! $? -eq 0 ]; then
    printf 'ERR: Installing `brew`\n'
    exit 1
  fi
  brew update

  for package in "${MAC_PACKAGES[@]}"; do
    brew install $package
    if [ ! $? -eq 0 ]; then
      printf "ERR: Installing package $package\n"
    fi
  done; unset package
}

function centos_setup() {
  printf 'Beginning Centos setup\n'
  sudo yum update

  for package in "${CENTOS_PACKAGES[@]}"; do
    sudo yum install -y $package
    if [ ! $? -eq 0 ]; then
      printf "ERR: Installing package $package\n"
    fi
  done; unset package
}

function install_java() {
  local -r ubuntu_release=($(lsb_release --release))
  local java_version

  if [[ $(printf "${ubuntu_release[1]} 12.10\n" | awk '{print ($1 < $2)}') ]]; then
    sudo apt-get install --fix-broken --yes python-software-properties
  fi

  if [ ! grep -q 'webupd8team' /etc/apt/sources.list.d/* ]; then
    sudo add-apt-repository --yes ppa:webupd8team/java
  fi

  read -t 5 -n 1 -s -p $'Which version of Java would you like to install? Enter number\n' java_version
  if [ $? -eq 0 ] && [[ $java_version == *[6-9]* ]]; then
    printf "Installing oracle-java-${java_version}-installer\n"
    sudo apt-get install --fix-broken --yes "oracle-java-${java_version}-installer"
  else
    printf 'Installing oracle-java-8-installer\n'
    sudo apt-get install --fix-broken --yes oracle-java-8-installer
  fi
}

function ubuntu_setup() {
  printf 'Beginning Ubuntu setup\n'
  sudo apt-get update

  for package in "${UBUNTU_PACKAGES[@]}"; do
    sudo apt-get --fix-broken --yes install $package
    if [ ! $? -eq 0 ]; then
      printf "ERR: Installing package $package\n"
    fi
  done; unset package

  if [ ! $(type -p java) ]; then
    install_java
  fi
}

function linux_setup() {
  if [[ $(type -p apt-get) && $(type -p yum) ]]; then
    prinf 'ERR: Both apt-get and yum are installed. Not sure which setup to run.\n'
    exit 1
  elif [ $(type -p apt-get) ]; then
    ubuntu_setup
  elif [ $(type -p yum) ]; then
    centos_setup
  else
    printf 'ERR: apt-get or yum are not installed. Not sure which setup to run.\n'
    exit 1
  fi
}

declare -r SETUP_OS_DOTFILE="$HOME/${0%.*}"

if [ -f $SETUP_OS_DOTFILE ]; then
  printf "You have already run the $0 script. Exiting..."
  exit 0
else
  printf "Running $0 script: $(date)\n" >> $SETUP_OS_DOTFILE

  case $OSTYPE in
    darwin*)
      mac_setup
      ;;
    linux*)
      linux_setup
      ;;
    *)
      printf "ERR: Unrecognized operating system $OSTYPE\n"
      exit 1
      ;;
  esac

  clone_dotfiles
  generate_ssh_for_github

  cd "$HOME/Git/dotfiles"
  ./setup_symlinks.sh
fi
