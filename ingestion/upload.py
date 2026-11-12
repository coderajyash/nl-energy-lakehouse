import io
import json

from databricks.sdk import WorkspaceClient

VOLUME = "/Volumes/workspace/bronze/landing"
_client = None

def upload_json(relative_path: str, payload: dict) -> None:
    """Write one API response, unchanged, to the landing volume."""
    global _client
    if _client is None:
        _client = WorkspaceClient()   # reads DATABRICKS_HOST and DATABRICKS_TOKEN
    data = io.BytesIO(json.dumps(payload).encode("utf-8"))
    _client.files.upload(f"{VOLUME}/{relative_path}", data, overwrite=True)
    print(f"uploaded {relative_path}")