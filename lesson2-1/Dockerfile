# Use the official GCC image as a parent
FROM gcc:latest

# Set the working directory in the container
WORKDIR /usr/src/app

# Copy the current directory contents into the container at /usr/src/app
COPY . .

# Compile the C program
RUN gcc -o hello hello.c

# Run the program from the previous step when the container launches
CMD ["./hello"]
