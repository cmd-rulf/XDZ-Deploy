FROM tellyhubcloud/wzmlxdz:main

WORKDIR /usr/src/app

RUN chmod 777 /usr/src/app

# Install venv support
RUN apt-get update && apt-get install -y python3-venv

COPY requirements.txt .

# Create virtual environment
RUN python3 -m venv /opt/venv

# Activate venv
ENV PATH="/opt/venv/bin:$PATH"

# Upgrade pip
RUN pip install --upgrade pip

# Install requirements
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
