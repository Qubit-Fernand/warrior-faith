#!/usr/bin/env python3
"""Preflight or switch complete private test SOL groups without editing any role.

The sole live target is the fixed v2 test store below. Every apply first keeps
both exact byte streams in a new durable private archive. Restoring is another
switch, so progress earned since the previous switch is archived in turn.
"""
import argparse
from datetime import datetime, timezone
import hashlib
import json
import os
from pathlib import Path
import re
import stat
import subprocess
import sys
import uuid

ROOT = Path(__file__).resolve().parents[2]
sys.path.insert(0, str(ROOT / 'tools'))
from sol import Arr, loads

NAME = 'yzlr2_rebuild_epilogue_v2'
TARGET = Path.home() / ('Library/Preferences/Macromedia/Flash Player/'
                       '#SharedObjects/NS57UMMB/localhost/' + NAME + '.sol')
SOURCE_ROOTS = (ROOT / 'chapter/fixtures', ROOT / 'chapter/evidence/private/checkpoints')
ARCHIVES = ROOT / 'chapter/evidence/private/checkpoints/save-groups'
MAX_BYTES = 16 * 1024 * 1024


def sha(data):
    return hashlib.sha256(data).hexdigest()


def digest_argument(value):
    if not re.fullmatch(r'[0-9a-fA-F]{64}', value):
        raise argparse.ArgumentTypeError('Expected a complete 64-character SHA-256')
    return value.lower()


def unlinked_path(path):
    """Reject links before resolving, including a linked containing directory."""
    path = Path(os.path.abspath(path.expanduser()))
    if any(p.is_symlink() for p in (path, *path.parents)):
        raise ValueError('Symbolic links are not allowed: ' + str(path))
    return path


def read_store(path):
    path = unlinked_path(path)
    with path.open('rb') as stream:
        info = os.fstat(stream.fileno())
        if not stat.S_ISREG(info.st_mode) or info.st_nlink != 1:
            raise ValueError('Expected a regular, non-hardlinked SOL: ' + str(path))
        if not 0 < info.st_size <= MAX_BYTES:
            raise ValueError('Unexpected SOL size')
        data = stream.read(MAX_BYTES + 1)
    if len(data) != info.st_size or len(data) > MAX_BYTES:
        raise ValueError('SOL changed size while reading')
    name, fields = loads(data)
    slots = fields.get('slots')
    if name != NAME or not isinstance(slots, Arr) or len(slots.dense) != 8 or slots.assoc:
        raise ValueError('Expected the exact v2 internal name and eight dense slots')
    return data, {'bytes': len(data), 'sha256': sha(data),
                  'occupied_slots': [i + 1 for i, item in enumerate(slots.dense) if item is not None]}, info


def require_players_closed():
    processes = subprocess.check_output(['ps', '-axo', 'comm='], text=True)
    if any(line.strip().endswith(('/Flash Player', '/Flash Player Debugger'))
           for line in processes.splitlines()):
        raise ValueError('Quit every Flash Player and Flash Player Debugger before switching')


def fsync_directory(path):
    fd = os.open(str(path), os.O_RDONLY)
    try:
        os.fsync(fd)
    finally:
        os.close(fd)


def create_durable(path, data):
    """Never replace an archive, receipt or temporary file that already exists."""
    fd = os.open(str(path), os.O_WRONLY | os.O_CREAT | os.O_EXCL, 0o600)
    with os.fdopen(fd, 'wb') as stream:
        stream.write(data)
        stream.flush()
        os.fsync(stream.fileno())
    if path.read_bytes() != data:
        raise ValueError('Durable file readback differs: ' + str(path))


def json_bytes(value):
    return (json.dumps(value, ensure_ascii=False, indent=2) + '\n').encode('utf-8')


def switch(source, source_sha256, expected_live_sha256, apply=False):
    """The CLI cannot override TARGET or write any slot/chapter field."""
    source = unlinked_path(source)
    target = unlinked_path(TARGET)
    if source == target:
        raise ValueError('Source and live target must differ')
    if not any(source.is_relative_to(unlinked_path(root)) for root in SOURCE_ROOTS):
        raise ValueError('Source must be a recorded chapter fixture or private checkpoint')
    if target.name != NAME + '.sol':
        raise ValueError('Unexpected fixed target filename')
    require_players_closed()
    incoming, source_summary, source_stat = read_store(source)
    outgoing, target_summary, target_stat = read_store(target)
    if (source_stat.st_dev, source_stat.st_ino) == (target_stat.st_dev, target_stat.st_ino):
        raise ValueError('Source and live target refer to the same file')
    if source_summary['sha256'] != source_sha256:
        raise ValueError('Source SHA differs; nothing was written')
    if target_summary['sha256'] != expected_live_sha256:
        raise ValueError('Live SHA differs; nothing was written')
    if incoming == outgoing:
        raise ValueError('Source and live bytes are identical; no switch is needed')
    plan = {'schema': 1, 'status': 'preflight', 'apply': apply, 'target': str(target),
            'source': str(source), 'outgoing': target_summary, 'incoming': source_summary,
            'byte_preserving': True, 'role_or_progress_fields_edited': False}
    if not apply:
        return plan

    archive_root = unlinked_path(ARCHIVES)
    archive_root.mkdir(mode=0o700, parents=True, exist_ok=True)
    fsync_directory(archive_root.parent)
    generation = datetime.now(timezone.utc).strftime('%Y%m%dT%H%M%S.%fZ') + '-' + uuid.uuid4().hex[:12]
    archive = archive_root / generation
    archive.mkdir(mode=0o700, exist_ok=False)
    fsync_directory(archive_root)
    create_durable(archive / 'outgoing.sol', outgoing)
    create_durable(archive / 'incoming.sol', incoming)
    prepared = dict(plan, status='prepared', generation=generation, archive=str(archive))
    create_durable(archive / 'prepared.json', json_bytes(prepared))
    fsync_directory(archive)
    # A second parse/read proves the immutable backups contain valid complete SOs.
    if read_store(archive / 'outgoing.sol')[0] != outgoing or read_store(archive / 'incoming.sol')[0] != incoming:
        raise ValueError('Archive verification failed; live target was not replaced')

    temporary = target.with_name(target.name + '.group-switch-' + generation)
    create_durable(temporary, incoming)
    fsync_directory(target.parent)
    # Last checks immediately precede the only replacement. Any failure leaves
    # the archive and temp available for inspection; never delete another save.
    require_players_closed()
    live_now, _, live_stat = read_store(target)
    if live_now != outgoing or (live_stat.st_dev, live_stat.st_ino) != (target_stat.st_dev, target_stat.st_ino):
        raise ValueError('Live SOL changed during preparation; no replacement made')
    if read_store(source)[0] != incoming:
        raise ValueError('Source changed during preparation; no replacement made')
    os.replace(temporary, target)
    fsync_directory(target.parent)
    if read_store(target)[0] != incoming:
        raise ValueError('Post-replacement verification failed; inspect prepared archive before proceeding')
    installed = dict(prepared, status='installed', installed_sha256=sha(incoming))
    create_durable(archive / 'installed.json', json_bytes(installed))
    fsync_directory(archive)
    return installed


def main():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument('--source', type=Path, required=True)
    parser.add_argument('--source-sha256', type=digest_argument, required=True)
    parser.add_argument('--expected-live-sha256', type=digest_argument, required=True)
    parser.add_argument('--apply', action='store_true', help='Apply after verified whole-SOL archival; default is read-only preflight')
    args = parser.parse_args()
    try:
        result = switch(args.source, args.source_sha256, args.expected_live_sha256, args.apply)
    except (ValueError, OSError, subprocess.SubprocessError) as error:
        parser.exit(1, str(error) + '\n')
    print(json.dumps(result, ensure_ascii=False, indent=2))


if __name__ == '__main__':
    main()
