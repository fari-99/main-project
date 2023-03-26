#!/bin/bash

applications=()
SUPPORT_CONTAINERS='proxy mailcatcher redis redis-management elasticsearch kibana rabbitmq sftp'
# MIGRATION_CONTAINERS='db-migration' # UNCOMMENT THIS FOR FIRST TIME SETUP
DATABASE_CONTAINERS='db-web db-postgres'
DESIGN_CONTAINERS=''
FAKER_CONTAINERS=''
API_GATEWAY='kong-database kong konga-prepare konga'
API_GATEWAT_FIRST_TIME='kong-migrate kong-migrate-up'

# this containers are project bounds ProjectName_CONTAINERS
WEB_CONTAINERS='go-api.fadhlan.loc graphql-engine.fadhlan.loc'
SearchProducts_CONTAINERS=""

# testing container
TEST_CONTAINERS='zookeeper kafka kafka-ui'