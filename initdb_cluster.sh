sudo -u postgres /usr/bin/psql pthier -c 'select pg_kill_all_sessions('"'"'pthier'"'"','"'"'dpdb'"'"');'
sleep 1

sudo -u postgres /usr/bin/pg_ctl -D /run/postgres-data stop
sudo -u postgres bash -c "rm -r /run/postgres-data/*"
#sudo -u postgres rm -r /run/hecher/postgres-data/*
sudo -u postgres sudo mkdir -p /run/postgres-data/
sudo -u postgres sudo chown postgres /run/postgres-data/
sudo -u postgres sudo chgrp postgres /run/postgres-data/
sudo -u postgres sudo chmod 700 /run/postgres-data/

sudo -u postgres /usr/bin/initdb -D /run/postgres-data/
sudo -u postgres /usr/bin/pg_ctl -D /run/postgres-data/ start -o "--fsync=off --wal_level=minimal --synchronous_commit=off --archive_mode=off --max_wal_senders=0 --track_counts=off --autovacuum=off"
sudo -u postgres /usr/bin/psql postgres -c "create user pthier with password 'pthier';"
sudo -u postgres /usr/bin/createdb pthier
sudo -u postgres /usr/bin/psql pthier <<'EOF'
create or replace function pg_kill_all_sessions(db varchar, application varchar)
returns integer as
$$
begin
return (select count(*) from (select pg_catalog.pg_terminate_backend(pid) from pg_catalog.pg_stat_activity where pid <> pg_backend_pid() and datname = db and application_name = application) k);
end;
$$
language plpgsql security definer volatile set search_path = pg_catalog;

grant execute on function pg_kill_all_sessions(varchar,varchar) to pthier;
EOF
