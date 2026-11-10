#!/usr/bin/env python3

import argparse
import re
import signal
import shutil
import subprocess
import sys
import time
from pathlib import Path

DEFAULT_CONFIG = {
    "player": "mpris",
    "color": "#8aadf4",
    "font": "block",
    "width": "auto",
    "uppercase": "true",
    "solid": "true",
    "thickness": "1",
    "stable_width": "0",
    "sync_mode": "word",
    "empty_text": "Waiting for lyrics...",
}

ANSI_RE = re.compile(r"\x1b\[[0-9;]*m")

def load_config(path: Path) -> dict:
    config = DEFAULT_CONFIG.copy()
    if not path.exists():
        return config
    for raw_line in path.read_text(encoding="utf-8").splitlines():
        line = raw_line.strip()
        if not line or line.startswith("#") or "=" not in line:
            continue
        key, value = line.split("=", 1)
        config[key.strip()] = value.strip()
    return config

def hex_to_rgb(color: str) -> tuple[int, int, int]:
    value = color.strip().lstrip("#")
    if len(value) != 6 or not re.fullmatch(r"[0-9a-fA-F]{6}", value):
        return (138, 173, 244)
    return tuple(int(value[i : i + 2], 16) for i in (0, 2, 4))

def colorize(text: str, color: str) -> str:
    r, g, b = hex_to_rgb(color)
    return f"\033[38;2;{r};{g};{b}m{text}\033[0m"

def render_figlet(text: str, font: str, width: str) -> str:
    figlet_cmd = ["figlet", "-f", font, "-k"]
    if width == "auto":
        term_width = shutil.get_terminal_size().columns
        figlet_cmd.extend(["-w", str(term_width)])
    else:
        figlet_cmd.extend(["-w", width])
    try:
        result = subprocess.run(figlet_cmd + [text], check=True, capture_output=True, text=True)
        return result.stdout
    except:
        return text + "\n"

def clean_line(line: str) -> str:
    return ANSI_RE.sub("", line).strip()

def solidify_art(art: str) -> str:
    lines = art.splitlines()
    new_lines = []
    for line in lines:
        processed = "".join("█" if ch not in (" ", "\t", "\n", "\r") else " " for ch in line)
        new_lines.append(processed)
    return "\n".join(new_lines) + "\n"

def thicken_art(art: str, thickness: int) -> str:
    if thickness <= 1:
        return art
    out_lines = []
    for line in art.rstrip("\n").splitlines():
        widened = "".join(ch * thickness for ch in line)
        for _ in range(thickness):
            out_lines.append(widened)
    return "\n".join(out_lines) + "\n"

def fit_single_screen_art(text: str, font: str, width: str, solid: bool, thickness: int, term_width: int) -> str:
    art = render_figlet(text, font, width)
    if solid: art = solidify_art(art)
    art = thicken_art(art, thickness)
    return art

def center_art(art: str, stable_width: int) -> str:
    term_size = shutil.get_terminal_size(fallback=(120, 30))
    raw_lines = art.rstrip("\n").splitlines()
    if not raw_lines: return art
    content_width = max((len(line) for line in raw_lines), default=0)
    anchor_width = stable_width if stable_width > 0 else content_width
    left_anchor = max((term_size.columns - anchor_width) // 2, 0)
    centered_lines = []
    for line in raw_lines:
        pad = " " * max(left_anchor + (anchor_width - len(line)) // 2, 0)
        centered_lines.append(pad + line)
    top_pad = "\n" * max((term_size.lines - len(centered_lines)) // 2, 0)
    return top_pad + "\n".join(centered_lines) + "\n"

def print_screen(art: str, color: str, stable_width: int) -> None:
    sys.stdout.write("\033[2J\033[H")
    sys.stdout.write(colorize(center_art(art, stable_width), color))
    sys.stdout.flush()

def main() -> int:
    parser = argparse.ArgumentParser()
    parser.add_argument("-c", "--config", default=str(Path.home() / ".config/hypr/scripts/lyricslava.conf"))
    args = parser.parse_args()
    config = load_config(Path(args.config))
    
    player = config.get("player", "mpris")
    color = config.get("color", "#8aadf4")
    font = config.get("font", "block")
    width = config.get("width", "auto")
    uppercase = config.get("uppercase", "true").lower() in {"1", "true", "yes"}
    solid = config.get("solid", "true").lower() in {"1", "true", "yes"}
    thickness = max(1, int(config.get("thickness", "1")))
    stable_width = max(0, int(config.get("stable_width", "0")))
    sync_mode = config.get("sync_mode", "word").strip().lower()

    def shutdown(*_: object) -> None:
        sys.stdout.write("\033[0m\n")
        sys.stdout.flush()
        raise SystemExit(0)

    signal.signal(signal.SIGINT, shutdown)
    signal.signal(signal.SIGTERM, shutdown)

    proc = subprocess.Popen(["sptlrx", "pipe", "-p", player], stdout=subprocess.PIPE, stderr=subprocess.DEVNULL, text=True, bufsize=1)

    last_line_time = time.time()
    for raw in proc.stdout:
        line = clean_line(raw)
        if not line: continue
        
        now = time.time()
        line_duration = min(now - last_line_time, 4.0) if last_line_time else 3.0
        last_line_time = now
        
        words = line.split()
        if sync_mode == "word" and words:
            total_chars = sum(len(w) for w in words)
            for word in words:
                term_width = shutil.get_terminal_size().columns
                txt = word.upper() if uppercase else word
                art = fit_single_screen_art(txt, font, width, solid, thickness, term_width)
                print_screen(art, color, stable_width)
                word_share = len(word) / total_chars
                wait_time = max(0.2, min(line_duration * word_share, 1.5))
                time.sleep(wait_time)
        else:
            term_width = shutil.get_terminal_size().columns
            txt = line.upper() if uppercase else line
            art = fit_single_screen_art(txt, font, width, solid, thickness, term_width)
            print_screen(art, color, stable_width)

    return 0

if __name__ == "__main__":
    main()
