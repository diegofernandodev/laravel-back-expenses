FROM ubuntu:20.04

# Configurar la zona horaria para evitar la solicitud interactiva
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Evitar solicitudes interactivas durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl sudo git jq libicu66 gnupg lsb-release apt-transport-https ca-certificates software-properties-common && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Instalar Docker
RUN curl -fsSL https://download.docker.com/linux/ubuntu/gpg | apt-key add - && \
    add-apt-repository \
    "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" && \
    apt-get update && apt-get install -y docker-ce docker-ce-cli containerd.io

# Crear un usuario para el runner
RUN useradd -m runner && echo "runner:runner" | chpasswd && adduser runner sudo

# Cambiar al usuario root
USER root

# Agregar el usuario al grupo docker
RUN usermod -aG docker runner

WORKDIR /runner

# Copiar los scripts al contenedor
COPY download_runner.sh /runner/download_runner.sh
COPY entrypoint.sh /runner/entrypoint.sh

# Asignar permisos de ejecución a los scripts
RUN chmod +x /runner/download_runner.sh /runner/entrypoint.sh

# Ejecutar el script de descarga
RUN /runner/download_runner.sh

# Instalar dependencias del runner
RUN /runner/actions-runner/bin/installdependencies.sh

# Cambiar al usuario runner
USER runner

# Definir el comando de inicio
ENTRYPOINT ["/runner/entrypoint.sh"]
