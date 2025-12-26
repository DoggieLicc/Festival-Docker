# PocketMine-MP 1.5dev-1438 fork (alpha 0.11.x)
Supported versions: 0.11.0-0.11.1 *& prob some builds*

# Features:

* Docker image with minimal Alpine base
  - Supported architectures: AMD64, ARM64
  - Images for PHP 8.0, PHP 8.1, PHP 8.2

* All mobs and eggs

* All blocks *(will be soon)*

* Some vanilla features which were not added

* Support for webhook messages in Discord

* *and some other bug fixes...*

# Running with docker compose
## Run setup wizard
You should run the setup wizard before running the server for the first time:
```
mkdir data
docker run --rm -it --mount type=bind,src=./data,dst=/server/data ghcr.io/doggielicc/festival:1.5
```
After completing the setup, you must stop the server and use the `docker-compose.yml` file to run it
```
docker compose up -d
```

# PHP8 Binaries:
The PHP Binaries are built from the [PHP-Binaries](https://github.com/pmmp/PHP-Binaries) repo, with the latest PHP versions
### PHP8.0
  - Warning: PHP 8.0 has stopped getting security fixes!
  - Built from [pm4-php-8.0-latest](https://github.com/pmmp/PHP-Binaries/tree/pm4-php-8.0-latest)
  - PHP Version: 8.0.30
  - Image tag: `ghcr.io/doggielicc/festival:1.5-php8-0`
### PHP8.1
  - Built from [pm4-php-8.1-latest](https://github.com/pmmp/PHP-Binaries/tree/pm4-php-8.1-latest)
  - PHP Version: 8.1.34
  - Image tag: `ghcr.io/doggielicc/festival:1.5-php8-1`
### PHP8.2 (Recomended)
  - Built from [pm4-php-8.2-latest](https://github.com/pmmp/PHP-Binaries/tree/pm4-php-8.2-latest)
  - PHP Version: 8.2.30
  - Image tag: `ghcr.io/doggielicc/festival:1.5-php8-2` (or `:latest`)


**Discord: [@eqozqq](https://github.com/eqozqq) thanks for removing it(WIP)**

*wonder will someone read it?*


