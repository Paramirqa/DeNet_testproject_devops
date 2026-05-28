#!/bin/sh

echo "Waiting for PostgreSQL..."

until pg_isready -h postgres -U "$POSTGRES_USER" -d "$POSTGRES_DB"; do
  echo "DB not ready, sleeping..."
  sleep 2
done

echo "PostgreSQL is ready"

exec "$@"