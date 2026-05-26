FROM tellyhubcloud/wzmlxdz:main

WORKDIR /usr/src/app

RUN chmod 777 /usr/src/app

COPY requirements.txt .

RUN python3 -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

CMD ["bash", "start.sh"]
