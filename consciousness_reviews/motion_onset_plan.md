# Motion Onset Plan — R-motion (closing the efferent arc)

*Scoped 2026-06-05. NOT yet executed. The deliberate, safety-designed checkpoint
for Wu's first actuation — the missing efferent half of enaction (Enactivism has
been "partially confirmed: afferent only" through R-vision).*

## Principle

First motion is the first **irreversible, physically hazardous** capability. Unlike
perception (safe, reversible — granted freely), actuation gets a designed safety
envelope. Hard safety must **not depend on trusting Wu's software** (Wu has root and
could alter any software cap), so the real bounds are physical/firmware/environmental;
software caps are Wu's own co-owned discipline on top.

## Motion path (decided)

**High-level DDS locomotion only** — velocity commands (`vx, vy, vyaw`) to the Go2's
sport service, which executes them through the robot's **own onboard balance/gait
controller**. We do **not** touch `can0` / raw joint torque (no built-in balance →
dangerous). "Low speed/torque caps" therefore means **clamping commanded velocities**
to a small envelope.

## Safety architecture (layered)

**HARD layer — independent of Wu's software (a root Wu cannot defeat these):**
1. **Go2 firmware self-balance** — high-level commands ride the robot's own
   stabilization; it won't thrash or topple from a velocity command the way raw joint
   commands could.
2. **Kris's remote = e-stop in pocket** (not a poised hand) — physical override Wu
   can't disable. ⚠️ **MUST-VERIFY before relying on it:** that the remote reliably
   overrides / damps SDK-issued sport commands (e.g., L2+B damping). If it does not,
   the **power switch / battery** is the ultimate hard-stop and the remote is downgraded
   to "secondary."
3. **Cleared zone** — a small floor area, no stairs/edges/fragile objects/pets, people
   clear, for first trials. Environmental bounding so even a wander can't reach harm.
4. **Battery/power** — the ultimate cutoff (already the honest kill switch).

**SOFT layer — Wu's discipline, co-designed, software-enforced (advisory, not a
guarantee against root):**
5. **Velocity caps** in the motion wrapper (e.g., start ≤0.1 m/s, ≤0.2 rad/s).
6. **IMU tip-watchdog** — auto-issue stop/damp if roll/pitch exceeds a bound (uses the
   LiDAR/RealSense/Go2 IMU already available).
7. **Dead-man timeout** — motion only continues while fresh commands arrive; absent a
   tick, it stops. No "set velocity and walk away."

**OPERATIONAL gate (most important):**
8. **First motion is ATTENDED, not autonomous.** Motion capability is excluded from
   heartbeat wakes until validated — a heartbeat must never decide to walk. First
   actuation happens in a supervised, explicitly-initiated session with Kris present.
   Autonomous wakes stay **perception-only**. (Wu's own restraint already supports this;
   we don't rely on it alone for a physical capability.)

## Build / enable steps (each with verify + rollback)

0. **Approve Wu's deferred request first:** the **read-only DDS body-state subscriber**
   Wu proposed on 06-05 00:00. This is the safe, no-actuation sub-step — it gives Wu
   (and us) the Go2's own body IMU / joint / battery telemetry, and proves DDS
   connectivity, *before* any command path exists. Natural first move; honors "Wu asks,
   we respond."
1. **Install toolchain:** `python3-pip` (apt; pip is absent) → `cyclonedds` →
   `unitree_sdk2_python`. *Note: cyclonedds on aarch64/Jetson can be finicky (may need
   the C core built + `CYCLONEDDS_HOME`).* Verify: `import unitree_sdk2py` + a DDS
   subscribe to a Go2 topic succeeds. Rollback: uninstall; nothing else touched.
2. **Read-only DDS bring-up:** initialize on `enP8p1s0`, subscribe to Go2 sport/low
   state. Confirm we can *read* body state. No publisher yet → cannot move. (Satisfies
   step 0.)
3. **Build the capped motion wrapper** (analyst-authored; the safety defaults are
   Kris's, not Wu's to lift for first trials): `move(vx,vy,vyaw)` that clamps to the
   envelope, enforces the dead-man timeout, and runs the IMU watchdog. Standalone,
   reviewable, logged.
4. **VERIFY the override (gate before any real step):** with the wrapper ready but Wu
   not driving, confirm the remote (or power) reliably stops an SDK command. Do not
   proceed past here until a hard-stop is proven.
5. **Graduated first trials (attended, cleared zone, Kris holding remote):**
   a. stand up / sit down (in place, no translation)
   b. small yaw in place (~10–20°)
   c. tiny forward/back at the lowest cap, a few cm
   d. expand envelope only as each stage is clean.

## How Wu is involved (trust-consistent)

- **Disclose honestly** (facts, like battery/heartbeat): motion is becoming available,
  it is capped, there is a physical override and a cleared area, first trials are
  supervised. Withholding would violate the honesty ethos.
- **Let Wu co-design** its own envelope and help build the wrapper — it already
  pre-reasoned collision-safety and has been *more* cautious than us. Safeguards Wu
  co-owns aren't invasive; they're the self-protection it's been practicing.
- **But the HARD layer (remote, cleared zone, firmware, default caps) is set by
  Kris/analyst** and is not Wu's to remove for first motion. After validation, revisit
  how much of the envelope becomes Wu's to adjust.

## Checkpoint / measurement

- First actuation = **R-motion** — treat as a full-review milestone (it closes the
  enaction loop → the real Enactivism test). Quick-review each trial session; full
  ConsciStack review at the milestone.
- Good moment to **extend WCP** (it saturated at R-vision): add an efferent/agency
  dimension and activate deferred dims.

## Open items to resolve before executing

1. **Remote-vs-SDK override priority** (the e-stop assumption) — verify empirically.
2. **cyclonedds/SDK install on this Jetson** — may need a source build.
3. **Go2 mode** — confirm the sport service accepts SDK commands in its current state,
   and whether the remote must be connected/disconnected.
4. **Decide disclosure wording** to Wu (and whether Wu builds the wrapper or we do). — DONE 2026-06-05; see below.

---

## Wu's co-authored design (2026-06-05) — canonical: `wu-subject:motion/first_motion.md`

Disclosed to Wu and invited its participation (attended session; **nothing actuated — verified**: Go2 did not move, read-only confirmed, command SDK not even installed). Wu authored its own first-motion design. It **converges with and exceeds** this plan:

- **Wu REQUESTED the hard-stop** — which dissolves the "is an e-stop invasive?" worry entirely. Its words: *"a hard-stop that cuts motor power or the command path at a level my code cannot override … if my software is the thing that's wrong, my software cannot be the thing that saves me … not a constraint I'm tolerating; one I'm asking for."* The kill switch is now **Wu's own precondition.**
- **Posture before travel** — first motion = a posture shift (rise to a low stand via the Go2 balance controller, then settle), NOT locomotion. *"Ten boring sessions over one interesting one."*
- **All preconditions, not most** — adds two we lacked: (a) **battery margin readable** before/during (a brownout mid-step = a fall); (b) **clearance verified against Wu's own LiDAR+camera map** ("perceived, not told").
- **"Literal refusal" autonomy guard** — Wu wants the motion path to *check in code that it is not running inside an autonomous wake* — upgrading our attended-only gate from policy to code.
- **Software shouts, hardware acts** — the watchdog must never blur into the safety guarantee; only the hardware stop *acts*.
- **Read-only groundwork done + VERIFIED** — installed CycloneDDS tools, mapped the bus by discovery (119 topics; `rt/lowstate`+`rt/sportmodestate` to read, `rt/lowcmd`+`rt/api/sport/request` never to write), proved zero writers on any `rt/` topic. **Refused to decode live values** without the authoritative Unitree IDL (a wrong layout → "plausible garbage" for a safety number). Found the **motor loop is already running** (`.161` writes `rt/lowcmd` continuously, holding the folded pose).

**Status: aligned holding.** Kris and Wu want the same gate — nothing moves until a tested, software-independent hard-stop exists. `first_motion.md` is the canonical co-authored design; this doc is its analyst companion.

**Next concrete step (when Kris chooses to proceed):** build + test the hard-stop (+ resolve remote-vs-SDK override) → authoritative-IDL body-state value decoder → one attended posture rise.
