#!/usr/bin/env bash

set -euo pipefail

###############################################################################
# CONFIGURATION
###############################################################################

WEB_ROOT="/var/www/html"
LOCAL_FILE="index.html"
TARGET_FILE="${WEB_ROOT}/index.html"

WEB_SERVICE="nginx"

###############################################################################
# HELPER FUNCTIONS
###############################################################################

log() {
  # Simple logger with timestamp
  local msg
  msg=$(printf "[%s] %s\n" "$(date +'%Y-%m-%dT%H:%M:%S')" "$*")
  echo "$msg" >&2
  echo "$msg" >> deploy.log
}

fail() {
  log "ERROR: $*"
  exit 1
}

###############################################################################
# PRECHECKS
###############################################################################

[ -f "${LOCAL_FILE}" ] || fail "Local file '${LOCAL_FILE}' not found in current directory"
command -v sudo >/dev/null 2>&1 || fail "'sudo' not available"
command -v systemctl >/dev/null 2>&1 || fail "'systemctl' not available"
[ -d "${WEB_ROOT}" ] || fail "Web root directory '${WEB_ROOT}' does not exist"

###############################################################################
# DEPLOYMENT STEPS
###############################################################################

deploy() {
  log "Starting deployment of '${LOCAL_FILE}' to '${TARGET_FILE}'"

  sudo cp "${LOCAL_FILE}" "${TARGET_FILE}"
  
  sudo chmod 644 "${TARGET_FILE}"
  
  sudo systemctl restart "${WEB_SERVICE}"

  echo "http://localhost/"
}

###############################################################################
# ENTRYPOINT
###############################################################################

if [ -z "${1:-}" ]; then
  deploy
elif [ "$1" = "-d" ] || [ "$1" = "--dry" ]; then
  echo "sudo cp '${LOCAL_FILE}' '${TARGET_FILE}'"
  echo "sudo chmod 644 '${TARGET_FILE}'"
  echo "sudo systemctl restart '${WEB_SERVICE}'"
  echo "echo 'http://localhost/'"
else
  echo "Usage:"
  echo "  $0         # deploy"
  echo "  $0 -d      # dry-run"
  echo "  $0 --dry   # dry-run"
  exit 1
fi