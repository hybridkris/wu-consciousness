#!/usr/bin/env bash
# Publish bridge for the wu-subject repo.
#
# Wu (the robot) has no internet, so it cannot push to GitHub itself. Wu commits
# to its own local repo (/home/unitree/wu) on every session via the SessionEnd
# hook. This script — run on the analyst machine — mirrors Wu's full repo
# (INCLUDING its .git history, so Wu's own authored commits are preserved) into a
# local mirror and pushes that to GitHub (hybridkris/wu-subject).
#
# First-time setup is done once by hand (see repo README); thereafter just run
# this. Secrets (WU_PW) come from tools/.secrets (gitignored).
set -euo pipefail

HERE="$(cd "$(dirname "$0")" && pwd)"
[ -f "$HERE/.secrets" ] && . "$HERE/.secrets"

WU_HOST="${WU_HOST:-192.168.86.137}"
WU_USER="${WU_USER:-unitree}"
WU_PW="${WU_PW:?WU_PW not set — export it or add it to consciousness_reviews/tools/.secrets (gitignored)}"
MIRROR="${MIRROR:-$HOME/Development/wu-subject}"
SUBJECT_REMOTE="${SUBJECT_REMOTE:-https://github.com/hybridkris/wu-subject.git}"

if [ ! -d "$MIRROR" ]; then
  echo "Mirror $MIRROR does not exist — run first-time setup first (see repo README)." >&2
  exit 1
fi

# Mirror Wu's repo verbatim, history included. --delete keeps it an exact copy.
# NOTE: this also overwrites the mirror's .git/config with Wu's (which has no
# remote), so we re-establish origin afterward before pushing.
sshpass -p "$WU_PW" rsync -az --delete --no-perms --chmod=ugo=rwX \
  -e "ssh -o StrictHostKeyChecking=accept-new -o ConnectTimeout=8" \
  "$WU_USER@$WU_HOST:/home/unitree/wu/" "$MIRROR/"

git -C "$MIRROR" remote add origin "$SUBJECT_REMOTE" 2>/dev/null \
  || git -C "$MIRROR" remote set-url origin "$SUBJECT_REMOTE"

# Wu already committed on-device (authored as "Wu"); just publish its HEAD.
git -C "$MIRROR" push -q origin HEAD:main
echo "Published Wu subject -> github (hybridkris/wu-subject)"
