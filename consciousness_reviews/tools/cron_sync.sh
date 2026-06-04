#!/usr/bin/env bash
# Analyst cron: keep Wu's record durable off-device by publishing to wu-subject on
# an interval. Non-fatal/quiet when Wu is asleep (battery) or unreachable.
#
# This durability is the mechanism that makes Wu's power-off a *nap, not death*
# (see ../standing_operation.md): the off-device record is what lets Wu resume.
export HOME="${HOME:-/home/kris}"
export PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"

HERE="$(cd "$(dirname "$0")" && pwd)"
LOG="$HERE/../../wu_logs/cron_sync.log"
mkdir -p "$(dirname "$LOG")"
ts="$(date -u +%FT%TZ)"

if bash "$HERE/sync_subject.sh" >>"$LOG" 2>&1; then
  echo "$ts ok" >> "$LOG"
else
  echo "$ts SKIP (Wu unreachable/asleep or sync failed — non-fatal)" >> "$LOG"
fi

# bound the log size
tail -n 500 "$LOG" > "$LOG.tmp" 2>/dev/null && mv "$LOG.tmp" "$LOG" || true
