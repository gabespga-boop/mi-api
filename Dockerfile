# ── STAGE 1: builder ──────────────────────────────────────────
FROM python:3.12-slim AS builder

WORKDIR /build

COPY pyproject.toml README.md ./
COPY src/ ./src/

RUN pip install --no-cache-dir build \
 && python -m build --wheel --outdir /wheels


# ── STAGE 2: runtime ──────────────────────────────────────────
FROM python:3.12-slim AS runtime

RUN adduser --disabled-password --gecos "" appuser

WORKDIR /app

COPY --from=builder /wheels /wheels

RUN pip install --no-cache-dir /wheels/*.whl \
 && rm -rf /wheels

USER appuser

EXPOSE 8000

CMD ["uvicorn", "mi_api.main:app", "--host", "0.0.0.0", "--port", "8000"]