FROM python:3.12-slim-bookworm

# =====================================================
USER root

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential \
        libopenmpi-dev \
    && apt-get autoremove -yqq --purge \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

RUN groupadd -r airflow && useradd -r -m -g airflow airflow

RUN mkdir /opt/airflow && chown airflow:airflow /opt/airflow

RUN chmod 755 /opt/airflow/

# =====================================================
USER airflow

WORKDIR /opt/airflow

ENV PATH="/home/airflow/.local/bin:$PATH"
ENV AIRFLOW_VERSION=2.10.3
ENV AIRFLOW_HOME=/opt/airflow 

COPY config/ ${AIRFLOW_HOME}/config
COPY dags/ ${AIRFLOW_HOME}/dags
COPY logs/ ${AIRFLOW_HOME}/logs
COPY plugins/ ${AIRFLOW_HOME}/plugins

RUN PYTHON_VERSION="$(python -c 'import sys; print(f"{sys.version_info.major}.{sys.version_info.minor}")')" \
    && CONSTRAINT_URL="https://raw.githubusercontent.com/apache/airflow/constraints-${AIRFLOW_VERSION}/constraints-${PYTHON_VERSION}.txt" \
    && pip install "apache-airflow==${AIRFLOW_VERSION}" --constraint "${CONSTRAINT_URL}"

CMD ["bash"]