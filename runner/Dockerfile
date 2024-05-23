FROM ubuntu:20.04

# Instala dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl \
    sudo \
    git \
    docker.io \
    && rm -rf /var/lib/apt/lists/*

# Crear directorio para el runner y establecer permisos
RUN mkdir /actions-runner
WORKDIR /actions-runner

# Descargar y extraer el runner
RUN curl -o actions-runner-linux-x64-2.285.1.tar.gz -L https://github.com/actions/runner/releases/download/v2.285.1/actions-runner-linux-x64-2.285.1.tar.gz \
    && tar xzf actions-runner-linux-x64-2.285.1.tar.gz \
    && rm actions-runner-linux-x64-2.285.1.tar.gz

# Copia el script de entrada
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Configura el runner
ENTRYPOINT ["/entrypoint.sh"]
