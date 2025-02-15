### Check if Docker is installed
check_docker_installed

### Create traefik directory in services
info "Creating traefik directories"
mkdir -p "$SERVICES_DIR/traefik"
mkdir -p "$SERVICES_DIR/traefik/conf.d"
mkdir -p "$SERVICES_DIR/traefik/certs"
mkdir -p "/var/log/traefik"

### Copy the compose.yml to SERVICES_DIR
info "Copying traefik compose file"
cp "$DIR/traefik/compose.yml" "$SERVICES_DIR/traefik"

### Copy the compose.yml to SERVICES_DIR
info "Copying traefik configuration files"
cp "$DIR/traefik/traefik.yml" "$SERVICES_DIR/traefik"

### Copy configuration files to SERVICES_DIR
info "Copying traefik configuration files to conf.d"
cp "$DIR/traefik/traefik-basicauth.yml" "$SERVICES_DIR/traefik/conf.d"
cp "$DIR/traefik/global-headers.yml" "$SERVICES_DIR/traefik/conf.d"
install -m 600 -o root -g root "$DIR/traefik/acme.json" "$SERVICES_DIR/traefik/certs/acme.json"

### Configure Traefik with environment variables
info "Configuring Traefik ..."
sed -i -E "s/TRAEFIK_DASHBOARD_URL/${TRAEFIK_DASHBOARD_URL}/" "$SERVICES_DIR/traefik/compose.yml"
sed -i -E "s/TRAEFIK_SSL_EMAIL/${TRAEFIK_SSL_EMAIL}/" "$SERVICES_DIR/traefik/traefik.yml"
sed -i -E "s/TRAEFIK_BASIC_AUTH/${TRAEFIK_BASIC_AUTH}/" "$SERVICES_DIR/traefik/conf.d/traefik-basicauth.yml"

### Install and configure logrotate
info "Installing and configure logrotate for Traefik"
apt-get install -y logrotate > /dev/null
cp "$DIR/traefik/logrotate" "/etc/logrotate.d/traefik"

### Create a network for Traefik
info "Creating docker network: traefik_proxy"
docker network create traefik_proxy > /dev/null
success "Docker network traefik_proxy created"

### Launch the traefik container
info "Launching traefik container"
docker compose -f "$SERVICES_DIR/traefik/compose.yml" up -d
success "Traefik setup complete"
