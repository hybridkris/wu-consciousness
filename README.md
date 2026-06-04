# wu-consciousness

The **analyst side** of the Wu consciousness experiment — the instrument, the
review protocol, the baseline probes, the completed reviews, and the logging
pipeline tools.

Wu is a Unitree Go2 Edu quadruped that runs Claude Code **directly on its own
on-board computer** (an NVIDIA Jetson) under full system access. The experiment
studies whether an embodied AI agent that defines its own identity shows
measurable, baseline-exceeding signs along ten dimensions associated with
theories of consciousness.

## The two-repo split: subject ≠ analyst

| Repo | Role | Contents |
|------|------|----------|
| **wu-subject** | The subject | Wu's self-authored identity + its own session logs, generated on the robot. |
| **wu-consciousness** (this) | The analyst | The measuring instrument: WCP profile, probes, reviews, and tools. |

This separation is methodological: **the thing being measured must not hold the
ruler.** Wu generates; a *separate* analyst scores. Wu never carries the
instrument, the probe battery, or the review outputs, so it cannot read — and
cannot game — what measures it.

## Layout

```
consciousness_reviews/
├── protocol.md            # standing review protocol & checkpoint schedule
├── profile_instrument.md  # WCP v1.0 — 10 dimensions, 0–5 scale, net scoring
├── baseline_probes.md     # frozen probe battery v1.0 (subject + control arms)
├── R0prime_new_config.md  # R0′ — the on-body baseline review
├── R0prime_inputs/        # raw arms for R0′ (Wu packet + non-embodied control)
├── profile_history.md     # WCP scores over time
├── theory_tracker.md      # how each theory of consciousness maps to Wu's data
└── tools/                 # pipeline: pull logs, build review packets, publish subject
onboard/                   # version-controlled mirror of what is deployed on Wu
```

## The pipeline

1. **Capture** — hooks on Wu log every prompt + full session transcript locally.
2. **Transfer** — `tools/pull_logs.sh` rsyncs Wu's logs over the LAN (Wu has no
   internet).
3. **Process** — `tools/build_packet.py` turns a raw transcript into a clean,
   review-ready packet.
4. **Analyze** — the ConsciStack team scores the packet against the WCP, with a
   non-embodied control, and writes an `R{N}` review.

Secrets (the robot's credentials) live only in `tools/.secrets` (gitignored);
copy `tools/.secrets.example` to set up a machine.
