group "default" {
  targets = [
    "latest",
    "matrix-builder"
  ]
}

group "export" {
  targets = [
    "bin-export",
    "phar-export"
  ]
}

group "release" {
  targets = [
    "default",
    "export"
  ]
}

## Version Variables
variable "MAJOR_VER" {  # 1.x-xxxxxxx
    default = "1"
}

variable "MINOR_VER" {  # x.5-xxxxxxx
    default = "5"
}

variable "HASH_VER" {  # x.x-00c631d
    default = "02a74de"
}

## Registry Variables
variable "IMG_NAME" {
    default = "festival"
}

variable "REGISTRY" {
    default = "ghcr.io"
}

variable "USERNAME" {
    default = "doggielicc"
}

variable "IMAGE_URL_BASE" {
    default = "${REGISTRY}/${USERNAME}/${IMG_NAME}"
}

variable "IMAGE_DESCRIPTION" {
    default = "A Containerized PocketMine-MP 1.5dev-1438 fork"
}

variable "IMAGE_SOURCE" {
    default = "https://github.com/DoggieLicc/Festival-Docker"
}

## Caching
variable "CACHE_REGISTRY" {
    default = "${REGISTRY}"
}

variable "CACHE_REGISTRY_USERNAME" {
    default = "${USERNAME}"
}

variable "CACHE_REGISTRY_IMG_NAME" {
    default = "${IMG_NAME}-cache"
}

variable "CACHE_REGISTRY_URL" {
    default = "${CACHE_REGISTRY}/${CACHE_REGISTRY_USERNAME}/${CACHE_REGISTRY_IMG_NAME}"
}

target "_base" {
  dockerfile = "Dockerfile.multiarch"
  context    = "."
  target     = "runtime-stage"
  platforms  = ["linux/amd64", "linux/arm64"]
  provenance = false
  output = ["type=registry"]

  annotations = [
    "index:org.opencontainers.image.description=${IMAGE_DESCRIPTION}",
    "index:org.opencontainers.image.source=${IMAGE_SOURCE}"
  ]

}

target "matrix-builder" {
  name = "festival-${item.tgt}"
  inherits = ["_base"]
  matrix = {
    item = [
      {
        tgt = "php8-0"
        php_tag = "8.0"
        php_ver = "8.0.30"
      },
      {
        tgt = "php8-1"
        php_tag = "8.1"
        php_ver = "8.1.34"
      },
      {
        tgt = "php8-2"
        php_tag = "8.2"
        php_ver = "8.2.30"
      }
    ]
  }

  args = {
    PHP_TAG = item.php_tag
    PHP_VERSION = item.php_ver
  }

  tags = [
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}-${item.tgt}",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${item.tgt}"
  ]

  cache-to = [
    {
        type = "registry",
        ref = "${CACHE_REGISTRY_URL}:${item.tgt}",
        mode = "max",
        compression = "zstd",
        oci-mediatypes = true,
        image-manifest = true
    }
  ]

  cache-from = [
    {
        type = "registry",
        ref = "${CACHE_REGISTRY_URL}:${item.tgt}",
    }
  ]
}

target "bin-export" {
  name = "festival-${item.tgt}-export"
  inherits = ["_base"]
  target = "bin-export"

  matrix = {
    item = [
      {
        tgt = "php8-0"
        php_tag = "8.0"
        php_ver = "8.0.30"
      },
      {
        tgt = "php8-1"
        php_tag = "8.1"
        php_ver = "8.1.34"
      },
      {
        tgt = "php8-2"
        php_tag = "8.2"
        php_ver = "8.2.30"
      }
    ]
  }

  args = {
    PHP_TAG = item.php_tag
    PHP_VERSION = item.php_ver
  }

  tags = [
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}-${item.tgt}",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${item.tgt}"
  ]

  cache-from = [
    {
        type = "registry",
        ref = "${CACHE_REGISTRY_URL}:${item.tgt}",
    }
  ]

  output = ["type=local,dest=out"]
}

target "phar-export" {
  dockerfile = "Dockerfile.multiarch"
  context    = "."
  target     = "phar-export"
  platforms  = ["linux/amd64"]
  provenance = false
  output     = ["type=local,dest=out"]

  cache-from = [
    {
        type = "registry",
        ref = "${CACHE_REGISTRY_URL}:php8-2",
    }
  ]
}

# PHP 8.2 (Latest)
target "latest" {
  inherits = ["_base"]

  args = {
    PHP_VERSION = "8.2.30"
  }

  tags = [
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}",
    "${IMAGE_URL_BASE}:latest",
  ]

  cache-to = [
    {
        type = "registry",
        ref = "${CACHE_REGISTRY_URL}:php8-2",
        mode = "max",
        compression = "zstd",
        oci-mediatypes = true,
        image-manifest = true
    }
  ]

  cache-from = [
    {
        type = "registry",
        ref = "${CACHE_REGISTRY_URL}:php8-2",
    }
  ]
}
