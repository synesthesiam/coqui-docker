SHELL := bash
DOCKER_REGISTRY ?= docker.io
PLATFORMS ?= linux/amd64,linux/arm64,linux/arm/v7
TTS_VERSION ?= 0.0.13.2

all:
	mkdir -p download
	docker buildx build . \
    --build-arg "TTS_VERSION=${TTS_VERSION}" \
    --platform "${PLATFORMS}" \
    --tag "${DOCKER_REGISTRY}/synesthesiam/coqui-tts" \
    --push
