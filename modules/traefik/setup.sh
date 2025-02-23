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
cp "$MODULES_DIR/traefik/compose.yml" "$SERVICES_DIR/traefik"

### Copy the compose.yml to SERVICES_DIR
info "Copying traefik configuration files"
cp "$MODULES_DIR/traefik/traefik.yml" "$SERVICES_DIR/traefik"

### Copy configuration files to SERVICES_DIR
info "Copying traefik configuration files to conf.d"
cp "$MODULES_DIR/traefik/traefik-basicauth.yml" "$SERVICES_DIR/traefik/conf.d"
cp "$MODULES_DIR/traefik/global-headers.yml" "$SERVICES_DIR/traefik/conf.d"
install -m 600 -o root -g root "$MODULES_DIR/traefik/acme.json" "$SERVICES_DIR/traefik/certs/acme.json"

### Configure Traefik with environment variables
info "Configuring Traefik ..."
sed -i "s/TRAEFIK_DASHBOARD_URL/${TRAEFIK_DASHBOARD_URL}/g" "$SERVICES_DIR/traefik/compose.yml"
sed -i "s/TRAEFIK_SSL_EMAIL/${TRAEFIK_SSL_EMAIL}/g" "$SERVICES_DIR/traefik/traefik.yml"
ESCAPED_AUTH=$(printf '%s\n' "$TRAEFIK_BASIC_AUTH" | sed 's/[&/\]/\\&/g')
sed -i "s/TRAEFIK_BASIC_AUTH/${ESCAPED_AUTH}/g" "$SERVICES_DIR/traefik/conf.d/traefik-basicauth.yml"

### Install and configure logrotate
info "Installing and configure logrotate for Traefik"
apt-get install -y logrotate > /dev/null
cp "$MODULES_DIR/traefik/logrotate" "/etc/logrotate.d/traefik"

### Create a network for Traefik
info "Creating docker network: traefik_proxy"
docker network create traefik_proxy > /dev/null
success "Docker network traefik_proxy created"

### Launch the traefik container
info "Launching traefik container"
docker compose -f "$SERVICES_DIR/traefik/compose.yml" up -d
success "Traefik setup complete"
