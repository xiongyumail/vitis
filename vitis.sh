#!/bin/bash
IMAGE_NAME="vitis"
IMAGE_VERSION="2020.1"

if [[ "$(sudo docker images -q "${IMAGE_NAME}:${IMAGE_VERSION}" 2> /dev/null)" == "" ]]; then
  ./tools/gdocker/gdocker.sh install -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -t ./tools/tools.sh
fi

./tools/gdocker/gdocker.sh start -n ${IMAGE_NAME} -v ${IMAGE_VERSION} -c "/bin/bash /home/${IMAGE_NAME}/workspace/sessions.sh"
