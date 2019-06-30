#!/usr/bin/env bash

# Error codes
E_ILLEGAL_ARGS=126

usage() {
  echo ""
  echo "Starting a Counter Strike Global Offensive dedicated server."
  echo ""
  echo "  -i: Initialize and install the CS Global Offensive application"
  echo "  -s: Start a dedicated server."
  echo "      It is required to export a GSLT=YOUR-GSLT-TOKEN environment variable"
  echo ""
}

init() {
  ${STEAM_CMD_DIR}/steamcmd.sh +login anonymous +force_install_dir ${STEAM_CSGO_DIR} +app_update ${STEAM_CSGO_APP_ID} validate +quit
}

start(){
  ${STEAM_CSGO_DIR}/srcds_run \
     -net_port_try 1 \
     -game csgo \
     -usercon \
     +game_type 0 \
     +game_mode 1 \
     +mapgroup mg_bomb \
     +map de_dust2 \
     +sv_setsteamaccount "${GSLT}"  
}

# Evaluate arguments for build script.
if [[ "${#}" == 0 ]]; then
  usage
  exit ${E_ILLEGAL_ARGS}
fi

# Evaluate arguments for build script.
while getopts "is" flag; do
  case ${flag} in
    i)
      init
      ;;
    s)
      start
      ;;
    *)
      usage
      exit ${E_ILLEGAL_ARGS}
      ;;
  esac
done

# Strip of all remaining arguments
shift $((OPTIND - 1));

# Check if there are remaining arguments
if [[ "${#}" -gt 0 ]]; then
  echo "Error: To many arguments: ${*}."
  usage
  exit ${E_ILLEGAL_ARGS}
fi