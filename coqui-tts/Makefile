.PHONY: gpu

SHELL := bash
DOCKER_REGISTRY ?= docker.io
PLATFORMS ?= linux/amd64,linux/arm64,linux/arm/v7
TTS_VERSION ?= 0.1.0

cpu:
	mkdir -p download/amd64 download/arm64 download/armv7
	docker buildx build . \
    --build-arg "TTS_VERSION=${TTS_VERSION}" \
    --platform "${PLATFORMS}" \
    --tag "${DOCKER_REGISTRY}/synesthesiam/coqui-tts" \
    --tag "${DOCKER_REGISTRY}/synesthesiam/coqui-tts:${TTS_VERSION}" \
    --push

gpu:
	mkdir -p download/amd64
	docker buildx build . -f Dockerfile.gpu \
    --build-arg "TTS_VERSION=${TTS_VERSION}" \
    --tag "${DOCKER_REGISTRY}/synesthesiam/coqui-tts:gpu" \
    --tag "${DOCKER_REGISTRY}/synesthesiam/coqui-tts:gpu-${TTS_VERSION}" \
    --push
