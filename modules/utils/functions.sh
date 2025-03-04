RED="\033[0;31m"
GREEN="\033[0;32m"
WHITE="\033[0;37m"
YELLOW="\033[0;33m"
NC="\033[0m"

info() {
  echo -e "${WHITE}${1}${NC}"
}

success() {
  echo -e "${GREEN}${1}${NC}"
}

warning() {
  echo -e "${YELLOW}${1}${NC}"
}

error() {
  echo -e "${RED}$(basename "$0"): ${1}${NC}"
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
  openssl rand -hex 32
}