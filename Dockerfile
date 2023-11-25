# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-ea-11-jdk-slim

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . /app
#yy
# Make port 4000 available to the world outside this container
EXPOSE 40000

# Define environment variable
ENV SPRING_PROFILES_ACTIVE=dev

# Run jar file when the container launches
CMD ["java", "-jar", "demo-0.0.1-SNAPSHOT.jar"]
