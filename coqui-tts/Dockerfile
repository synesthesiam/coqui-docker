FROM python:3.7-buster
ARG TARGETARCH
ARG TARGETVARIANT

ENV LLVM_VERSION=9

RUN --mount=type=cache,id=apt-run,target=/var/apt/cache \
    apt-get update && \
    apt-get install --yes --no-install-recommends \
        espeak-ng wget \
        libatlas3-base libgfortran5 libopenblas-base

# Need llvm dev package for arm64 and armv7l
RUN --mount=type=cache,id=apt-run,target=/var/apt/cache \
    if [ ! "${TARGETARCH}${TARGETVARIANT}" = 'amd64' ]; then \
      wget -O - 'http://archive.raspberrypi.org/debian/raspberrypi.gpg.key' | apt-key add - && \
      echo "deb http://archive.raspberrypi.org/debian/ buster main" >> /etc/apt/sources.list && \
      apt-get update && \
      apt-get install --yes --no-install-recommends \
        llvm-${LLVM_VERSION}-dev; \
    fi

# Create virtual environment so we can use a working pip
RUN --mount=type=cache,id=python-run,target=/var/apt/cache \
    python3 -m venv /app && \
    /app/bin/pip3 install --upgrade 'pip<=20.2.4' && \
    /app/bin/pip3 install --upgrade wheel setuptools

COPY download/${TARGETARCH}${TARGETVARIANT}/ /download/

ENV LLVM_CONFIG=/usr/bin/llvm-config-${LLVM_VERSION}

ENV TORCH_VERSION=1.8.0

# Install CPU-only PyTorch to save space.
# Pre-compiled ARM wheels require newer numpy.
RUN --mount=type=cache,id=python-run,target=/var/apt/cache \
    /app/bin/pip3 install \
      "torch==${TORCH_VERSION}+cpu" \
      'numpy==1.20.2' \
      'scipy==1.6.3' \
      -f https://download.pytorch.org/whl/torch_stable.html \
      -f https://synesthesiam.github.io/prebuilt-apps/index.html \
      -f /download

ARG TTS_VERSION=0.0.13.2

# Remove torch, numpy, and scipy from requirements.txt since we already installed them above.
RUN wget -O "TTS-${TTS_VERSION}.tar.gz" 'https://files.pythonhosted.org/packages/0a/5b/2acffd3483126a942e781c79993b2f812de73973b79d52d7b56402e14b89/TTS-0.0.13.2.tar.gz' && \
    tar -xf "TTS-${TTS_VERSION}.tar.gz" && \
    cd "TTS-${TTS_VERSION}/" && \
    sed -i '/^\(torch\|numpy\|scipy\)[>=~]/d' requirements.txt

RUN --mount=type=cache,id=python-run,target=/var/apt/cache \
    /app/bin/pip3 install -r "/TTS-${TTS_VERSION}/requirements.txt" -f /download

RUN --mount=type=cache,id=python-run,target=/var/apt/cache \
    /app/bin/pip3 install "/TTS-${TTS_VERSION}" -f /download

# Stop eSpeak from reaching out to pulseaudio, even if told to be silent
ENV PULSE_SERVER=''

ENV PATH=/app/bin:${PATH}

ENTRYPOINT ["tts"]