#!/bin/bash

applications=()
CORE_CONTAINERS='go-api db-web'
SUPPORT_CONTAINERS='proxy mailcatcher redis elasticsearch kibana fluentd rabbitmq rabbitmq-management sftp'
#MIGRATION_CONTAINERS='db-migration' # UNCOMMENT THIS FOR FIRST TIME SETUP
DESIGN_CONTAINERS=''
FAKER_CONTAINERS=''