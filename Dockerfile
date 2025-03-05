FROM python:3.10-slim

# Set environment variables
ENV APP_HOME /app
ENV PORT 8080  # Set default port, 8080 is used by Cloud Run and is also common locally

# Set the working directory in the container
WORKDIR $APP_HOME

# Copy the current directory contents into the container at /app
COPY . ./

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port that Flask will run on (default for Cloud Run and many environments)
EXPOSE 8080

# Run the application using Gunicorn, bound to the port defined in the environment
CMD exec gunicorn --bind :$PORT --workers 1 --threads 8 --timeout 0 main:app
