### Install fail2ban
info "Installing fail2ban"
apt-get install -y fail2ban > /dev/null

### Copy fail2ban configuration files
info "Copying fail2ban configuration files"
cp "$DIR/fail2ban/ignoreip.conf" /etc/fail2ban/jail.d
cp "$DIR/fail2ban/sshd.conf" /etc/fail2ban/jail.d
cp "$DIR/fail2ban/ipv6.conf" /etc/fail2ban/fail2ban.d

### Configure fail2ban
info "Configure fail2ban"
sed -i "s/FAIL2BAN_IGNORE_IPS/$(echo "$FAIL2BAN_IGNORE_IPS" | sed 's/\//\\\//g')/g" /etc/fail2ban/jail.d/ignoreip.conf

### Activate fail2ban at boot
info "Activating fail2ban at boot"
systemctl enable fail2ban.service

### Restart fail2ban
info "Restarting fail2ban"
systemctl restart fail2ban

### Check fail2ban status
info "Checking fail2ban status"
systemctl status fail2ban --no-pager

### Check fail2ban-client status
info "Checking fail2ban-client status"
fail2ban-client status

success "Fail2ban setup complete"
