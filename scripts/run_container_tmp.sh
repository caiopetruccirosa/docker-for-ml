#!/bin/bash

IMAGE_TAG=${IMAGE_TAG:-facial-age-estimation-dev}
CONTAINER_NAME=${IMAGE_TAG}-container

PORT=${PORT:-4321}

DATA_DIR=${DATA_DIR:-/hadatasets/facial-age-estimation}
WORK_DIR=${WORK_DIR:-$PWD}

echo "Datasets directory: $DATA_DIR"
echo "Work directory: $WORK_DIR"
echo "Container Name: $CONTAINER_NAME"

exec docker run \
    --gpus all \
    --shm-size=8g \
    -p "$PORT":"$PORT" \
    -v "$WORK_DIR":/work/notebooks \
    -v "$DATA_DIR":/datasets \
    -d -it --rm \
    --name "$CONTAINER_NAME" \
    "$IMAGE_TAG"
    bash
