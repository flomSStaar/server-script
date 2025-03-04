### Check if Docker is installed
check_docker_installed

### Create postgres directory in services
info "Creating minio directory"
mkdir -p "$SERVICES_DIR/minio"

### Copy the compose.yml to /home/services
info "Copying minio compose file"
cp "$MODULES_DIR/minio/compose.yml" "$SERVICES_DIR/minio"

### Copy minio configuration files
info "Copying minio configuration files"
cp "$MODULES_DIR/minio/minio.conf" "$SERVICES_DIR/minio"

### Configure minio
info "Configuring minio"
sed -i -E "s/^(MINIO_ROOT_USER=)(.*)$/\1${MINIO_ROOT_USER}/g" "$SERVICES_DIR/minio/minio.conf"
sed -i -E "s/^(MINIO_ROOT_PASSWORD=)(.*)$/\1${MINIO_ROOT_PASSWORD}/g" "$SERVICES_DIR/minio/minio.conf"

echo "MINIO_CONSOLE_DOMAIN=${MINIO_CONSOLE_DOMAIN}" > "$SERVICES_DIR/minio/.env"
echo "MINIO_API_DOMAIN=${MINIO_API_DOMAIN}" >> "$SERVICES_DIR/minio/.env"
echo "MINIO_BROWSER_REDIRECT_URL=\"https://\${MINIO_CONSOLE_DOMAIN}\"" >> "$SERVICES_DIR/minio/.env"

### Launch the minio container
info "Launching minio container"
docker compose -f "$SERVICES_DIR/minio/compose.yml" up -d
success "Minio setup complete"
