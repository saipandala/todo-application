FROM maven:3.9.9-eclipse-temurin-17 AS builder
WORKDIR /app
COPY . /app
RUN mvn clean package -DskipTests

FROM openjdk:17-slim
WORKDIR /app
COPY --from=builder /app/target/*.jar app.jar
EXPOSE 8081
ENTRYPOINT ["java","-jar","app.jar"]
