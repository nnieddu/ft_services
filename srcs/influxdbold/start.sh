#!/bin/sh

# mkdir './data'
# mkdir './certs'

influxd -config ./influx.conf &

influx << EOF
CREATE DATABASES telegraf_metrics;
EOF

telegraf --config="./config.conf"
