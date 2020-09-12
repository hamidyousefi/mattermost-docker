FROM    debian:10.5-slim
LABEL   maintainer="Hamid Yousefi <contact@hamidyousefi.com>"
ARG     MATTERMOST_VERSION=5.26.2
ENV     MATTERMOST_FILENAME=mattermost-team-${MATTERMOST_VERSION}-linux-amd64.tar.gz \
        DB_DRIVER=postgres \
        DB_HOSTNAME=mattermost.db \
        DB_PORT=5432 \
        DB_USERNAME=mattermost \
        DB_PASSWORD=mattermost \
        DB_NAME=mattermost
ENV     DATA_SOURCE=${DB_DRIVER}://${DB_USERNAME}:${DB_PASSWORD}@${DB_HOSTNAME}:${DB_PORT}/${DB_NAME}?sslmode=disable\\&connect_timeout=10
WORKDIR /opt
ADD     https://releases.mattermost.com/${MATTERMOST_VERSION}/${MATTERMOST_FILENAME} .
RUN     tar -xf ${MATTERMOST_FILENAME} \
 &&     rm ${MATTERMOST_FILENAME} \
 &&     cd mattermost \
 &&     mkdir ./data \
 &&     chmod -R g+w /opt/mattermost \
 &&     sed -i "s|\"DriverName\": \"mysql\"|\"DriverName\": \"${DB_DRIVER}\"|g" /opt/mattermost/config/config.json \
 &&     sed -i -e "s|\"DataSource\": .*|\"DataSource\": \"${DATA_SOURCE}\",|g" /opt/mattermost/config/config.json
EXPOSE  8065
ENTRYPOINT /opt/mattermost/bin/mattermost
