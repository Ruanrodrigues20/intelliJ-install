#!/usr/bin/env python3
import sys
import json
import time
from pathlib import Path

import requests

# ===============================
# Config
# ===============================
HOURS = 1
CACHE_TTL = 60 * 60 * HOURS
BASE_URL = "https://data.services.jetbrains.com/products/releases"

# Cache dentro do projeto (utils/cache)
CACHE_DIR = Path(__file__).parent / "cache"
CACHE_DIR.mkdir(exist_ok=True)


def is_cache_valid(cache_file: Path) -> bool:
    if not cache_file.exists():
        return False
    age = time.time() - cache_file.stat().st_mtime
    return age < CACHE_TTL


def load_from_cache(cache_file: Path) -> dict:
    with cache_file.open() as f:
        return json.load(f)


def save_to_cache(cache_file: Path, data: dict):
    with cache_file.open("w") as f:
        json.dump(data, f)


def fetch_latest_release(product_code: str) -> dict:
    url = f"{BASE_URL}?code={product_code}&latest=true&type=release"
    resp = requests.get(url, timeout=5)
    resp.raise_for_status()
    return resp.json()


def extract_linux_link(data: dict, product_code: str) -> str:
    releases = data.get(product_code)
    if not releases:
        raise ValueError(f"No release data for product '{product_code}'")

    downloads = releases[0].get("downloads", {})

    # Prefer linux x86_64
    if "linux" in downloads:
        return downloads["linux"]["link"]

    raise ValueError("No Linux download available")


def get_latest_linux_link(product_code: str):
    cache_file = CACHE_DIR / f"{product_code}.json"

    try:
        if is_cache_valid(cache_file):
            data = load_from_cache(cache_file)
        else:
            data = fetch_latest_release(product_code)
            save_to_cache(cache_file, data)

        link = extract_linux_link(data, product_code)

        # 🔹 SAÍDA FINAL (uma única linha)
        print(link)

    except requests.RequestException as e:
        print(f"Network error: {e}", file=sys.stderr)
        sys.exit(1)
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)


if __name__ == "__main__":
    if len(sys.argv) != 2:
        print(f"Usage: {sys.argv[0]} <PRODUCT_CODE>", file=sys.stderr)
        sys.exit(1)

    get_latest_linux_link(sys.argv[1])
