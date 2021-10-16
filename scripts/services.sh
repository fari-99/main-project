#!/bin/bash

applications=()
CORE_CONTAINERS='go-api.fadhlan.loc db-web '
SUPPORT_CONTAINERS='proxy mailcatcher redis redis-management elasticsearch kibana rabbitmq sftp'
# MIGRATION_CONTAINERS='db-migration' # UNCOMMENT THIS FOR FIRST TIME SETUP
DESIGN_CONTAINERS=''
FAKER_CONTAINERS=''