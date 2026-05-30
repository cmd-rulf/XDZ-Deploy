FROM tellyhubcloud/tellyhubcloud:dev

WORKDIR /usr/src/app
RUN chmod 777 /usr/src/app

# Install requirements using pip with break-system-packages
COPY requirements.txt .
RUN pip3 install --break-system-packages --no-cache-dir -r requirements.txt

# Copy application files
COPY . .

# Set executable permissions for start script
RUN chmod +x start.sh

# Start the application
CMD ["bash", "start.sh"]
