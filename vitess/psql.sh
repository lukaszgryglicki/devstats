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
set -o pipefail
> errors.txt
> run.log
GHA2DB_PROJECT=vitess IDB_DB=vitess PG_DB=vitess GHA2DB_LOCAL=1 ./structure 2>>errors.txt | tee -a run.log || exit 1
GHA2DB_PROJECT=vitess IDB_DB=vitess PG_DB=vitess GHA2DB_LOCAL=1 ./gha2db 2015-01-01 0 today now 'vitessio,youtube/vitess' 2>>errors.txt | tee -a run.log || exit 2
GHA2DB_PROJECT=vitess IDB_DB=vitess PG_DB=vitess GHA2DB_LOCAL=1 GHA2DB_EXACT=1 GHA2DB_OLDFMT=1 ./gha2db 2014-01-02 0 2014-12-31 23 'vitessio,youtube/vitess' 2>>errors.txt | tee -a run.log || exit 3
GHA2DB_PROJECT=vitess IDB_DB=vitess PG_DB=vitess GHA2DB_LOCAL=1 GHA2DB_MGETC=y GHA2DB_SKIPTABLE=1 GHA2DB_INDEX=1 ./structure 2>>errors.txt | tee -a run.log || exit 4
./vitess/setup_repo_groups.sh 2>>errors.txt | tee -a run.log || exit 5
./vitess/import_affs.sh 2>>errors.txt | tee -a run.log || exit 6
./vitess/setup_scripts.sh 2>>errors.txt | tee -a run.log || exit 7
./vitess/get_repos.sh 2>>errors.txt | tee -a run.log || exit 8
echo "All done. You should run ./vitess/reinit.sh script now."
