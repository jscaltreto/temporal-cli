variable TEMPORAL_CLI_VERSION {
  default = "1.0.0"
}

target "docker-metadata-action" {}

target "meta" {
  args = {
    TEMPORAL_CLI_VERSION = TEMPORAL_CLI_VERSION
  }
  dockerfile = "Dockerfile"
  tags = ["temporal-cli:${TEMPORAL_CLI_VERSION}"]
}

target "default" {
  inherits = ["meta", "docker-metadata-action"]
}
