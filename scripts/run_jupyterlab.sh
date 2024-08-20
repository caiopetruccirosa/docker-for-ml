#!/bin/bash

PORT=${1:-4321}

jupyter lab --no-browser --allow-root --ip=0.0.0.0 \
    --port="$PORT" \
    --NotebookApp.token='' \
    --NotebookApp.password=''
