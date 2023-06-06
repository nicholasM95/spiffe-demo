FROM openjdk:17-alpine

WORKDIR app

COPY target/aws.jar app.jar

CMD ["java", "-Duser.timezone=Europe/Brussels", "-jar", "app.jar"]

