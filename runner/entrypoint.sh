#!/bin/bash

# Variables necesarias
URL=${REPO_URL}
TOKEN=${RUNNER_TOKEN}

# Configura el runner
./config.sh --url $URL --token $TOKEN --unattended --replace

# Inicia el runner
./run.sh
