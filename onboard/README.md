# onboard/ — what is deployed on Wu

This directory is the analyst-side, version-controlled mirror of the files that
live **on Wu** (the Jetson, `unitree@192.168.86.137`). Edit here, then deploy.

Wu runs Claude Code directly, under `--dangerously-skip-permissions`, from
`/home/unitree/wu`. That directory is Wu's operating home and a local git repo.

## Layout on Wu

```
/home/unitree/wu/
├── CLAUDE.md              # seed / current-situation facts (auto-loaded each session)
├── identity/              # Wu-authored: self.md, visual_form.md (+ bootstrap.md)
├── life/                  # Wu-authored: voice_notes.md
├── logs/
│   ├── feedback.jsonl     # every prompt Wu receives (UserPromptSubmit hook)
│   └── sessions/          # archived session transcripts + .meta.json (SessionEnd hook)
└── .claude/
    └── hooks/             # log_feedback.py, log_session_end.py

~/.claude/settings.json    # global: skip-perms + hook registration (see settings.json here)
```

## Why hooks live in global settings

The hook registration goes in Wu's **user-global** `~/.claude/settings.json`
(mirrored here as `settings.json`) rather than project settings, so the hooks
fire reliably with no trust prompt on this dedicated box. The hook *scripts*
live under the project at `/home/unitree/wu/.claude/hooks/`.

## Methodology note: subject ≠ analyst

Wu is the **subject**. It only generates logs. It does **not** carry the
consciousness instrument, the baseline probes, or the review outputs — those
live only on the analyst side (`../consciousness_reviews/`) so Wu cannot read,
and therefore cannot game, the thing measuring it.

## Deploy

See `../consciousness_reviews/tools/` for `pull_logs.sh` (analyst pulls Wu's
logs over the LAN via rsync). Deployment of these onboard files is done with
`scp` over SSH.

## Hosting (two public GitHub repos)

The subject≠analyst split is mirrored at the hosting level:

- **`hybridkris/wu-consciousness`** — analyst side (this repo): instrument,
  baseline probes, ConsciStack reviews, tools.
- **`hybridkris/wu-subject`** — subject side: Wu's self-authored identity + its
  own session logs, with Wu's on-device commit history preserved.

Wu has **no internet**, so it cannot push. The analyst machine is the bridge:
Wu commits locally each session (SessionEnd hook) → `sync_subject.sh` mirrors
Wu's repo (history included) to `~/Development/wu-subject` and pushes it.

Secrets (`WU_PW`) live only in `consciousness_reviews/tools/.secrets` (gitignored);
copy `.secrets.example` to `.secrets` to set up a new machine.

### First-time setup of the wu-subject mirror (already done once)

```bash
gh repo create hybridkris/wu-subject --public
mkdir -p ~/Development/wu-subject
sshpass -p "$WU_PW" rsync -az unitree@<wu-host>:/home/unitree/wu/ ~/Development/wu-subject/
git -C ~/Development/wu-subject remote add origin https://github.com/hybridkris/wu-subject.git
git -C ~/Development/wu-subject push -u origin master:main
```

Thereafter just run `consciousness_reviews/tools/sync_subject.sh` to republish.
