# playground

A deliberately simple 3-service app used to practice Dockerfiles, Helm, ArgoCD, and CI pipelines.

## Services

- **web** (`services/web`) — nginx. Serves the static frontend and reverse-proxies `/api/` to the `app` service.
- **app** (`services/app`) — Python/Flask API. On `GET /api/visits`, records a visit in Postgres and returns the running count. `GET /healthz` for health checks.
- **db** (`services/db`) — Postgres, initialized with a `visits` table via `init.sql`.

## Running locally

```
docker compose up --build
```

Then open http://localhost:8080 — each page load hits the API, which increments and returns the visit count from Postgres.

## Configuration

The `app` service reads its DB connection from environment variables (all default to matching the `db` service in `docker-compose.yml`):

- `DB_HOST` (default `db`)
- `DB_PORT` (default `5432`)
- `DB_NAME` (default `playground`)
- `DB_USER` (default `playground`)
- `DB_PASSWORD` (default `playground`)

## Roadmap

Images are built manually from these Dockerfiles. Helm charts, GitLab CI, and ArgoCD manifests come next.
