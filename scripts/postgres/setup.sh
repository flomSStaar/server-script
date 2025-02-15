### Create postgres directory in services
info "Creating postgres directory"
mkdir -p $SERVICES_DIR/postgres

### Copy the compose.yml to /home/services
info "Copying postgres compose file"
cp $DIR/postgres/compose.yml $SERVICES_DIR/postgres

### Create the postgres secret file
info "Creating postgres secret file, don't forget to set the password"
touch $SECRETS_DIR/postgres
chmod 600 $SECRETS_DIR/postgres

### Copy the postgres scripts to /root/scripts
info "Copying postgres scripts"
cp $DIR/postgres/postgres-create $ROOT_SCRIPT_DIR
cp $DIR/postgres/postgres-drop $ROOT_SCRIPT_DIR
cp $DIR/postgres/postgres-import $ROOT_SCRIPT_DIR
cp $DIR/postgres/postgres-export $ROOT_SCRIPT_DIR
success "Copied postgres scripts"

### Link the postgres scripts
info "Linking postgres scripts"
ln -sf "$ROOT_SCRIPT_DIR/postgres-create" /usr/local/bin
ln -sf "$ROOT_SCRIPT_DIR/postgres-drop" /usr/local/bin
ln -sf "$ROOT_SCRIPT_DIR/postgres-import" /usr/local/bin
ln -sf "$ROOT_SCRIPT_DIR/postgres-export" /usr/local/bin
success "Linked postgres scripts"
