# Use an official PHP runtime as a parent image
FROM php:7.4-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the current directory contents into the container at /var/www/html
COPY . /var/www/html

# Expose port 80 to the host machine
EXPOSE 80

# Run Apache in the foreground
CMD ["apache2-foreground"]

