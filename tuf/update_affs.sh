#!/bin/bash
function finish {
    sync_unlock.sh
}
if [ -z "$TRAP" ]
then
  sync_lock.sh || exit -1
  trap finish EXIT
  export TRAP=1
fi
GHA2DB_PROJECT=tuf GHA2DB_CMDDEBUG=1 GHA2DB_LOCAL=1 GHA2DB_RESETIDB=1 PG_DB=tuf IDB_DB=tuf GHA2DB_METRICS_YAML=./metrics/tuf/metrics_affs.yaml GHA2DB_GAPS_YAML=./metrics/tuf/gaps_affs.yaml GHA2DB_TAGS_YAML=./metrics/tuf/tags_affs.yaml ./gha2db_sync
