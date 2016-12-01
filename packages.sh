# Brew (brew install)
declare -ar MAC_PACKAGES=(
  'ack'
  'awsebcli' # aws-elasticbeanstalk, awscli
  'ctags'
  'elasticsearch17'
  'git'
  'imagemagick' # freetype, jpeg, libpng, libtiff, libtool, xz
  'leiningen'
  'node'
  'rbenv' # autoconf, openssl, pkg-config, ruby-build
  'redis'
  'sbt'
  'scala'
  'tree'
  'vim'
)

# Apt (sudo apt-get install)
declare -ar UBUNTU_PACKAGES=(
  'ack-grep'
  'git'
  'vim'
)

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
  if [ $(type -P brew) ]; then
    printf 'Uninstalling `brew`\n'
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/uninstall)"
  fi
}

function install_brew() {
  if [ ! $(type -P brew) ]; then
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

  printf 'Finished setup\n'
}

function ubuntu_setup() {
  printf 'Beginning Ubuntu setup\n'
  sudo apt-get update

  for package in "${UBUNTU_PACKAGES[@]}"; do
    sudo apt-get -yf install $package
    if [ ! $? -eq 0 ]; then
      printf "ERR: Installing package $package\n"
    fi
  done; unset package

  printf 'Finished setup\n'
}

case $OSTYPE in
  darwin*)
    mac_setup
    ;;
  linux*)
    ubuntu_setup
    ;;
  *)
    printf "ERR: Unrecognized operating system $OSTYPE\n"
    ;;
esac
