from datetime import date

from ingestion.http_client import fetch

URL = "https://archive-api.open-meteo.com/v1/archive"


def get_weather(start: date, end: date) -> dict:
    return fetch(URL, {
        "latitude": 52.10, "longitude": 5.18,    #  For KNMI De Bilt
        "start_date": str(start), "end_date": str(end),
        "hourly": "temperature_2m,wind_speed_10m,shortwave_radiation",
        "timezone": "UTC",
    })