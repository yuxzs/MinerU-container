# FROM python:3.11-slim
FROM nvidia/cuda:13.0.2-cudnn-runtime-ubuntu24.04

ENV PYTHONUNBUFFERED=1 \
    # VIRTUAL_ENV=/home/sduser/ComfyUI/venv \
    DEBIAN_FRONTEND=noninteractive

RUN apt-get update \
    && apt-get install -y \
    python3-full \
    pip \
    wget \
    git \
    ffmpeg libsm6 libxext6 \
    && rm -rf /var/lib/apt/lists/*

RUN pip install --upgrade pip
RUN pip install uv
RUN mkdir /app
WORKDIR /app
RUN uv venv
RUN source .venv/bin/activate
RUN uv pip install -U "mineru[all]"

CMD ["mineru-api", "--host", "0.0.0.0", "--port", "8000"]
