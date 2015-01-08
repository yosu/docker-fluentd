#
# fluentd Dockerfile
#
FROM debian:wheezy

# install td-agent
ADD http://packages.treasuredata.com/GPG-KEY-td-agent /tmp/
RUN apt-key add /tmp/GPG-KEY-td-agent && \
    echo "deb http://packages.treasuredata.com/2/debian/wheezy/ wheezy contrib" > /etc/apt/sources.list.d/treasure-data.list && \
    DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y --no-install-recommends \
    adduser td-agent && \
    rm -rf /var/lib/apt/lists/*

# expose ports
EXPOSE 24224

# defines td-agent entrypoint
ENV TD_RUN /usr/sbin/td-agent

# defines config file path
ENV TD_CONFIG /etc/td-agent/td-agent.conf

# defines fluentd embedded tools directory
ENV TD_EMBEDDED_BIN /opt/td-agent/embedded/bin

ENTRYPOINT $TD_RUN
