# Use an official PHP runtime as a parent image
FROM php:7.4-cli

# Set the working directory in the container
WORKDIR /usr/src/myapp

# Copy the current directory contents into the container at /usr/src/myapp
COPY . .

# When the container launches, run the PHP CLI server
CMD [ "php", "-S", "0.0.0.0:8000" ]

