FROM python:3.12-slim-bookworm

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

RUN groupadd -r airflow \
    && useradd -r -m -g airflow airflow

RUN mkdir /opt/airflow \
    && mkdir \
        /opt/airflow/dags \
        /opt/airflow/logs \
        /opt/airflow/logs/scheduler \
        /opt/airflow/plugins \
        /opt/airflow/config \ 
    && chown -R airflow:airflow /opt/airflow/ \
    && chmod -R 755 /opt/airflow

# =====================================================
USER airflow

WORKDIR /opt/airflow

ENV PATH="/home/airflow/.local/bin:$PATH"
ENV AIRFLOW_VERSION=2.10.3
ENV AIRFLOW_HOME=/opt/airflow

COPY ./config ${AIRFLOW_HOME}/config
COPY ./dags ${AIRFLOW_HOME}/dags
COPY ./logs ${AIRFLOW_HOME}/logs
COPY ./plugins ${AIRFLOW_HOME}/plugins

RUN PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')" \
    && CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" \
    && pip install --upgrade pip setuptools wheel \
    && pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}" \
    && pip install apache-airflow-providers-postgres

ENTRYPOINT ["airflow"]