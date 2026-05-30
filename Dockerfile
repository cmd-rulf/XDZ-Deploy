FROM tellyhubcloud/tellyhubcloud:dev

# Environment variables
ENV DEBIAN_FRONTEND=noninteractive \
    PYTHONUNBUFFERED=1 \
    PIP_BREAK_SYSTEM_PACKAGES=1

WORKDIR /usr/src/app

# Copy UV binaries
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/

# Install Python dependencies
COPY requirements.txt .
RUN uv pip install --system --no-cache -r requirements.txt

# Copy application code
COPY . .

# Set permissions
RUN chmod -R 777 /usr/src/app

# Run application
CMD ["bash", "start.sh"]
