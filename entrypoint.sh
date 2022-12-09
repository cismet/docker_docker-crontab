#!/bin/sh

[ -z "${CRONTAB_FILE}" ] && CRONTAB_FILE="/crontab"
[ -z "${CRONTABS_DIR}" ] && CRONTABS_DIR="/crontabs"
[ -z "${TMP_CRONTAB}" ] && TMP_CRONTAB="/tmp/crontab"

touch "${TMP_CRONTAB}"

if [ -f "${CRONTAB_FILE}" ]; then
  echo "loading crontab ${CRONTAB_FILE}"
  cat "${CRONTAB_FILE}" <(echo) >> "${TMP_CRONTAB}"
fi

if [ -d "${CRONTABS_DIR}" ]; then
  for CRONTAB_FILE in $(find "${CRONTABS_DIR}" -type f); do
    echo "loading crontab ${CRONTAB_FILE}"
    cat "${CRONTAB_FILE}" <(echo) >> "${TMP_CRONTAB}"
  done
fi

if [ ! -z "${CRONTAB}" ]; then
  echo "loading crontab from environment variable CRONTAB"
  cat <(echo "${CRONTAB}") <(echo) >> "${TMP_CRONTAB}"
fi

/usr/bin/crontab "${TMP_CRONTAB}"

echo "=========="
grep '\S' "${TMP_CRONTAB}"
echo "=========="

/usr/sbin/crond -l 2  -f