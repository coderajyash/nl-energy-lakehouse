from datetime import date

from ingestion.http_client import fetch

BASE = "https://api.energy-charts.info"

def get_price(start: date, end: date) -> dict:
    return fetch(f"{BASE}/price", {"bzn": "NL", "start": str(start), "end": str(end)})


def get_power(start: date, end: date) -> dict:
    
    return fetch(f"{BASE}/public_power", {"country": "nl", "start": str(start), "end": str(end)})