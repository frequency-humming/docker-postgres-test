#!/bin/bash
set -e

# Assuming standard paths to PostgreSQL configuration files in the official Docker image
PG_CONF="/var/lib/postgresql/data/postgresql.conf"
PG_HBA="/var/lib/postgresql/data/pg_hba.conf"

# Enable SSL in postgresql.conf
echo "ssl = on" >> "$PG_CONF"
echo "ssl_cert_file = '/var/lib/postgresql/server.crt'" >> "$PG_CONF"
echo "ssl_key_file = '/var/lib/postgresql/server.key'" >> "$PG_CONF"
echo "log_connections = on" >> "$PG_CONF"
# Require SSL for all connections in pg_hba.conf
echo "hostssl all all 0.0.0.0/0 md5" >> "$PG_HBA"