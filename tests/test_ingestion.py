from datetime import date

from ingestion import http_client
from ingestion.run import month_ranges


def test_month_ranges_split_on_month_boundary():
    assert list(month_ranges(date(2025, 1, 30), date(2025, 2, 2))) == [
        (date(2025, 1, 30), date(2025, 1, 31)),
        (date(2025, 2, 1), date(2025, 2, 2)),
    ]


def test_month_ranges_single_day():
    assert list(month_ranges(date(2025, 3, 5), date(2025, 3, 5))) == [
        (date(2025, 3, 5), date(2025, 3, 5))
    ]


class FakeResponse:
    def __init__(self, status, body=None):
        self.status_code, self._body, self.headers = status, body, {"Retry-After": "0"}

    def json(self):
        return self._body

    def raise_for_status(self):
        pass


def test_fetch_retries_after_rate_limit(monkeypatch):
    responses = iter([FakeResponse(429), FakeResponse(200, {"ok": True})])
    monkeypatch.setattr(http_client.requests, "get", lambda *a, **k: next(responses))
    monkeypatch.setattr(http_client.time, "sleep", lambda s: None)
    assert http_client.fetch("https://example.test", {}) == {"ok": True}