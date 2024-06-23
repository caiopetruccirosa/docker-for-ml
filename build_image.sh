#!/bin/bash

echo "requirements.txt file path: $1"

REQUIREMENTS_FILE=$1 docker build -t cpsrosa-dev .
