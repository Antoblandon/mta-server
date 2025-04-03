FROM ubuntu:20.04

RUN apt-get update && apt-get install -y \
    lib32z1 \
    lib32ncurses5-dev \
    lib32stdc++6 \
    wget \
    unzip

WORKDIR /mta

RUN wget https://linux.multitheftauto.com/dl/multitheftauto_linux_x64.tar.gz && \
    tar -xzf multitheftauto_linux_x64.tar.gz && \
    rm multitheftauto_linux_x64.tar.gz && \
    cd multitheftauto_linux_x64 && \
    wget https://mirror.mtasa.com/mtasa_resources/mtasa-resources-latest.zip && \
    unzip mtasa-resources-latest.zip && \
    rm mtasa-resources-latest.zip

WORKDIR /mta/multitheftauto_linux_x64

EXPOSE 22003/udp
EXPOSE 22126/tcp

CMD ["./mta-server64", "-n"]
