### Check if Docker is installed
check_docker_installed

### Create uptime-kuma directory in services
info "Creating uptime-kuma directory"
mkdir -p "$SERVICES_DIR/uptime-kuma"

### Copy the compose.yml to SERVICES_DIR
info "Copying uptime-kuma compose file"
cp "$MODULES_DIR/uptime-kuma/compose.yml" "$SERVICES_DIR/uptime-kuma"

### Configuring uptime-kuma
info "Configuring uptime-kuma"
sed -i "s/UPTIME_KUMA_URL/${UPTIME_KUMA_URL}/" "$SERVICES_DIR/uptime-kuma/compose.yml"

### Launch the uptime-kuma container
info "Launching uptime-kuma container"
docker compose -f "$SERVICES_DIR/uptime-kuma/compose.yml" up -d
success "Uptime-kuma setup complete"
