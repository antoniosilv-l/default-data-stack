FROM python:3.12-slim-bookworm

ENV PATH="/home/airflow/.local/bin:$PATH"
ENV PYTHONPATH="/home/airflow/.local/lib/python3.12/site-packages:$PYTHONPATH"
ENV AIRFLOW_HOME=/opt/airflow

WORKDIR ${AIRFLOW_HOME}

# =====================================================
USER root

RUN apt-get update \
    && apt-get upgrade -y \
    && apt-get install -y --no-install-recommends \
        gcc \
        libpq-dev \
        libsasl2-dev \
        libssl-dev \
        libffi-dev \
        build-essential \
        curl \
        gnupg2 \
        ca-certificates \
        libcurl4-openssl-dev \
        libjpeg-dev \
        liblcms2-dev \
        zlib1g-dev \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

COPY scripts/entrypoint.sh /entrypoint.sh

RUN groupadd -r airflow \
    && useradd -r -m -g airflow airflow

RUN mkdir -p \
        dags \
        logs \
        plugins \
        config \
    && chown -R airflow:airflow /opt/airflow/ \
    && chmod -R 755 /opt/airflow \
    && chmod +x /entrypoint.sh

# =====================================================
USER airflow

ENV AIRFLOW_VERSION=2.10.3

RUN PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')" \
    && CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" \
    && pip install --upgrade pip setuptools wheel \
    && pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}" \
    && pip install apache-airflow-providers-postgres

ENTRYPOINT ["/entrypoint.sh"]