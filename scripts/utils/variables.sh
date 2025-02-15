ROOT_SCRIPT_DIR="/root/scripts"
SECRETS_DIR="/root/secrets"
SERVICES_DIR="/home/services"

# Get the directory of the running script
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

export ROOT_SCRIPT_DIR
export SECRETS_DIR
export SERVICES_DIR
export DIR
