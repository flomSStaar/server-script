info() {
  echo -e "\033[34m${1}\033[0m"
}

success() {
  echo -e "\033[32m${1}\033[0m"
}

error() {
  echo -e "\033[31m`basename $0`: ${1}\033[0m"
}

check_root() {
  if [ $EUID -ne 0 ]; then
    error "This script must be run as root"
    exit 1
  fi
}

check_docker_installed() {
  if ! command -v docker &> /dev/null; then
    error "Docker is not installed"
    exit 1
  fi
}

generate_password() {
  openssl rand -base64 32
}