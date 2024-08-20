#!/bin/bash

DEFAULT_IMAGE_TAG="default-env" # could be "age-benchmark-dev", "facial-age-estimation-dev", etc.
DEFAULT_DATA_DIR="/hadatasets/facial-age-estimation"

IMAGE_TAG=${IMAGE_TAG:-DEFAULT_IMAGE_TAG}
CONTAINER_NAME=${IMAGE_TAG}-container

PORT=${PORT:-4321}

DATA_DIR=${DATA_DIR:-DEFAULT_DATA_DIR}
WORK_DIR=${WORK_DIR:-$PWD}

RAM_SIZE="32g"

exec docker run \
    --gpus all \
    --shm-size=$RAM_SIZE \
    -p "$PORT":"$PORT" \
    -v "$WORK_DIR":/workspace \
    -v "$DATA_DIR":/datasets \
    -d -it --rm \
    --name "$CONTAINER_NAME" \
    "$IMAGE_TAG"
    bash