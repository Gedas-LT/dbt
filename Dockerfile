FROM python:3.12-slim-bookworm

ENV PYTHONDONTWRITEBYTECODE=1 \
    PYTHONUNBUFFERED=1 \
    DBT_PROFILES_DIR=/usr/app

RUN apt-get update \
    && apt-get install -y --no-install-recommends git \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /usr/app

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt \
    && dbt system install-drivers

COPY dbt_project.yml profiles.yml ./
COPY macros ./macros
COPY models ./models
COPY seeds ./seeds
COPY snapshots ./snapshots
COPY tests ./tests
COPY analyses ./analyses

ENTRYPOINT ["dbt"]
CMD ["--version"]