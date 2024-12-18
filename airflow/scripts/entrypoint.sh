#!/usr/bin/env bash
export AIRFLOW_HOME=/opt/airflow


if [ "$1" = "bash" ]; then
    exec /bin/bash
else
    if [ "$1" = "webserver" ] || [ "$1" = "scheduler" ]; then
        echo "Initializing database..."
        airflow db init
    fi
    exec python -m airflow "$@"
fi


