#!/usr/bin/env python

import argparse
import sys
import random
import shutil
import subprocess
from pathlib import Path
from typing import List, Tuple

PRESETS: List[Tuple[str, str]] = [
    ("soft-fade", "--transition-type any --transition-duration 0.7"),
    ("gentle-grow", "--transition-type grow --transition-duration 0.85"),
    (
        "slide-left",
        "--transition-type wipe --transition-angle 180 --transition-duration 0.9",
    ),
    (
        "slide-up",
        "--transition-type wipe --transition-angle 270 --transition-duration 0.9",
    ),
    (
        "center-ripple",
        "--transition-type center --transition-step 90 --transition-duration 0.8",
    ),
    ("any-quick", "--transition-type any --transition-duration 0.5"),
]


def ensure_swww_running():
    """Start swww if the daemon isn't up yet"""

    if shutil.which("swww") is None:
        eprint("Error: swww not found in PATH")
        sys.exit(1)

    if shutil.which("swww-daemon") is None:
        eprint("Error: swww-daemon not found in PATH")
        sys.exit(1)

    try:
        subprocess.run(
            ["swww", "query"],
            check=True,
            stdout=subprocess.DEVNULL,
            stderr=subprocess.DEVNULL,
        )
    except Exception:
        eprint("Error: swww-daemon is not running")
        sys.exit(1)


def pick_image(directory: Path) -> Path:
    exts = (".png", ".jpg", ".jpeg")
    imgs = [p for p in directory.iterdir() if p.is_file() and p.suffix.lower() in exts]

    if not imgs:
        eprint(f"No PNG/JPG files found in {directory}")
        sys.exit(1)

    return random.choice(imgs)


def main():
    parser = argparse.ArgumentParser(
        description="Pick a random wallpaper from a directory and set it via swww"
    )

    parser.add_argument("directory", help="Directory with images (png/jpg/jpeg)")
    parser.add_argument(
        "--preset",
        choices=[n for n, _ in PRESETS] + ["random"],
        default="gentle-grow",
        help="Transition preset to use (default: gentle-grow)",
    )
    parser.add_argument(
        "--resize",
        default="crop",
        help="swww --resize mode (cover|contain|crop|fit|stretch). Default: crop",
    )
    parser.add_argument(
        "--extra",
        default="",
        help="Extra flags passed directly to `swww img`",
    )
    parser.add_argument(
        "--seed",
        type=int,
        default=None,
        help="Random seed (optional, for reproducibility).",
    )
    args = parser.parse_args()

    if args.seed is not None:
        random.seed(args.seed)

    d = Path(args.directory).expanduser()
    if not d.is_dir():
        eprint(f"Error: {d} is not a directory or does not exist")
        sys.exit(1)

    ensure_swww_running()
    img = pick_image(d)

    if args.preset == "random":
        name, flags = random.choice(PRESETS)
    else:
        name, flags = next((n, f) for n, f in PRESETS if n == args.preset)

    cmd = ["swww", "img", str(img), "--resize", args.resize]

    if flags:
        cmd.extend(flags.split())
    if args.extra:
        cmd.extend(args.extra.split())

    print(
        f"Setting: {img.name}  | preset: {name}  | flags: {flags}  | resize: {args.resize}"
    )

    subprocess.run(cmd)


def eprint(*values: object):
    print(values, file=sys.stderr)


if __name__ == "__main__":
    main()
