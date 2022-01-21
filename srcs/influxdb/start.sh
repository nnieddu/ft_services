#!/bin/sh

influxd -config ./influx.conf &

influx < "CREATE DATABASES telegraf_metrics;"

telegraf --config="./config.conf"
