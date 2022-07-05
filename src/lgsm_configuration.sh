#!/usr/bin/env bash

################################################################################
#
# Configure Project Zomboid.
#
################################################################################

# shellcheck disable=SC1091
source /lgsm_functions.bash
# shellcheck disable=SC1091
source /lgsm_variables.bash

fn_check_user
fn_check_lgsm_installed

cd "${HOME}" || exit 1

declare SERVER_INI_FILE="/home/linuxgsm/Zomboid/Server/${LGSM_GAMESERVER}.ini"

if [ -n "${LGSM_GAMESERVER_RENAME}" ]; then
    SERVER_INI_FILE="/home/linuxgsm/Zomboid/Server/${LGSM_GAMESERVER_RENAME}.ini"
fi

# Change LGSM configuration
if [ -f "${VAR_SERVER_CONFIG_FILE}" ]; then
    ips=($(hostname -I))
    fn_configure_variable "ip" "${ips[0]}"
    fn_configure_variable "adminpassword" "${ADMIN_PASSWORD}"
    fn_configure_variable "branch" "${SERVER_BRANCH}"
    fn_configure_variable "betapassword" "${SERVER_BETA_PASSWORD}"
fi

# Change server configuration
if [ -f "${SERVER_INI_FILE}" ]; then
    sed -ri "s/^DefaultPort=([0-9]+)$/DefaultPort=${SERVER_PORT}/" "${SERVER_INI_FILE}"
    sed -ri "s/^MaxPlayers=([0-9]+)$/MaxPlayers=${MAX_PLAYERS}/" "${SERVER_INI_FILE}"
    sed -ri "s/^Password=(.*)$/Password=${SERVER_PASSWORD}/" "${SERVER_INI_FILE}"
    sed -ri "s/^PauseEmpty=(.*)$/PauseEmpty=${PAUSE_ON_EMPTY}/" "${SERVER_INI_FILE}"
    sed -ri "s/^Public=(.*)$/Public=${SERVER_PUBLIC}/" "${SERVER_INI_FILE}"
    sed -ri "s/^PublicDescription=(.*)$/PublicDescription=${SERVER_PUBLIC_DESC}/" "${SERVER_INI_FILE}"
    sed -ri "s/^PublicName=(.*)$/PublicName=${SERVER_PUBLIC_NAME}/" "${SERVER_INI_FILE}"
    sed -ri "s/^PVP=(.*)$/PVP=${PVP}/" "${SERVER_INI_FILE}"
    sed -ri "s/^RCONPassword=(.*)$/RCONPassword=${RCON_PASSWORD}/" "${SERVER_INI_FILE}"
    sed -ri "s/^RCONPort=([0-9]+)$/RCONPort=${RCON_PORT}/" "${SERVER_INI_FILE}"
    sed -ri "s/^SaveWorldEveryMinutes=(.*)$/SaveWorldEveryMinutes=${AUTOSAVE_INTERVAL}/" "${SERVER_INI_FILE}"
    sed -ri "s/^SpawnPoint=(.*)$/SpawnPoint=${SPAWN_POINT}/" "${SERVER_INI_FILE}"
    sed -ri "s/^WorkshopItems=(.*)$/WorkshopItems=${MOD_WORKSHOP_IDS}/" "${SERVER_INI_FILE}"
fi
