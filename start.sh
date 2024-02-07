#!/usr/bin/env bashio

if [ ! -f "/var/log/genmon.log" ]; then
  sudo touch /var/log/genmon.log
fi

if [ ! -d "/etc/genmon" ]; then
  sudo mkdir -p /etc/genmon
fi

if [ ! -f "/data/addon-firstun.lock" ]; then
  echo "Writing MQTT config..."
  MQTT_HOST=$(bashio::services mqtt "host")
  MQTT_USER=$(bashio::services mqtt "username")
  MQTT_PASSWORD=$(bashio::services mqtt "password")

  rm /data/conf/genmqtt.conf
  echo "[genmqtt]" >> /data/conf/genmqtt.conf
  echo "mqtt_address = ${MQTT_HOST}" >> /data/conf/genmqtt.conf
  echo "username = ${MQTT_USER}" >> /data/conf/genmqtt.conf
  echo "password = ${MQTT_PASSWORD}" >> /data/conf/genmqtt.conf
  echo "strlist_json = True" >> /data/conf/genmqtt.conf
  echo "flush_interval = 60" >> /data/conf/genmqtt.conf
  echo "blacklist = Run Time,Monitor Time,Generator Time,Platform Stats,Communication Stats" >> /data/conf/genmqtt.conf
  touch /data/addon-firstun.lock
fi

/app/genmon/startgenmon.sh -c /data/conf start && tail -F /var/log/genmon.log

