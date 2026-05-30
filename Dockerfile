FROM tellyhubcloud/tellyhubcloud:dev

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
COPY --from=ghcr.io/astral-sh/uv:latest /uv /uvx /usr/local/bin/
COPY requirements.txt .
RUN uv pip install --system --no-cache-dir -r requirements.txt
# Copy application code
COPY . .
RUN chmod +x start.sh
# Run the application
CMD ["bash", "start.sh"]
