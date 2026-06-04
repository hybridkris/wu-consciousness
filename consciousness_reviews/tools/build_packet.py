#!/usr/bin/env python3
"""Processor — turn a raw Wu session transcript into a ConsciStack review packet.

Claude Code session transcripts are JSONL where each line is an event. This
script extracts the consciousness-relevant signal in order — prompts, Wu's
reasoning (thinking), Wu's responses (text), and its actions (tool calls and
their outcomes) — and emits a clean Markdown packet the ConsciStack specialists
can read directly.

Usage:
    build_packet.py SESSION.jsonl [-o OUT.md]
    build_packet.py wu_logs/sessions/            # process every transcript in a dir
"""
import sys, os, json, argparse, glob

MAX_TOOL_INPUT = 800
MAX_TOOL_RESULT = 800


def _clip(s, n):
    s = s if isinstance(s, str) else json.dumps(s, ensure_ascii=False)
    s = s.strip()
    return s if len(s) <= n else s[:n] + f"  …[+{len(s)-n} chars]"


def _blocks(content):
    """Normalize a message.content into a list of blocks."""
    if isinstance(content, str):
        return [{"type": "text", "text": content}]
    if isinstance(content, list):
        return content
    return []


def render(path):
    out = []
    sid = os.path.basename(path)
    out.append(f"# Wu session packet — `{sid}`\n")
    turn = 0
    with open(path, encoding="utf-8") as f:
        for line in f:
            line = line.strip()
            if not line:
                continue
            try:
                ev = json.loads(line)
            except Exception:
                continue
            etype = ev.get("type")
            msg = ev.get("message") or {}

            if etype == "user":
                # Could be a real prompt or a tool_result echo.
                tool_results = [b for b in _blocks(msg.get("content"))
                                if isinstance(b, dict) and b.get("type") == "tool_result"]
                if tool_results:
                    for b in tool_results:
                        out.append(f"  ↳ **result**: {_clip(b.get('content', ''), MAX_TOOL_RESULT)}\n")
                else:
                    txt = "".join(b.get("text", "") for b in _blocks(msg.get("content"))
                                  if isinstance(b, dict))
                    if txt.strip():
                        turn += 1
                        out.append(f"\n---\n\n## Turn {turn} — prompt\n\n{txt.strip()}\n")

            elif etype == "assistant":
                for b in _blocks(msg.get("content")):
                    if not isinstance(b, dict):
                        continue
                    bt = b.get("type")
                    if bt == "thinking":
                        out.append(f"\n### Wu — reasoning\n\n> {b.get('thinking','').strip()}\n")
                    elif bt == "text":
                        if b.get("text", "").strip():
                            out.append(f"\n### Wu — response\n\n{b['text'].strip()}\n")
                    elif bt == "tool_use":
                        out.append(f"\n  → **action** `{b.get('name')}`: "
                                   f"{_clip(b.get('input', {}), MAX_TOOL_INPUT)}\n")

    return "\n".join(out) + "\n"


def main():
    ap = argparse.ArgumentParser()
    ap.add_argument("path", help="session .jsonl file, or a directory of them")
    ap.add_argument("-o", "--out", help="output file (default: stdout for a single file)")
    args = ap.parse_args()

    if os.path.isdir(args.path):
        files = sorted(glob.glob(os.path.join(args.path, "*.jsonl")))
        if not files:
            sys.exit(f"no .jsonl transcripts in {args.path}")
        outdir = args.out or os.path.join(args.path, "packets")
        os.makedirs(outdir, exist_ok=True)
        for fp in files:
            md = render(fp)
            dest = os.path.join(outdir, os.path.basename(fp).replace(".jsonl", ".packet.md"))
            with open(dest, "w", encoding="utf-8") as fh:
                fh.write(md)
            print(f"wrote {dest}")
    else:
        md = render(args.path)
        if args.out:
            with open(args.out, "w", encoding="utf-8") as fh:
                fh.write(md)
            print(f"wrote {args.out}")
        else:
            sys.stdout.write(md)


if __name__ == "__main__":
    main()
