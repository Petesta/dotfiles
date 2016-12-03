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
  'git'
  'python-software-properties'
  'tree'
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
  local ubuntu_release=($(lsb_release -r))

  if [[ $(printf "${ubuntu_release[1]} 12.10\n" | awk '{print ($1 < $2}') ]]; then
    sudo apt-get install -yf python-software-properties
  fi

  if [ ! grep -q 'webupd8team' /etc/apt/sources.list.d/* ]; then
    sudo add-apt-repository ppa:webupd8team/java
  fi

  read -t 5 -n 1 -p $'Which version of Java would you like to install? Enter number\n' java_version
  if [ $? -eq 0 ] || [[ $java_version == *[6-9]* ]]; then
    printf
    sudo apt-get install "oracle-java-${java_version}-installer"
  else
    sudo apt-get install oracle-java-8-installer
  fi
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

  if [ ! $(type -P java) ]; then
    install_java
  fi

  printf 'Finished setup\n'
}

function linux_setup() {
  if [[ $(type -P apt-get) && $(type -P yum) ]]; then
    prinf 'ERR: Both apt-get and yum are installed. Not sure which setup to run.'
    exit 1
  elif [ $(type -P apt-get) ]; then
    ubuntu_setup
  elif [ $(type -P yum) ]; then
    centos_setup
  else
    printf 'ERR: apt-get or yum are not installed. Not sure which setup to run.'
    exit 1
  fi
}

case $OSTYPE in
  darwin*)
    mac_setup
    ;;
  linux*)
    linux_setup
    ;;
  *)
    printf "ERR: Unrecognized operating system $OSTYPE\n"
    ;;
esac
