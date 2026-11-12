import argparse
import time
from datetime import date, timedelta

from ingestion import energy_charts, open_meteo
from ingestion.upload import upload_json

PAUSE_SECONDS = 35   # stay under ~2 requests per minute per endpoint

def month_ranges(start: date, end: date):
    """Split a date range into calendar-month chunks: (first_day, last_day)."""
    s = start
    while s <= end:
        next_month = (s.replace(day=1) + timedelta(days=32)).replace(day=1)
        e = min(end, next_month - timedelta(days=1))
        yield s, e
        s = e + timedelta(days=1)

def main() -> None:
    parser = argparse.ArgumentParser()
    parser.add_argument("--start", help="YYYY-MM-DD; default yesterday")
    parser.add_argument("--end", help="YYYY-MM-DD; default tomorrow")
    args = parser.parse_args()

    today = date.today()
    start = date.fromisoformat(args.start) if args.start else today - timedelta(days=1)
    end = date.fromisoformat(args.end) if args.end else today + timedelta(days=1)

    for s, e in month_ranges(start, end):
        name = f"{s}_{e}.json"
        upload_json(f"price/{name}", energy_charts.get_price(s, e))
        time.sleep(PAUSE_SECONDS)
        upload_json(f"power/{name}", energy_charts.get_power(s, e))
        time.sleep(PAUSE_SECONDS)

    # The weather archive runs about five days behind, so stop there.
    w_start = start if args.start else today - timedelta(days=10)
    w_end = min(end, today - timedelta(days=5))
    if w_start <= w_end:
        upload_json(f"weather/{w_start}_{w_end}.json", open_meteo.get_weather(w_start, w_end))


if __name__ == "__main__":
    main()