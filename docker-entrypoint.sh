#!/bin/sh
set -e

python - <<'PYEOF'
import time
import sys

from sqlalchemy import create_engine, text
from sqlalchemy.exc import OperationalError

from app.config import settings

engine = create_engine(settings.database_url)

for attempt in range(30):
    try:
        with engine.connect() as conn:
            conn.execute(text("SELECT 1"))
        break
    except OperationalError:
        print(f"Waiting for database... ({attempt + 1}/30)", flush=True)
        time.sleep(2)
else:
    print("Database never became available", file=sys.stderr)
    sys.exit(1)
PYEOF

alembic upgrade head

exec "$@"
