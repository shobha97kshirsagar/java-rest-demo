FROM openjdk:17-jdk-slim

COPY target/java-rest-api-0.0.1-SNAPSHOT.jar app.jar

EXPOSE 7000

ENTRYPOINT ["java", "-jar", "app.jar"]
