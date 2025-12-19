FROM dhi.io/debian-base:bookworm

LABEL org.opencontainers.image.source=https://github.com/DoggieLicc/Festival-Docker

ARG PHP_BINARY_URL=https://github.com/pmmp/PHP-Binaries/releases/download/pm4-php-8.2-latest/PHP-8.2-Linux-x86_64-PM4.tar.gz

RUN apt update && apt install -y wget net-tools hostname && apt clean

RUN wget -qO- $PHP_BINARY_URL | tar -kxzf -

RUN EXTENSION_DIR=$(find "/usr/bin" -name "*debug-zts*") && \
    grep -q '^extension_dir' bin/php7/bin/php.ini && \
    sed -i'bak' "s{^extension_dir=.*{extension_dir=\"$EXTENSION_DIR\"{" bin/php7/bin/php.ini || \
    echo "extension_dir=\"$EXTENSION_DIR\"" >> bin/php7/bin/php.ini

ENV PATH="/bin/php7/bin/:${PATH}"

WORKDIR /server

COPY ./src/ src/

RUN mkdir data && \
    mkdir logs && \
    ln -s data/banned-ips.txt banned-ips.txt && \
    ln -s data/festival.yml festival.yml && \
    ln -s data/ops.data ops.txt && \
    ln -s data/pocketmine.yml pocketmine.yml && \
    ln -s data/server.properties server.properties && \
    ln -s data/white-list.txt white-list.txt && \
    ln -s server.log logs/server.log

EXPOSE 19132/udp

CMD ["php", "src/pocketmine/PocketMine.php"]
