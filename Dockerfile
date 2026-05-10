# Base image from Microsoft Container Registry to avoid Docker Hub pulls
FROM mcr.microsoft.com/devcontainers/base:ubuntu-22.04

# Set non-interactive mode to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Install system dependencies
RUN apt-get update && apt-get install -y \
    wget \
    curl \
    git \
    build-essential \
    && rm -rf /var/lib/apt/lists/*

# Download and install Miniconda for the current CPU architecture
RUN wget -q https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-aarch64.sh -O miniconda.sh && \
    bash miniconda.sh -b -p /opt/miniconda && \
    rm miniconda.sh

# Add conda to PATH
ENV PATH="/opt/miniconda/bin:$PATH"

# Create a Python environment using conda-forge to avoid default-channel ToS prompts
RUN conda create -y -n research -c conda-forge --override-channels python=3.11 pandas numpy scipy scikit-learn pyarrow && \
    conda clean -afy

# Make the research environment the default runtime environment
ENV PATH="/opt/miniconda/envs/research/bin:/opt/miniconda/bin:$PATH"

# Set working directory
WORKDIR /workspace

# Default command
CMD ["/bin/bash"]
