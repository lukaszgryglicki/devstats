#!/bin/bash
make || exit 1
./grafana/influxdb_recreate.sh test
#GHA2DB_SKIPPDB=1 GHA2DB_CMDDEBUG=2 GHA2DB_DEBUG=1 GHA2DB_RESETIDB=1 GHA2DB_METRICS_YAML=devel/test_metrics.yaml GHA2DB_GAPS_YAML=devel/test_gaps.yaml GHA2DB_TAGS_YAML=devel/test_tags.yaml GHA2DB_LOCAL=1 PG_DB=gha IDB_DB=test ./gha2db_sync
GHA2DB_SKIPPDB=1 GHA2DB_CMDDEBUG=1 GHA2DB_DEBUG=1 GHA2DB_RESETIDB=1 GHA2DB_METRICS_YAML=devel/test_metrics.yaml GHA2DB_GAPS_YAML=devel/test_gaps.yaml GHA2DB_TAGS_YAML=devel/test_tags.yaml GHA2DB_LOCAL=1 PG_DB=gha IDB_DB=test ./gha2db_sync
