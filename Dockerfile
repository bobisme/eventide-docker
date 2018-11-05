FROM ruby:2.5-alpine3.8 as gems
RUN gem install evt-message_store-postgres-database --install-dir /gems

################################################################################
FROM postgres:9.6-alpine

COPY --from=gems /gems/gems/evt-message_store-postgres-database-*/database /dbscripts
COPY rundbscripts.sh /docker-entrypoint-initdb.d/

ENV PGDATA /data
# Run a postgres command that does nothing so initdb will trigger.
RUN docker-entrypoint.sh postgres --version
