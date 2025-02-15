### Check if Docker is installed
check_docker_installed

### Create mariadb directory in services
info "Creating mariadb directory"
mkdir -p "$SERVICES_DIR/mariadb"

### Copy the compose.yml to /home/services
info "Copying mariadb compose file"
cp "$DIR/mariadb/compose.yml" "$SERVICES_DIR/mariadb"

### Create the mariadb secret file
info "Creating mariadb secret file, don't forget to set the password"
generate_password > "$SECRETS_DIR/mariadb"
chmod 600 "$SECRETS_DIR/mariadb"
info "Generated password for mariadb:"
echo -e "\t${YELLOW}$(cat "$SECRETS_DIR/mariadb")${NC}"

### Copy the mariadb scripts to /root/scripts
info "Copying mariadb scripts"
cp "$DIR/mariadb/mariadb-create" "$ROOT_SCRIPT_DIR"
cp "$DIR/mariadb/mariadb-drop" "$ROOT_SCRIPT_DIR"
cp "$DIR/mariadb/mariadb-import" "$ROOT_SCRIPT_DIR"
cp "$DIR/mariadb/mariadb-export" "$ROOT_SCRIPT_DIR"
success "Mariadb scripts copied"

### Link the mariadb scripts
info "Linking mariadb scripts"
ln -sf "$ROOT_SCRIPT_DIR/mariadb-create" /usr/local/bin
ln -sf "$ROOT_SCRIPT_DIR/mariadb-drop" /usr/local/bin
ln -sf "$ROOT_SCRIPT_DIR/mariadb-import" /usr/local/bin
ln -sf "$ROOT_SCRIPT_DIR/mariadb-export" /usr/local/bin
success "Mariadb scripts linked"

### Launch the mariadb container
info "Launching mariadb container"
docker compose -f "$SERVICES_DIR/mariadb/compose.yml" up -d
success "Mariadb setup complete"