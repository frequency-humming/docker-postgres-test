FROM --platform=linux/amd64 postgres

# Copy your SSL certificate and key into the container
COPY ./server.crt /var/lib/postgresql/server.crt
COPY ./server.key /var/lib/postgresql/server.key

RUN chown -R postgres:postgres /var/lib/postgresql/data
RUN chmod 700 /var/lib/postgresql/data
# Make sure the key file is accessible by postgres
RUN chown postgres:postgres /var/lib/postgresql/server.crt /var/lib/postgresql/server.key
RUN chmod 600 /var/lib/postgresql/server.key
RUN chmod 644 /var/lib/postgresql/server.crt

ENV POSTGRES_USER admin
ENV POSTGRES_PASSWORD mypassword
ENV POSTGRES_DB test_db

COPY ./enable_ssl.sh /docker-entrypoint-initdb.d/
COPY setup.sql /docker-entrypoint-initdb.d/

