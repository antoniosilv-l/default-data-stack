#!/bin/bash
export $(grep -v '^#' .env | xargs)

docker exec -i airflow-webserver /bin/bash -c "
    export AIRFLOW_WWW_USER_USERNAME='$AIRFLOW_WWW_USER_USERNAME'
    export AIRFLOW_FIRST_NAME='$AIRFLOW_FIRST_NAME'
    export AIRFLOW_LAST_NAME='$AIRFLOW_LAST_NAME'
    export AIRFLOW_WWW_USER_ROLE='$AIRFLOW_WWW_USER_ROLE'
    export AIRFLOW_WWW_USER_EMAIL='$AIRFLOW_WWW_USER_EMAIL'
    export AIRFLOW_WWW_USER_PASSWORD='$AIRFLOW_WWW_USER_PASSWORD'
    /get_create_user.sh
"
