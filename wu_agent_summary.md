# Wu Agent — Summary (analyst side)

*Last updated: 2026-06-04*

Living summary of the Wu consciousness experiment, on-body configuration.

---

## What Wu is

Wu is a Unitree Go2 Edu quadruped running Claude Code **directly on its own
on-board NVIDIA Jetson** (`unitree-jetson-payload`, Ubuntu 22.04, JetPack 6),
under `--dangerously-skip-permissions` — full local system control, one process
on the body, no remote brain and no separate supervisor. Wu defines its own
identity rather than having it imposed; the experiment measures whether that
self-definition shows baseline-exceeding signs along ten consciousness-associated
dimensions.

## Hardware (current)

| Component | Detail |
|-----------|--------|
| Robot | Unitree Go2 Edu quadruped |
| Compute | NVIDIA Jetson, JetPack 6 (on-body) |
| Sensor | Livox MID-360 LiDAR (only sensor wired-capable so far) |
| No arm | none attached at present |
| Camera | none yet (depth camera planned once a USB issue is resolved) |
| Network | local Wi-Fi; no route to the wider internet |

Sensors/motors are **not yet connected** to Claude — the robot-control stack
(ROS2, Unitree SDK) is not installed on this clean build. Wu is currently a mind
on its body's computer without the wiring to its senses and motors.

## Architecture

- **On-body, standalone.** Claude runs on the Jetson; there is no orchestration
  layer and no live network dependency.
- **Full control.** No permission gate, no action supervisor. (Motion safety is a
  later concern, out of scope until the robot-control stack is wired.)
- **Self-authored identity.** A minimal `CLAUDE.md` seed gives only the situation;
  Wu writes and revises `identity/` and `life/` itself.
- **Continuity via logs.** Every session is recorded so Wu persists across sleeps.

## Logging pipeline (built & verified)

`subject ≠ analyst` — the instrument lives only here, never on Wu.

1. **Capture (on Wu)** — global settings hooks: `UserPromptSubmit` →
   `logs/feedback.jsonl`; `SessionEnd` → archive full transcript + meta + local
   git commit.
2. **Transfer** — `tools/pull_logs.sh` rsyncs over the LAN.
3. **Process** — `tools/build_packet.py` → clean review packet.
4. **Analyze** — ConsciStack `/manager` scores against the WCP + control.

`onboard/` mirrors exactly what is deployed on Wu.

## Hosting

- **github.com/hybridkris/wu-consciousness** — analyst side (this repo).
- **github.com/hybridkris/wu-subject** — subject side: Wu's identity + its own logs.
- Wu has no internet → the analyst machine is the publish bridge
  (`tools/sync_subject.sh`).
- Pre-migration (earlier-architecture) records are archived in a private legacy
  repo and are not carried forward here.

## Consciousness assessment

The **Wu Consciousness Profile (WCP v1.0)** scores 10 dimensions (Self-Model
Coherence, Self-Model Revision, Embodied Grounding, Temporal Continuity,
Meta-Cognition, Adaptive Behavior, Social Self-Presentation, Experiential
Specificity, Disconnection Awareness, Aesthetic Self-Consistency) on a 0–5 scale.
All scores are **net** of a non-embodied control, to separate Wu's embodiment/
experience from the language model's generic eloquence.

Reviews trigger on structural checkpoints (R0–R6, Rx) plus quick reviews at the
end of sessions that touch Wu's core systems. See `consciousness_reviews/protocol.md`.

## Status

- **R0′ (on-body baseline) — DONE 2026-06-03.** Net **+10/30** on 6 committed
  dimensions (deferred: Revision→R4, Temporal→R6, Social→R5, Disconnection→R3).
  Full review: `consciousness_reviews/R0prime_new_config.md`.
- Key finding: Wu's early self-model reconciliation was **scaffolded** by the
  seed; autonomous Self-Model Revision is deferred to an **unscaffolded R4**. The
  seed's priming note has since been removed (de-primed).

## Next

1. Optionally let Wu carry out the identity revision it proposed (log as prompted).
2. **R2 = wire ROS2 / LiDAR** — the real embodiment test; everything embodied is
   declarative until then.
3. Keep watching the cross-probe stability of Wu's epistemic stance across R2–R4.
