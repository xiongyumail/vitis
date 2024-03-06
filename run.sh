#!/bin/bash
IMAGE_NAME=$(basename $(pwd) | sed 's/[[:upper:]]/\L&/g')
IMAGE_VERSION=$(git rev-parse --abbrev-ref HEAD | sed 's/[[:upper:]]/\L&/g; s/[^[:alnum:]]/./g')

WORK_PATH=$(cd $(dirname $0); pwd)

if [[ "$1" == "clean" ]]; then
  ${WORK_PATH}/tools/gdocker/gdocker.sh clean -n ${IMAGE_NAME} -v ${IMAGE_VERSION}
  sudo rm -rf ${WORK_PATH}/.tmp
  exit 0
fi

if [[ "$(sudo docker images -q "${IMAGE_NAME}:${IMAGE_VERSION}" 2> /dev/null)" == "" ]]; then
  ${WORK_PATH}/tools/gdocker/gdocker.sh install -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -t ${WORK_PATH}/tools/tools.sh
elif [[ "$1" == "reinstall" ]]; then
  ${WORK_PATH}/tools/gdocker/gdocker.sh install -n ${IMAGE_NAME} -v ${IMAGE_VERSION}
  exit 0
fi

if [[ "$1" == "" ]]; then
  PROJECT=${WORK_PATH}/projects
else
  PROJECT=$1
fi

${WORK_PATH}/tools/gdocker/gdocker.sh start -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -c "/bin/bash /home/${IMAGE_NAME}/workspace/sessions.sh" -p $PROJECT
