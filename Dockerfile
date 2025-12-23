# Building Stage
FROM alpine:3.20.8 AS build-stage

RUN apk add --no-interactive -U git wget build-base bash autoconf automake m4 bison cmake re2c libtool pkgconf linux-headers && \
    apk cache clean

WORKDIR /build

RUN git clone --depth 1 --branch pm4-php-8.2-latest https://github.com/pmmp/PHP-Binaries.git

WORKDIR /build/PHP-Binaries

RUN ./compile.sh -P4 -g -j4

RUN mv /build/PHP-Binaries/bin/php7 /bin/php7

ENV PATH="/bin/php7/bin:${PATH}"

RUN EXTENSION_DIR=$(find "/bin" -name "*debug-zts*") && \
    grep -q '^extension_dir' /bin/php7/bin/php.ini && \
    sed -i'bak' "s{^extension_dir=.*{extension_dir=\"$EXTENSION_DIR\"{" /bin/php7/bin/php.ini || \
    echo "extension_dir=\"$EXTENSION_DIR\"" >> /bin/php7/bin/php.ini

WORKDIR /build/

COPY ./src/ server/src

COPY create-phar.php .

RUN php --define phar.readonly=0 create-phar.php

# Runtime stage
FROM alpine:3.23 AS runtime-stage

COPY --from=build-stage /bin/php7 /bin/php7

RUN apk add --no-interactive -U ncurses libgcc libstdc++ && apk cache clean

ENV PATH="/bin/php7/bin:${PATH}"

WORKDIR /server

COPY --from=build-stage /build/PocketMine-MP.phar .

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

CMD ["php", "PocketMine-MP.phar"]
