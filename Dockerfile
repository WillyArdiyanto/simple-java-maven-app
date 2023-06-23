# Use an official Maven image as the base image
FROM maven:3.8.4-openjdk-11 AS build

# Set the working directory in the container
WORKDIR /app

# Copy the project's pom.xml and download the dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the project source code
COPY src ./src

# Build the application
RUN mvn package

# Use a smaller base image for the runtime environment
FROM openjdk:11-jre-slim

# Set the working directory in the container
WORKDIR /app

# Copy the built JAR file from the previous stage
COPY --from=build /app/target/*.jar app.jar

# Expose the port on which the application will run (if needed)
EXPOSE 8080

# Specify the command to run the application
CMD ["java", "-jar", "app.jar"]
