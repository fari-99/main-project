#!/bin/bash

applications=()
SUPPORT_CONTAINERS='proxy mailcatcher redis redis-management elasticsearch kibana rabbitmq sftp'
# MIGRATION_CONTAINERS='db-migration' # UNCOMMENT THIS FOR FIRST TIME SETUP
DATABASE_CONTAINERS='db-web db-postgres'
DESIGN_CONTAINERS=''
FAKER_CONTAINERS=''

# this containers are project bounds ProjectName_CONTAINERS
WEB_CONTAINERS='go-api.fadhlan.loc graphql-engine.fadhlan.loc'
SearchProducts_CONTAINERS=""

# testing container
TEST_CONTAINERS='zookeeper kafka kafka-ui'

CONTAINER_LISTS="$CORE_CONTAINERS "
CONTAINER_LISTS+="$SUPPORT_CONTAINERS "
CONTAINER_LISTS+="$DESIGN_CONTAINERS "
CONTAINER_LISTS+="$FAKER_CONTAINERS "
CONTAINER_LISTS+="$DATABASE_CONTAINERS "
CONTAINER_LISTS+="$TEST_CONTAINERS "
CONTAINER_LISTS+="$WEB_CONTAINERS "