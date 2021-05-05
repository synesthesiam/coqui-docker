FROM python:3.7-buster

RUN apt-get update && \
    apt-get install --yes --no-install-recommends \
        espeak-ng

ENV TORCH_VERSION=1.8.0

# Install CPU-only PyTorch to save space
RUN pip3 install --no-cache-dir \
      "torch==${TORCH_VERSION}+cpu" \
      -f https://download.pytorch.org/whl/torch_stable.html

ENV TTS_VERSION=0.0.13.2

# Remove torch from requirements.txt since we already installed it above.
RUN pip3 download --no-dependencies \
      "TTS==${TTS_VERSION}" && \
    tar -xf "TTS-${TTS_VERSION}.tar.gz" && \
    cd "TTS-${TTS_VERSION}/" && \
    sed -i '/^torch[>=~]/d' requirements.txt && \
    pip3 install --no-cache-dir ./ && \
    cd / && \
    rm -rf TTS-${TTS_VERSION}*

ENTRYPOINT ["tts"]