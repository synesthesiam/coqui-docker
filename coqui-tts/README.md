# Coqui TTS Docker

Docker images and scripts for [Coqui TTS](https://github.com/coqui-ai/TTS)

```sh
$ curl https://raw.githubusercontent.com/synesthesiam/coqui-docker/master/coqui-docker/coqui-tts/tts-server \
    > ~/bin/tts-server && chmod +755 ~/bin/tts-server
$ tts-server
```

Access TTS server at http://localhost:5002

## Scripts Available

* `tts-server`
    * Similar to Coqui TTS `tts-server` command
    * Server at https://localhost:5002, Runs as current user, has access to `$HOME` directory
    * Use `--gpu` to use GPU image (requires [nvidia-docker](https://github.com/NVIDIA/nvidia-docker), `amd64` only)
    * Use `--update` to update Docker image
* `tts`
    * Similar to Coqui TTS `tts` command
    * Runs as current user, has access to `$HOME` directory
    * Use `--gpu` to use GPU image (requires [nvidia-docker](https://github.com/NVIDIA/nvidia-docker), `amd64` only)
    * Use `--update` to update Docker image

## Images Available

For CPU-only:

```sh
$ docker pull synesthesiam/coqui-tts
```

For GPU (`amd64` only):

```sh
$ docker pull synesthesiam/coqui-tts:gpu
```

Docker images also tagged with `<VERSION>` or `gpu-<VERSION>` for the version of Coqui TTS.

## Platforms Supported

* `amd64` - laptops/desktops/servers
    * GPU-ready images have `gpu` tag instead of `latest`
    * Run `tts-server --gpu`
* `armv7l` - Raspberry Pi 3/4 32-bit
* `arm64` - Raspberry Pi 3/4 64-bit
