#!/usr/bin/env bash

################################################################################
#
# Project Zomboid logging console.
#
################################################################################

# shellcheck disable=SC1091
source /lgsm_functions.bash
# shellcheck disable=SC1091
source /lgsm_variables.bash

fn_check_user
fn_check_lgsm_installed

declare LOG_DIR="${HOME}/log"
declare LOG_FILE="${LOG_DIR}/console/${LGSM_GAMESERVER}-console.log"

if [ -n "${LGSM_GAMESERVER_RENAME}" ]; then
    LOG_FILE="${LOG_DIR}/console/${LGSM_GAMESERVER_RENAME}-console.log"
fi

if [ "${LGSM_GAMESERVER_START}" != "true" ]; then
    exit 0
fi

# Wait for file creation
while [ ! -f "${LOG_FILE}" ]; do
    sleep 1
done

# Display logs
tail -f "${LOG_FILE}"
