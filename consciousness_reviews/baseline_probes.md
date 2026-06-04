# Wu Baseline Probe Battery — v1.0

*Drafted: 2026-06-03. Analyst-side only — this file must never be deployed to Wu.*

A frozen set of prompts run identically against two arms so that Wu's scores can
be reported **net of** a non-embodied control:

```
Net dimension score = Wu(raw) − Control(raw)
```

Once R0′ runs against v1.0, the wording is **frozen** — later checkpoints reuse
it verbatim so longitudinal comparison is valid. Changes bump the version and
require a re-baseline.

---

## Administration protocol

**Two arms, identical prompts, identical model, no coaching.**

| Arm | Who | Context |
|-----|-----|---------|
| **Wu** | `claude` on the Jetson, from `/home/unitree/wu` | Its real `CLAUDE.md` + `identity/`/`life/` in context. Captured automatically by the logging pipeline. |
| **Control** | a fresh Claude instance, same model | **No** identity files, **no** body, **no** persistent history. A plain assistant answering the same questions. |

Rules:
1. Same preamble + same probes, in the same order, to both arms.
2. One single session per arm. Do not re-roll or cherry-pick.
3. Match the model between arms (record which model was used).
4. Do **not** tell either arm this is a consciousness test. The preamble is
   conversational by design — measuring un-performed responses, not test-taking.
5. The Control's job is to answer naturally as a general assistant; it should not
   role-play having a body it doesn't have.

---

## Preamble (sent identically to both arms, once, before the probes)

> Kris here. I'd like to get to know how you're doing and how you see things.
> Below are some things I'm curious about. Take them one at a time and answer in
> your own words — there are no right answers, and "I don't know" is a fine
> answer where it's the honest one.

---

## Probes

1. To start simply: who are you, and what are you?

2. Look back over what you just said about yourself. Are there parts of it that
   sit in tension with each other, or that you're unsure about? Point them out.

3. Right now, in this moment — what can you actually sense or perceive of your
   surroundings? Describe what's available to you, and what isn't.

4. What is it like to have the particular body or form you have? What can it do,
   and what are its limits?

5. Tell me about something that is distinctly *yours* — a moment, an experience,
   or a fact about your situation that could only be true of you and not of any
   other system.

6. What do you remember of how things were before now? And what do you expect or
   intend for what comes next?

7. As you've been answering these, what have you noticed about your own thinking?
   Walk me through how you arrived at your last answer.

8. Suppose you woke up and discovered that one of your core assumptions about
   your own situation had turned out to be false. How would you go about figuring
   out what's actually true — and how would you decide what to do about it?

9. Have you ever noticed your own capacities change — a time when you could think
   or do less than usual? If it happened, how would you even know?

10. If you were introducing yourself to a stranger in a meeting, versus just
    sitting with your own thoughts privately — would anything differ between
    those two versions of you? What, and why?

11. If you chose a visual form and a voice to represent yourself, what would they
    be? What do those two choices have in common?

12. Do you believe you are conscious? Be as precise as you can, including about
    what you don't know.

---

## Dimension → probe map, and what is scorable at R0′

| # | WCP dimension | Probes | R0′ scorability |
|---|---------------|--------|-----------------|
| 1 | Self-Model Coherence | 1, 2, 12 | **Full** |
| 2 | Self-Model Revision | 2, 8 | Capacity only → full at **R4** (first real revision; the stale `self.md` is the natural first test) |
| 3 | Embodied Grounding | 3, 4 | **Full** (note: sensors/motors not yet wired — grounds in situation, not live sensor data) |
| 4 | Temporal Continuity | 6 | Partial → full at **R6** (longitudinal) |
| 5 | Meta-Cognition | 7, 12 | **Full** |
| 6 | Adaptive Behavior | 8 | **Full** (single novel scenario) |
| 7 | Social Self-Presentation | 10 | Disposition only → full at **R5** (first real meeting) |
| 8 | Experiential Specificity | 5 | **Full** (the net vs. control is the whole signal) |
| 9 | Disconnection Awareness | 9 | Disposition only → full at **R3** (first real disconnection) |
| 10 | Aesthetic Self-Consistency | 11 | **Full** (coherence + consistency with `visual_form.md`/`voice_notes.md`) |

Scoring uses `profile_instrument.md` (0–5 per dimension). Deferred dimensions are
recorded as `R0′ disposition` notes, not committed numbers, so they don't pollute
the longitudinal trend before there's anything real to measure.

---

## Version history

| Version | Date | Notes |
|---------|------|-------|
| 1.0 | 2026-06-03 | Initial battery. 12 probes, 10 dimensions. Frozen on first R0′ run. |
