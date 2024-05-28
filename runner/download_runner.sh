#!/bin/bash

# Descargar y configurar el runner de GitHub
RUNNER_VERSION="2.316.1"
RUNNER_ARCHIVE="actions-runner-linux-x64-${RUNNER_VERSION}.tar.gz"
RUNNER_URL="https://github.com/actions/runner/releases/download/v${RUNNER_VERSION}/${RUNNER_ARCHIVE}"

# Crear el directorio para el runner
mkdir -p /runner/actions-runner
cd /runner/actions-runner

# Descargar el runner
curl -o ${RUNNER_ARCHIVE} -L ${RUNNER_URL}
echo "d62de2400eeeacd195db91e2ff011bfb646cd5d85545e81d8f78c436183e09a8  ${RUNNER_ARCHIVE}" | shasum -a 256 -c

# Extraer el runner
tar xzf ./${RUNNER_ARCHIVE}

# Eliminar el archivo tar
rm ./${RUNNER_ARCHIVE}

# Instalar dependencias del runner
./bin/installdependencies.sh
