FROM python:3.11-slim

# Install system dependencies required for OpenCV, Poppler (PDF), and Tesseract (OCR)
RUN apt-get update && apt-get install -y \
    libgl1-mesa-glx \
    libglib2.0-0 \
    poppler-utils \
    tesseract-ocr \
    tesseract-ocr-spa \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Copy requirements first to leverage Docker cache
COPY requirements.txt .

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the application code
COPY . .

# Expose the port Flet will run on
EXPOSE 8000

# Command to run the application
# We use --web to run in web mode, listening on all interfaces
CMD ["flet", "run", "main.py", "--web", "--port", "8000", "--host", "0.0.0.0"]
