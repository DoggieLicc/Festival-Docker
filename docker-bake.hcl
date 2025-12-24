group "default" {
  targets = [
    "php82",
    "php81",
    "php80",
  ]
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
    "ghcr.io/doggielicc/festival:1.5-00c631d-5",
    "ghcr.io/doggielicc/festival:1.5",
    "ghcr.io/doggielicc/festival:1",
    "ghcr.io/doggielicc/festival:latest",

    "git.doggieli.cc/doggie/festival:1.5-00c631d-5",
    "git.doggieli.cc/doggie/festival:1.5",
    "git.doggieli.cc/doggie/festival:1",
    "git.doggieli.cc/doggie/festival:latest",

    "ghcr.io/doggielicc/festival:1.5-00c631d-5-php8-2",
    "ghcr.io/doggielicc/festival:1.5-php8-2",
    "ghcr.io/doggielicc/festival:1-php8-2",
    "ghcr.io/doggielicc/festival:latest-php8-2",

    "git.doggieli.cc/doggie/festival:1.5-00c631d-5-php8-2",
    "git.doggieli.cc/doggie/festival:1.5-php8-2",
    "git.doggieli.cc/doggie/festival:1-php8-2",
    "git.doggieli.cc/doggie/festival:latest",
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
    "ghcr.io/doggielicc/festival:1.5-00c631d-5-php8-1",
    "ghcr.io/doggielicc/festival:1.5-php8-1",
    "ghcr.io/doggielicc/festival:1-php8-1",

    "git.doggieli.cc/doggie/festival:1.5-00c631d-5-php8-1",
    "git.doggieli.cc/doggie/festival:1.5-php8-1",
    "git.doggieli.cc/doggie/festival:1-php8-1",
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
    "ghcr.io/doggielicc/festival:1.5-00c631d-5-php8-0",
    "ghcr.io/doggielicc/festival:1.5-php8-0",
    "ghcr.io/doggielicc/festival:1-php8-0",

    "git.doggieli.cc/doggie/festival:1.5-00c631d-5-php8-0",
    "git.doggieli.cc/doggie/festival:1.5-php8-0",
    "git.doggieli.cc/doggie/festival:1-php8-0",
  ]
}
