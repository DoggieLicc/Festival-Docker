group "default" {
  targets = [
    "php82",
    "php81",
    "php80",
  ]
}

## Version Variables
variable "MAJOR_VER" {  # 1.x.x-xxxxxxx
    default = "1"
}

variable "MINOR_VER" {  # x.5.x-xxxxxxx
    default = "5"
}

variable "PATCH_VER" {  # x.x.5-xxxxxxx
    default = "5"
}

variable "HASH_VER" {  # x.x.x-00c631d
    default = "00c631d"
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

target "_base" {
  dockerfile = "Dockerfile.multiarch"
  context    = "."
  platforms  = ["linux/amd64", "linux/arm64"]
  provenance = false
  push = true
  output = ["type=registry"]

  annotations = [
    "index:org.opencontainers.image.description=A Containerized PocketMine-MP 1.5dev-1438 fork"
  ]
}

# PHP 8.2 (Latest)
target "php82" {
  inherits = ["_base"]

  args = {
    PHP_VERSION = "8.2.30"
  }

  tags = [
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}-${PATCH_VER}",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}",
    "${IMAGE_URL_BASE}:${MAJOR_VER}",
    "${IMAGE_URL_BASE}:latest",

    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}-${PATCH_VER}-php8-2",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-php8-2",
    "${IMAGE_URL_BASE}:${MAJOR_VER}-php8-2",
    "${IMAGE_URL_BASE}:latest-php8-2",
  ]
}

# PHP 8.1
target "php81" {
  inherits = ["_base"]

  args = {
    PHP_TAG     = "8.1"
    PHP_VERSION = "8.1.34"
  }

  tags = [
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}-${PATCH_VER}-php8-1",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-php8-1",
    "${IMAGE_URL_BASE}:${MAJOR_VER}-php8-1",
  ]
}

# PHP 8.0
target "php80" {
  inherits = ["_base"]

  args = {
    PHP_TAG     = "8.0"
    PHP_VERSION = "8.0.30"
  }

  tags = [
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-${HASH_VER}-${PATCH_VER}-php8-0",
    "${IMAGE_URL_BASE}:${MAJOR_VER}.${MINOR_VER}-php8-0",
    "${IMAGE_URL_BASE}:${MAJOR_VER}-php8-0",
  ]
}
