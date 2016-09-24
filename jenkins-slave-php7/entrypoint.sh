#!/bin/bash

/etc/init.d/mysql start
sleep 5
/etc/init.d/redis-server start
sleep 5
/etc/init.d/mongodb start

exec $@