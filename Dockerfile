# Use an official Python runtime as a parent image
FROM python:3.11.5-windowsservercore

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy requirements.txt separately to leverage caching
COPY requirements.txt .

# Install packages individually (adjust as needed)
RUN pip install \
    anyio==4.4.0 \
    backoff==2.2.1 \
    certifi==2024.6.2 \
    charset-normalizer==3.3.2 \
    et-xmlfile==1.1.0 \
    h11==0.14.0 \
    httpcore==1.0.5 \
    httpx==0.27.0 \
    idna==3.7 \
    numpy==1.26.4 \
    opencage==2.4.0 \
    openpyxl==3.1.4 \
    pandas==2.2.2 \
    pillow==10.3.0 \
    python-dateutil==2.9.0.post0 \
    pytz==2024.1 \
    requests==2.32.3 \
    six==1.16.0 \
    sniffio==1.3.1 \
    tzdata==2024.1 \
    urllib3==2.2.1 \
    excel2img==1.4.0 \
    python-telegram-bot==21.3 


# Install Office 365
WORKDIR /install

# Copy the Office 365 setup executable (setup.exe) 
COPY setup.exe .


# Install Office 365 silently using setup.exe
RUN setup.exe 

# Clean up
RUN del setup.exe


# Switch back to the working directory for your application
WORKDIR /usr/src/app

# Copy the rest of your application code
COPY . .

# Make port 80 available to the world outside this container (adjust if necessary)
EXPOSE 80

# Run your application (assuming bot.py is your main script)
CMD ["python", "bot.py"]
