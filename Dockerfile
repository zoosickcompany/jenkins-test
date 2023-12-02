# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-ea-11-jdk-slim

# Set the working directory to /app
WORKDIR /app

# Copy the JAR file into the container at /app
COPY build/libs/demo-0.0.1-SNAPSHOT.jar app.jar

# Make port 40000 available to the world outside this container
EXPOSE 9300

# Define environment variable
ENV SPRING_PROFILES_ACTIVE=dev

# Run the JAR file when the container launches
CMD ["java", "-jar", "app.jar"]
