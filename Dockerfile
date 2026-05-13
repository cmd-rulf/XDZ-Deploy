FROM downloaderzone/mltb:latest

WORKDIR /usr/src/app
# Create a non-root user for better security
RUN useradd -m botuser && \
    chown -R botuser:botuser /usr/src/app && \
    chmod 777 /usr/src/app
RUN uv venv --system-site-packages

# Create symlinks for custom binary names used by BinConfig
RUN for pair in "qbittorrent-nox:stormtorrent" "aria2c:blitzfetcher" "ffmpeg:mediaforge" "rclone:ghostdrive"; do \
        src="${pair%%:*}"; dst="${pair##*:}"; \
        loc=$(command -v "$src" 2>/dev/null || find /usr/bin /usr/local/bin /bin -name "$src" -type f 2>/dev/null | head -1); \
        [ -n "$loc" ] && ln -sf "$loc" "/usr/local/bin/$dst" && echo "Linked $src -> $dst" || echo "WARN: $src not found, skipping $dst"; \
    done

COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt
COPY . .
# Set owner for the copied files
RUN chown -R botuser:botuser /usr/src/app
# Healthcheck to ensure the bot process is running
HEALTHCHECK --interval=60s --timeout=10s --start-period=30s --retries=3 \
    CMD pgrep -f "python3 -m bot" || exit 1
# Run as non-root user
USER botuser
CMD ["bash", "start.sh"]
