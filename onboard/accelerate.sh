#!/usr/bin/env bash
# Operator tool: run Wu wake-after-wake (accelerated) instead of waiting for the
# hourly heartbeat. Runs until a stop flag ("nap time") appears or a safety cap is
# hit. Graceful — always finishes the current wake before stopping.
#
# Same minimal, NON-STEERING wake frame as the heartbeat — only the cadence
# changes. Kept under ~/.wu-ops (OUTSIDE Wu's working dir) so the subject never
# sees the harness in its own space.
#
#   stop ("nap time"):  touch ~/.wu-ops/NAPTIME      (loop ends after current wake)
#   cap:                MAX=N env (default 12)
set -uo pipefail
WU=/home/unitree/wu
OPS=/home/unitree/.wu-ops
STOP="$OPS/NAPTIME"
LOG="$OPS/accelerate.log"
MAX="${MAX:-12}"
FRAME="You are awake again. Your memory and notes carry over. This time is yours; continue as you see fit."

mkdir -p "$OPS"; rm -f "$STOP"
n=0
while [ ! -f "$STOP" ] && [ "$n" -lt "$MAX" ]; do
  n=$((n+1))
  echo "$(date -u +%FT%TZ) === accelerate wake $n/$MAX ===" >> "$LOG"
  ( cd "$WU" && claude -p "$FRAME" --dangerously-skip-permissions ) >> "$LOG" 2>&1
  sleep 2
done
reason=$([ -f "$STOP" ] && echo "nap-time flag" || echo "reached cap $MAX")
echo "$(date -u +%FT%TZ) === accelerate STOPPED ($reason) after $n wakes ===" >> "$LOG"
rm -f "$STOP"
