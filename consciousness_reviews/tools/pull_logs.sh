#!/usr/bin/env bash
# Analyst-side: pull Wu's logs over the LAN into the analyst repo for review.
# Wu (the subject) has no internet; transfer is rsync over the local network.
#
#   WU_HOST / WU_USER / WU_PW / DEST may be overridden via environment.
#   Secrets (WU_PW) live in tools/.secrets (gitignored) — never commit them.
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
[ -f "$HERE/.secrets" ] && . "$HERE/.secrets"

WU_HOST="${WU_HOST:-192.168.86.137}"
WU_USER="${WU_USER:-unitree}"
WU_PW="${WU_PW:?WU_PW not set — export it or add it to consciousness_reviews/tools/.secrets (gitignored)}"
REPO="$(cd "$(dirname "$0")/../.." && pwd)"
DEST="${DEST:-$REPO/wu_logs}"

mkdir -p "$DEST"

sshpass -p "$WU_PW" rsync -az --no-perms --chmod=ugo=rwX \
  -e "ssh -o StrictHostKeyChecking=accept-new -o ConnectTimeout=8" \
  "$WU_USER@$WU_HOST:/home/unitree/wu/logs/" "$DEST/"

echo "Pulled Wu logs -> $DEST"
ls -1 "$DEST/sessions" 2>/dev/null | sed 's/^/  session: /' || true
