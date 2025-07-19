FROM m0ngr31/genmon:weekly-2025-07-16

# Update the genmon.conf file to use the TCP serial for ESP32 devices
#RUN sed -i 's/use_serial_tcp = False/use_serial_tcp = True/g' /data/conf/genmon.conf
#RUN sed -i 's/serial_tcp_port = 8899/serial_tcp_port = 6638/g' /data/conf/genmon.conf
#RUN echo "update_check = false" >> /app/genmon/conf/genmon.conf

# Update MQTT default config
#RUN sed -i 's/strlist_json = False/strlist_json = True/g' /data/conf/genmqtt.conf
#RUN sed -i 's/flush_interval = 0/flush_interval = 60/g' /data/conf/genmqtt.conf
#RUN sed -i 's/blacklist = Monitor,Run Time,Monitor Time,Generator Time,External Data/blacklist = Run Time,Monitor Time,Generator Time,Platform Stats,Communication Stats/g' /data/conf/genmqtt.conf

RUN apt-get update && apt-get install -y --no-install-recommends \
        bash \
        jq \
        tzdata \
        curl \
        ca-certificates \
        xz-utils \
    && apt-get clean \
    && mkdir -p /usr/src/bashio \
    && curl -L -f -s "https://github.com/hassio-addons/bashio/archive/v0.16.2.tar.gz" \
        | tar -xzf - --strip 1 -C /usr/src/bashio \
    && mv /usr/src/bashio/lib /usr/lib/bashio \
    && ln -s /usr/lib/bashio/bashio /usr/bin/bashio

# Configure startup script
COPY start.sh /app/start.sh
RUN chmod +x /app/start.sh

