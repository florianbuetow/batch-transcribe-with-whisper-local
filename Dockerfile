# Use a minimal base image with Python 3.11
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /app

# Install system dependencies
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
    ffmpeg \
    git \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Copy the requirements.txt file into the container
COPY requirements.txt /app/requirements.txt

# Install Python dependencies
RUN pip install --no-cache-dir -r /app/requirements.txt

# Copy the transcribe script into the container
COPY transcribe_all.sh /app/transcribe_all.sh
RUN chmod +x /app/transcribe_all.sh

# Default command to run when the container starts
CMD ["/app/transcribe_all.sh"]
