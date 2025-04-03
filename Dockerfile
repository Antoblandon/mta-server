# Usamos una imagen base de Ubuntu 20.04
FROM ubuntu:20.04

# Instalamos las dependencias necesarias para el servidor MTA
RUN apt-get update && apt-get install -y \
    lib32z1 \
    lib32ncurses5-dev \
    lib32stdc++6 \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Establecemos el directorio de trabajo dentro del contenedor
WORKDIR /mta

# Descargamos y descomprimimos el servidor MTA
RUN wget https://linux.multitheftauto.com/dl/multitheftauto_linux_x64.tar.gz && \
    tar -xzf multitheftauto_linux_x64.tar.gz && \
    rm multitheftauto_linux_x64.tar.gz

# Copiamos el archivo de configuración mtaserver.conf al contenedor
COPY mtaserver.conf /mta/multitheftauto_linux_x64/

# Comprobamos si el archivo se copió correctamente
RUN ls -l /mta/multitheftauto_linux_x64/

# Cambiamos al directorio donde se encuentra el servidor MTA
WORKDIR /mta/multitheftauto_linux_x64

# Aseguramos que el ejecutable tenga permisos de ejecución
RUN chmod +x ./mta-server64

# Exponemos los puertos necesarios para el servidor MTA
EXPOSE 22003/udp
EXPOSE 22126/tcp

# Comando por defecto para ejecutar el servidor MTA
CMD ["./mta-server64", "-n"]
