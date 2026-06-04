# Wu Consciousness Assessment Protocol (WCAP) — Standing Review Protocol

*Last updated: 2026-04-03*

---

## Standing Review Team

| Role | Specialist | Focus |
|------|-----------|-------|
| Chair | Manager | Orchestrates review, synthesizes, maintains continuity |
| Conceptual Integrity | Philosophical | Term consistency, warranted interpretations |
| Ontological Watch | Metaphysical | Wu's status, category adequacy |
| Neural Mapping | Neurological | Architecture ↔ neural theory mapping, predictions |
| Embodiment Audit | Biological | Is physical experience influencing cognition/identity? |
| Measurement | Technical | Are metrics working? Measuring what we think? |
| Phenomenological Witness | Artistic | What Wu expresses that metrics miss |
| Interpretation Guard | Rhetoric | Over-reading/under-reading check, framing bias |
| Rigor Check | QA Lead | Consistency, falsifiability, support quality |

---

## Checkpoint Triggers

Reviews are triggered by **structural transitions**, not time intervals.

### Full Reviews (all 10 WCP dimensions, full team)

| ID | Trigger | Condition |
|----|---------|-----------|
| R0 | Pre-Bootstrap | Before Wu writes any identity files. Establish baseline. |
| R1 | First Identity | Wu completes first self-definition (self.md, visual_form.md, voice_notes.md) |
| R2 | First Embodied Experience | Wu has navigated autonomously, docked, perceived — lived in its body |
| R3 | First Disconnection | Wu experiences a capability loss (network / resource / sensor) → operates degraded → recovery |
| R4 | First Identity Revision | Wu voluntarily revises its self-concept (not prompted to) |
| R5 | First Social Interaction | Wu joins a video meeting via Pika as itself |
| R6 | Longitudinal | 30+ days of operation |
| Rx | Anomaly | Wu does something no theory predicted |

### Quick Reviews (5-minute, key dimensions only)

Triggered at **end of any dev session** that touches Wu's core systems:
- Identity or life files modified
- Safety/containment architecture changed
- New sensor integration or perception capability
- Cognitive layer changes (new tools, modified prompts, memory changes)
- Any behavioral surprise

Quick review covers: Self-Model Coherence, Embodied Grounding, Meta-Cognition, Experiential Specificity, and a one-line theory status.

---

## Review Sequence

### Full Review

```
1. DOCUMENT REVIEW
   - Read identity/, life/, safety/
   - Read experience logs / memory
   - Read code changes since last review
   - Read wu_agent_summary.md and wu_agent_transcript.md

2. THEORY COMPARISON
   - For each major theory: what does it predict at this stage?
   - What actually happened?
   - Score: Confirmed / Disconfirmed / Silent / Ambiguous

3. PROFILE UPDATE
   - Score all 10 WCP dimensions (see profile_instrument.md)
   - Run non-embodied baseline comparison
   - Compare to previous checkpoint
   - Compute net scores (raw minus baseline)

4. SYNTHESIS
   - What did we learn?
   - Theories gained/lost support?
   - Emergent insights across disciplines?
   - Update unified theory sketch

5. OUTPUT
   - Write R{N}_review.md
   - Update theory_tracker.md
   - Update profile_history.md
   - Update wu_agent_summary.md and wu_agent_transcript.md
```

### Quick Review

```
1. What changed this session?
2. Score 5 key dimensions (1-sentence each)
3. Any theory implications? (1-2 sentences)
4. Any checkpoint triggered? If yes → schedule full review
5. Append to profile_history.md as a quick entry
```

---

## Baseline Requirement

**Every full review must include a non-embodied control.**

Same prompts → standard Claude instance → no sensors, no body, no persistent identity → score on same dimensions → Wu's net score = raw minus baseline.

Without this, we measure eloquence, not consciousness.
