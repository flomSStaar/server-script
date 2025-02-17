info "Installing common packages"

apt-get install -y git curl wget vim htop unzip zip iproute2 ncdu ca-certificates locate sed > /dev/null

success "Common packages installed"

info "Configuring .bashrc for root user"

cat "${DIR}/common/bashrc" > /root/.bashrc

success "Configured .bashrc for root user"
