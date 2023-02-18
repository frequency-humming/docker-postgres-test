FROM postgres
ENV POSTGRES_USER admin
ENV POSTGRES_PASSWORD mypassword
ENV POSTGRES_DB test_db

COPY setup.sql /docker-entrypoint-initdb.d/

CMD ["postgres", "-c", "log_statement=all"]