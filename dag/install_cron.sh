#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

ROOT_DIR=$(pwd)
CRON_LINE="30 21 * * * TZ=Asia/Shanghai /bin/bash -lc 'cd ${ROOT_DIR} && ./dag/run_daily.sh' >> ${ROOT_DIR}/run_daily.log 2>&1"

# install cron line if not already present
(crontab -l 2>/dev/null || true) | grep -F "${CRON_LINE}" >/dev/null || (
  (crontab -l 2>/dev/null || true; echo "${CRON_LINE}") | crontab -
)

echo "Installed cron entry:\n${CRON_LINE}"
