# Usamos una imagen base de Ubuntu 20.04
FROM ubuntu:20.04

# Instalamos las dependencias necesarias
RUN apt-get update && apt-get install -y \
    lib32z1 \
    lib32ncurses5-dev \
    lib32stdc++6 \
    wget \
    unzip \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Establecemos el directorio de trabajo en el contenedor
WORKDIR /mta

# Descargamos el servidor MTA y los recursos necesarios
RUN wget https://linux.multitheftauto.com/dl/multitheftauto_linux_x64.tar.gz && \
    tar -xzf multitheftauto_linux_x64.tar.gz && \
    rm multitheftauto_linux_x64.tar.gz && \
    cd multitheftauto_linux_x64 && \
    wget https://mirror.mtasa.com/mtasa_resources/mtasa-resources-latest.zip && \
    unzip mtasa-resources-latest.zip && \
    rm mtasa-resources-latest.zip

# Establecemos el directorio correcto dentro de la estructura del servidor
WORKDIR /mta/multitheftauto_linux_x64

# Exponemos los puertos necesarios para el servidor MTA
EXPOSE 22003/udp
EXPOSE 22126/tcp

# Comando por defecto para ejecutar el servidor MTA
CMD ["./mta-server64", "-n"]
