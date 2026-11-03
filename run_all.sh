#!/usr/bin/env bash
# Creates library_db, loads the data and runs every query file.
# Usage: ./run_all.sh            (uses: mysql -u root -p)
#        MYSQL="sudo mysql" ./run_all.sh
MYSQL=${MYSQL:-"mysql -u root -p"}
set -e
for f in library-management/01_schema.sql library-management/02_seed_data.sql \
         library-management/03_queries.sql library-management/04_views.sql db-lab-exercises/*.sql; do
  echo "===== $f ====="
  $MYSQL --table < "$f"
done
