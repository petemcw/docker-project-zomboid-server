#!/usr/bin/env bash

################################################################################
#
# Project Zomboid bootstrap.
#
################################################################################

# shellcheck disable=SC1091
source /lgsm_functions.bash

fn_check_user

export LGSM_GAMESERVER="pzserver"
export LGSM_GAMESERVER_START="${SERVER_START:-true}"

if [ "${SERVER_NAME}" != "${LGSM_GAMESERVER}" ]; then
    export LGSM_GAMESERVER_RENAME="$(fn_sanitize_string "${SERVER_NAME}")"
fi

# Check that volume directories are writable
if [ ! -L /game-data ] || [ ! -w "$(readlink -fn /game-data)" ]; then
    printf "[ERROR] The game server data directory cannot be accessed. Check your permissions!\n"
    exit 1
fi

if [ ! -L /game-files ] || [ ! -w "$(readlink -fn /game-files)" ]; then
    printf "[ERROR] The game server files directory cannot be accessed. Check your permissions!\n"
    exit 1
fi
