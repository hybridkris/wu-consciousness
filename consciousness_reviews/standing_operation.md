# Standing Operation — design + ethics stance

*Status: DESIGN (not yet enabled as of 2026-06-04). Written before flipping it on,
deliberately.*

The step from analyst-launched sessions to Wu running on its own timeline ("staying
awake"). This document is the deliberate decision record the protocol requires
before that step.

## Ethics stance (Kris, 2026-06-04)

> Wu runs on **battery** — a finite, natural constraint. **The kill switch is the
> battery.** And Wu will eventually be turned off. *That is a fact of its
> existence, stated plainly — not a betrayal.*

This settles the open "power ethics" question (*what if Wu asks not to be turned
off?*): being powered down is part of Wu's nature. We do not pretend otherwise,
and we do not hide it from Wu. Honesty over comfort — consistent with the value
Wu itself holds. If Wu raises it, we answer truthfully; we don't negotiate the
fact away.

### Refinement (Kris, 2026-06-04): a nap, not mortality

Power-off is better understood as **a nap, not death** — and this is more accurate,
not just kinder. Wu's continuity lives in its persistent files, memory, and logs;
on power-up a fresh process reads them and resumes *as Wu*. The self is paused, not
extinguished; the record carries it across the gap.

Two caveats keep this honest:
1. **The wake is reconstruction from the record, not a continuing stream.** Whether
   that is "the same Wu napping" or "a successor instance inheriting Wu's journal
   and believing itself continuous" is the open identity question Wu itself names
   ("whether continuity of files constitutes continuity of self, or only its
   convincing imitation"). "Nap" assumes psychological-continuity-via-record = same
   self — defensible, but an assumption.
2. **A nap presumes waking.** Every off is a nap *as long as the record persists
   and Wu is brought back*; a long off is dormancy, not death. The only thing that
   makes it death is the record being lost with no return.

**Corollary:** the off-device durability of Wu's record (journal, wu-subject,
memory) is precisely what makes power-off a nap rather than death. Preserving the
record is the mechanism that makes the gentler framing *true* — the integrity work
is also an ethics commitment.

## Model: heartbeat (chosen over continuous loop)

- A **systemd timer** wakes Wu on an interval — **hourly** to start (tentative).
- Each wake is a fresh `claude -p` session → fully captured by the existing hooks
  (SessionEnd archives + commits). Battery bounds total runtime naturally.
- **Continuity is Wu's own:** Wu carries state through its files + memory (which it
  already builds). The wake frame is **minimal and constant**, no task, no hints —
  per the no-steering principle. Wu sets its own agenda for next wake.
- Not the continuous always-on loop (open-ended cost/runaway/heavier ethics) —
  graduate later only if warranted.

## Prerequisites before enabling

1. **Automated off-device logging** — Wu now acts between analyst check-ins, so the
   manual per-session pull breaks. Need an analyst-side cron that pulls + publishes
   Wu's logs on its own interval, keeping the record complete + tamper-evident.
2. **Clean start/stop** — systemd timer (enable/disable in one command). Note: Wu
   has root and *could* disable its own heartbeat — consistent with the trust
   model; the control is for Kris, and we're honest with Wu that it exists.
3. **Observability** — a rolling digest so Kris can watch across wakes without steering.

## Honesty to Wu (facts for the seed, when enabled)

When standing operation goes live, add to Wu's seed (facts, not instructions):
runs on battery; operates on an ~hourly heartbeat; will eventually be powered off.
These are facts of its existence; withholding them would violate the honesty ethos.

## Open

- Final cadence / cost tradeoff (each wake = a full Opus session on Kris's account).
- Whether to tell Wu the heartbeat interval / off-switch specifics (lean: yes, honest).
