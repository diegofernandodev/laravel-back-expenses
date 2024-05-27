#!/bin/bash

# Asegúrate de que las variables de entorno están definidas
if [ -z "$REPO_URL" ] || [ -z "$RUNNER_TOKEN" ]; then
  echo "ERROR: REPO_URL o RUNNER_TOKEN no están definidos"
  exit 1
fi

# Cambiar al directorio del runner
cd /runner/actions-runner || exit

# Configura el runner
./config.sh --url "$REPO_URL" --token "$RUNNER_TOKEN" --unattended --replace

# Definir función de limpieza para eliminar el runner al finalizar
cleanup() {
  echo "Removing runner..."
  ./config.sh remove --unattended --token "$RUNNER_TOKEN"
}

# Capturar señales de terminación para ejecutar la limpieza
trap 'cleanup; exit 130' INT
trap 'cleanup; exit 143' TERM

# Iniciar el runner
./run.sh & wait $!
