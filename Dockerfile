FROM tellyhubcloud/wzmlxdz:main
WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app
RUN uv venv --system-site-packages
COPY requirements.txt .
RUN uv pip install --no-cache-dir -r requirements.txt
COPY . .
#ENV PATH="/usr/src/app/.venv/bin:$PATH"
CMD ["bash", "start.sh"]
