# server-script

This repository contains utility scripts for managing a server.


## Usage

Connect with ssh to your fresh server

```bash
ssh user@your-ip
```

Install git

```bash
sudo apt update
sudo apt install -y git
```

Clone this repository and then move to the directory

```bash
git clone https://github.com/flomSStaar/server-script.git
cd server-script
```

Configure the `server.conf` file as needed

```bash
nano server-server.conf
```

Run the `install` script as `root`

```bash
# For installing all the tools
./install --all

# You can adjust the tools to install
./install --common --docker --fail2ban --traefik --postgres --mariadb --uptime-kuma
```

After the installation, reboot the server

```
reboot
```

After the installation, you can remove the `server-script` directory

```bash
cd ..
rm -rf server-script
```

## Scripts

### install

This script installs all the scripts in this repository.

Usage: `./install -h`

### MariaDB

These scripts are for managing MariaDB databases in a Docker container.

- `mariadb-create`: Create a MariaDB database and user.
- `mariadb-drop`: Drop a MariaDB database and user.
- `mariadb-export`: Export a MariaDB database.
- `mariadb-import`: Import a MariaDB database.

### PostgreSQL

These scripts are for managing PostgreSQL databases in a Docker container.

- `postgres-create`: Create a PostgreSQL database and user.
- `postgres-drop`: Drop a PostgreSQL database and user.
- `postgres-export`: Export a PostgreSQL database.
- `postgres-import`: Import a PostgreSQL database.
