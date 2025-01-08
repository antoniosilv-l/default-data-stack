#!/bin/bash
set -e

echo "Verificando se o usuario ja existe..."
if ! airflow users list | grep -q "${AIRFLOW_WWW_USER_USERNAME}"; then
    echo "Usuario nao existe, criando..."
    airflow users create \
        --username "${AIRFLOW_WWW_USER_USERNAME}" \
        --firstname "${AIRFLOW_FIRST_NAME}" \
        --lastname "${AIRFLOW_LAST_NAME}" \
        --role "${AIRFLOW_WWW_USER_ROLE}" \
        --email "${AIRFLOW_WWW_USER_EMAIL}" \
        --password "${AIRFLOW_WWW_USER_PASSWORD}"
    echo "Usuario criado!"
else
    echo "Usuario ja existe! Seguindo o processo..."
fi