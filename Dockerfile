# Build stage (if you had build steps, e.g., for compiled dependencies)
FROM python:3.11-slim as base
WORKDIR /app
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt

# Production stage
FROM python:3.11-slim
WORKDIR /app
COPY --from=base /usr/local/lib/python3.11/site-packages /usr/local/lib/python3.11/site-packages
COPY --from=base /usr/local/bin /usr/local/bin
# Defensive: Remove any creds that might have slipped in
RUN rm -f gha-creds-*.json
COPY . .
# Defensive: Remove again after copy (if needed)
RUN rm -f gha-creds-*.json

# Add a non-root user for security
RUN useradd -m appuser && chown -R appuser /app
USER appuser

ENV FLASK_APP=app.py
ENV FLASK_RUN_HOST=0.0.0.0

EXPOSE 8080

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD curl -f http://localhost:8080/ || exit 1

CMD ["python", "app.py"] 