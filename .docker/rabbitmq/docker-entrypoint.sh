#!/bin/bash

set -e

HOSTNAME=`env hostname`

echo $RABBITMQ_ERLANG_COOKIE > /var/lib/rabbitmq/.erlang.cookie
chmod 400 /var/lib/rabbitmq/.erlang.cookie

# If not clustered then start it normally as if it is a single server.
if [ -z "$RABBITMQ_CLUSTER_WITH" ]; then
  /usr/local/bin/docker-entrypoint.sh rabbitmq-server &
  rabbitmqctl wait /var/lib/rabbitmq/mnesia/rabbit\@$HOSTNAME.pid
  tail -f /dev/null
else
  if [ -z "$RABBITMQ_CLUSTER_WITH" ]; then
    # If clustered, but cluster with is not specified then again 
    # start normally, could be the first server in the cluster
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server &
    rabbitmqctl wait /var/lib/rabbitmq/mnesia/rabbit\@$HOSTNAME.pid
    tail -f /dev/null
  else
    /usr/local/bin/docker-entrypoint.sh rabbitmq-server &
    rabbitmqctl wait /var/lib/rabbitmq/mnesia/rabbit\@$HOSTNAME.pid
    rabbitmqctl stop_app
    if [ -z "$RABBITMQ_RAM_NODE" ]; then
      rabbitmqctl join_cluster rabbit@$RABBITMQ_CLUSTER_WITH
    else
      rabbitmqctl join_cluster --ram rabbit@$RABBITMQ_CLUSTER_WITH
    fi
    rabbitmqctl start_app
    
    # Tail to keep the a foreground process active..
    tail -f /dev/null
  fi
fi