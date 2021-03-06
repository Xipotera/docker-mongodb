#!/bin/bash
set -Eeuo pipefail

if [ "$MONGO_INITDB_ROOT_USERNAME" ] && [ "$MONGO_INITDB_ROOT_PASSWORD" ]; then
  "${mongo[@]}" -u "$MONGO_INITDB_ROOT_USERNAME" -p "$MONGO_INITDB_ROOT_PASSWORD" --authenticationDatabase "$MONGO_INITDB_DATABASE" <<-EOJS
  db.createUser({
     user: $(_js_escape "$MONGO_INITDB_USERNAME"),
     pwd: $(_js_escape "$MONGO_INITDB_PASSWORD"),
     roles: [ { role: 'readWrite', db: $(_js_escape "$MONGO_INITDB_DATABASE") } ]
  })
EOJS
fi

echo ======================================================
echo created user: $(_js_escape "$MONGO_INITDB_USERNAME") in database $(_js_escape "$MONGO_INITDB_DATABASE")
echo ======================================================
