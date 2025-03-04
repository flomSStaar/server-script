info "Installing common packages"

apt-get install -y git curl wget vim htop unzip zip iproute2 ncdu ca-certificates locate sed cron > /dev/null

success "Common packages installed"

info "Configuring .bashrc for root user"

cat "$MODULES_DIR/common/bashrc" > /root/.bashrc

success "Configured .bashrc for root user"

info "Configuring hostname"

OLD_HOSTNAME=$(hostname)

info "Replacing hostname \"${OLD_HOSTNAME}\" with \"${SERVER_HOSTNAME}\""

hostnamectl set-hostname "${SERVER_HOSTNAME}"
sed -i "s/${OLD_HOSTNAME}/${SERVER_HOSTNAME}/g" /etc/hosts

success "Configured hostname: ${SERVER_HOSTNAME}"

info "Configuring timezone"

timedatectl set-timezone "${SERVER_TIMEZONE}"

success "Configured timezone: ${SERVER_TIMEZONE}"
