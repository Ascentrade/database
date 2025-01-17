FROM postgres:17-alpine

COPY ./sql/00-init.sql /docker-entrypoint-initdb.d/
