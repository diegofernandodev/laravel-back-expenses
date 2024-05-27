FROM ubuntu:20.04

# Configurar la zona horaria para evitar la solicitud interactiva
ENV TZ=Etc/UTC
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

# Evitar solicitudes interactivas durante la instalación de paquetes
ENV DEBIAN_FRONTEND=noninteractive

# Instalar dependencias necesarias
RUN apt-get update && apt-get install -y \
    curl sudo git jq libicu66 && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Crear un usuario para el runner
RUN useradd -m runner && echo "runner:runner" | chpasswd && adduser runner sudo

# Cambiar al usuario root
USER root
WORKDIR /runner

# Copiar los scripts al contenedor
COPY download_runner.sh /runner/download_runner.sh
COPY entrypoint.sh /runner/entrypoint.sh

# Asignar permisos de ejecución a los scripts
RUN chmod +x /runner/download_runner.sh /runner/entrypoint.sh

# Ejecutar el script de descarga
RUN /runner/download_runner.sh

# Cambiar al usuario runner
USER runner

# Definir el comando de inicio
ENTRYPOINT ["/runner/entrypoint.sh"]
