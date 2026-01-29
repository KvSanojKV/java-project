FROM openjdk:17-jdk-slim
COPY target/java-app.jar java-app.jar
ENTRYPOINT ["java","-jar","java-app.jar"]

