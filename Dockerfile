FROM ghcr.io/petemcw/linuxgsm

# environment
LABEL org.opencontainers.image.source https://github.com/petemcw/docker-project-zomboid-server
LABEL maintainer="petemcw@petemcw.dev"
ENV \
    ADMIN_PASSWORD="pzserver-password" \
    AUTOSAVE_INTERVAL="0" \
    MAX_PLAYERS="10" \
    MOD_WORKSHOP_IDS="" \
    PAUSE_ON_EMPTY="true" \
    PLAYER_PORTS=16262-16272 \
    PVP="true" \
    RCON_PASSWORD="rcon-password" \
    RCON_PORT=27015 \
    SERVER_BETA_PASSWORD="" \
    SERVER_BRANCH="" \
    SERVER_NAME="pzserver" \
    SERVER_PASSWORD="" \
    SERVER_PORT=16261 \
    SERVER_PUBLIC_DESC="" \
    SERVER_PUBLIC_NAME="Project Zomboid Server" \
    SERVER_PUBLIC="false" \
    SPAWN_POINT="0,0,0"

# packages & configure
USER root
RUN \
    echo "**** install runtime packages ****" && \
    DEBIAN_FRONTEND=noninteractive apt-get update --quiet && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
        openjdk-16-jre \
        rng-tools && \
    echo "**** creating directories ****" && \
    [ -d /home/linuxgsm/Zomboid ] || mkdir -p /home/linuxgsm/Zomboid && \
    [ -d /home/linuxgsm/serverfiles ] || mkdir -p /home/linuxgsm/serverfiles && \
    ln -s /home/linuxgsm/Zomboid /game-data && \
    ln -s /home/linuxgsm/serverfiles /game-files && \
    chown -R "${PUID}":"${PGID}" /home/linuxgsm/ && \
    echo "**** cleanup ****" && \
    apt-get clean && \
    rm -rf \
        /tmp/* \
        /var/lib/apt/lists/* \
        /var/tmp/*

# copy root filesystem
COPY ./src /
USER linuxgsm

# external
VOLUME [ "/game-data", "/game-files" ]
EXPOSE \
    8766:8766/udp \
    8767:8767/udp \
    ${SERVER_PORT}/udp \
    ${PLAYER_PORTS} \
    ${RCON_PORT}
