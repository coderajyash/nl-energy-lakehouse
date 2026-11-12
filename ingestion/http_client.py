import time

import requests


def fetch(url: str, params: dict, tries: int = 5) -> dict:
    for attempt in range(1, tries + 1):
        try:
            r = requests.get(url, params=params, timeout=60)
        except requests.RequestException as err:
            print(f"attempt {attempt}: network error {err}")
            time.sleep(10 * attempt)
            continue
        if r.status_code == 429:
            wait = int(r.headers.get("Retry-After", 60))
            print(f"attempt {attempt}: rate limited, waiting {wait}s")
            time.sleep(wait)
            continue
        if r.status_code >= 500:
            time.sleep(10 * attempt)
            continue
        r.raise_for_status()
        return r.json()
    raise RuntimeError(f"Gave up after {tries} tries: {url} {params}")