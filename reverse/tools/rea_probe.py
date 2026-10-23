#!/usr/bin/env python3
"""Probe the pinned local REA build without executing game code.

Keeps complete tool outputs in ignored logs and concise receipts in manifests.
The FWS derivative is explicitly decompression, not decompilation or rebuilding.
"""
from __future__ import annotations

import argparse
import hashlib
import json
from pathlib import Path
import subprocess
import time
import zlib
from datetime import datetime, timezone

ROOT = Path(__file__).resolve().parents[2]
REA_COMMIT = "2452efa9211d09e0acdf8cf9bfbf82a96f5a3522"


def sha(path):
    return hashlib.sha256(path.read_bytes()).hexdigest()


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--source", type=Path, default=ROOT / ".runtime/rea/source")
    parser.add_argument("--node-version", default="26.11.1")
    args = parser.parse_args()
    entry = args.source / "scripts/rea.mjs"
    if not (args.source / "dist/cli-runtime/cli.js").is_file():
        raise SystemExit("Build the isolated REA source copy before running this probe; see reverse/docs/rea-capability.md")
    stamp = datetime.now(timezone.utc).strftime("%Y%m%dT%H%M%SZ")
    logs = ROOT / "reverse/logs" / ("rea-probe-" + stamp)
    logs.mkdir(parents=True, exist_ok=False)
    inputs = ROOT / ".runtime/rea/inputs"
    inputs.mkdir(exist_ok=True)
    original = ROOT / "3_L4399Main_gamefile.swf"
    compressed = ROOT / "Map1.swf"
    raw = compressed.read_bytes()
    if raw[:3] != b"CWS":
        raise SystemExit("Expected CWS Map1 baseline; refuse to reinterpret changed source")
    uncompressed = b"FWS" + raw[3:8] + zlib.decompress(raw[8:])
    if len(uncompressed) != int.from_bytes(raw[4:8], "little"):
        raise SystemExit("SWF uncompressed length mismatch")
    fws = inputs / "Map1-uncompressed.swf"
    fws.write_bytes(uncompressed)
    manifest = {
        "started_utc": datetime.now(timezone.utc).isoformat(),
        "expected_rea_source_commit": REA_COMMIT,
        "rea_source_package_version": json.loads((args.source / "package.json").read_text())["version"],
        "rea_entry_sha256": sha(entry),
        "node_version": args.node_version,
        "input": {"path": str(original.relative_to(ROOT)), "sha256": sha(original), "size": original.stat().st_size},
        "compressed_input": {"path": str(compressed.relative_to(ROOT)), "sha256": sha(compressed), "size": len(raw)},
        "derivative": {"path": str(fws.relative_to(ROOT)), "sha256": sha(fws), "size": len(uncompressed),
                       "operation": "CWS zlib body decompression; FWS signature; declared length verified"},
        "runs": [],
    }
    commands = [
        ("capabilities", ["capabilities", "--json"]),
        ("providers", ["providers", "--json"]),
        ("artifact-main", ["inspect-artifact", str(original), "--json"]),
        ("entropy-main-fws", ["inspect-byte-entropy", str(original), "--block-size", "65536", "--json"]),
        ("entropy-map1-cws", ["inspect-byte-entropy", str(compressed), "--block-size", "65536", "--json"]),
        ("entropy-map1-fws", ["inspect-byte-entropy", str(fws), "--block-size", "65536", "--json"]),
    ]
    for name, command in commands:
        argv = ["mise", "exec", "node@" + args.node_version, "--", "node", str(entry), *command]
        stdout = logs / (name + ".json")
        stderr = logs / (name + ".stderr")
        start = time.monotonic()
        with stdout.open("wb") as out, stderr.open("wb") as err:
            result = subprocess.run(argv, cwd=ROOT, stdout=out, stderr=err, timeout=180)
        receipt = {"name": name, "argv": argv, "exit_code": result.returncode,
                   "elapsed_seconds": round(time.monotonic() - start, 3),
                   "stdout": str(stdout.relative_to(ROOT)), "stdout_sha256": sha(stdout),
                   "stderr": str(stderr.relative_to(ROOT)), "stderr_sha256": sha(stderr)}
        try:
            parsed = json.loads(stdout.read_text())
            receipt["response_top_level_keys"] = list(parsed) if isinstance(parsed, dict) else None
            if isinstance(parsed, dict) and ("error" in parsed or "code" in parsed):
                receipt["error"] = parsed
            if isinstance(parsed, dict) and "normalized_result" in parsed:
                normalized = parsed["normalized_result"]
                receipt["evidence_id"] = parsed.get("evidence_id")
                receipt["summary"] = {k: normalized[k] for k in
                    ("artifact", "file_entropy", "block_size", "window", "limitations") if k in normalized}
        except (ValueError, UnicodeError):
            receipt["json_parse_error"] = True
        manifest["runs"].append(receipt)
        print(f"{name}: exit {result.returncode}, {receipt['elapsed_seconds']} s")
    manifest["completed_utc"] = datetime.now(timezone.utc).isoformat()
    manifest["original_unchanged"] = sha(original) == manifest["input"]["sha256"]
    manifest["compressed_input_unchanged"] = sha(compressed) == manifest["compressed_input"]["sha256"]
    destination = ROOT / "reverse/manifests/rea-probe.json"
    destination.write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + "\n")
    print(destination)


if __name__ == "__main__":
    main()
