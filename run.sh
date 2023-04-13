#!/bin/bash
##
## Copyright (c) 2023 VIDAL & ASTUDILLO Ltda and others.
##
## This program and the accompanying materials are made available under the
## terms of the MIT License which accompanies this distribution, and is 
## available at:
## https://github.com/vidalastudillo/provision_pi/blob/main/LICENSE
##

##
## Utility to manage the container
##


set -e  # Exit immediately if a command exits with a non-zero status
set -u  # Treat unset variables as an error when substituting.


# Load environment variables
echo "Environment file path: ${PWD}"
set -a; source .env; set +a


PI_COMPOSE_FILE_NAME="${PI_BASE_FILE_NAME}.yml"
AVAILABLE_PARAMETERS_MESSAGE="Available parameters: {start|stop|restart|rebuild|attach}"


# Check that one argument has been received
if [ $# -ne 1 ]
  then
    echo "This script requires one parameter"
    echo "${AVAILABLE_PARAMETERS_MESSAGE}"
    exit 1
fi


do_container_start() {
    echo "Project: ${PI_PROJECT_NAME}, UP"
    docker-compose --project-name "${PI_PROJECT_NAME}" --file "${PI_COMPOSE_FILE_NAME}" up -d
    echo "OK"
}

do_container_rebuild_and_start() {
    echo "Project: ${PI_PROJECT_NAME}, PULL"
    docker-compose --project-name "${PI_PROJECT_NAME}" --file "${PI_COMPOSE_FILE_NAME}" pull
    echo "Project: ${PI_PROJECT_NAME}, UP and BUILD"
    docker-compose --project-name "${PI_PROJECT_NAME}" --file "${PI_COMPOSE_FILE_NAME}" up -d --build
    echo "OK"
}

do_container_stop() {
    echo "Project: ${PI_PROJECT_NAME}, DOWN"
    docker-compose --project-name "${PI_PROJECT_NAME}" --file "${PI_COMPOSE_FILE_NAME}" down
    echo "OK"
}


case "$1" in
        start)
                do_container_start
                ;;
        stop)
                do_container_stop
                ;;
        restart)
                do_container_stop
                sleep 1
                do_container_start
                ;;
        rebuild)
                do_container_rebuild_and_start
                ;;
        attach)
                docker attach "${PI_PROJECT_NAME}_provision_pi"
                ;;
	*)
                echo "${AVAILABLE_PARAMETERS_MESSAGE}"
                exit 1
esac
