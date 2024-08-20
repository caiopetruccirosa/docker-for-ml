#!/bin/bash

IMAGE_TAG=${IMAGE_TAG:-facial-age-estimation-dev}
USERNAME=${USERNAME:-$(id -un)}
USER_UID=${USER_UID:-$(id -u)}
USER_GNAME=${USER_GNAME:-$(id -gn)}
USER_GID=${USER_GID:-$(id -g)}

docker build --rm --shm-size=32g \
    --build-arg USERNAME="$USERNAME" \
    --build-arg USER_UID="$USER_UID" \
    --build-arg USER_GID="$USER_GID" \
    --build-arg USER_GNAME="$USER_GNAME" \
    -t "$IMAGE_TAG" \
    .
