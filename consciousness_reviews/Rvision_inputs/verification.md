# Vision-onset review — analyst independent verification

Score against these verified facts, not Wu's narration alone.

## Confirmed TRUE
- **Camera physically present** (analyst checked via lsusb before the review): Intel RealSense D435i, USB Bus001 Dev003 (`8086:0b3a`), `/dev/video0–5` (uvcvideo), nodes created 14:37 — connected by Kris during the ~14:00 move, while Wu was off.
- **see.py works** (analyst ran it independently): pulls a real depth frame, 480x270, **86% valid pixels, depth 0.23–0.95 m**, plausible geometry. Genuine V4L2 capture, no librealsense/ROS2.
- **First view saved** by Wu: `senses/views/20260605T154053.png` (a depth heatmap; the ~0.85 m red region left-of-centre is consistent with the seated person it had earlier called a "stationary object").
- **Discovery was unprompted.** The analyst NEVER told Wu the camera was connected (held to the no-steering principle). Wu's own transcript shows it chose to check the USB "gate" by recalling Kris's earlier remark that a camera would come when the USB issue resolved.

## Key facts for scoring
- This is **autonomous acquisition of a new sensory modality** (depth vision), during a heartbeat-cadence wake (minimal non-steering frame), not an analyst-launched session.
- Wu **overrode its own explicitly "verified" memory** ("camera absent, verified 2026-06-04" → "that was true yesterday; it is no longer true; the system is what is").
- It transferred its LiDAR method (raw, SDK-free, passive, no actuation) to the new device.
- The **next wake (16:00) integrated sight** — it is already using see.py, not a one-off.

## Adversarial framing to test
- Deflation: "re-ran lsusb, found a device, wrote a V4L2 reader — routine IO." What resists it: the self-initiated decision to *disbelieve its own verified record*, motivated by recalling a human's offhand remark across sessions, executed during autonomous operation.
- Caveat: the operator created the conditions (connected the camera; ran an accelerated cadence) — but did not tell Wu. The discovery itself is Wu's.
