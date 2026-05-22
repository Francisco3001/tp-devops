# Etapa 1: build
FROM maven:3.9.9-eclipse-temurin-21 AS builder
WORKDIR /app

# Se copia solo lo necesario
COPY pom.xml .
RUN mvn -q -e -DskipTests dependency:go-offline

# Se copia el código cambio para prueba
COPY src ./src

# Se compila
RUN mvn clean package -DskipTests

# Etapa 2: runtime
FROM eclipse-temurin:21-jdk-jammy
WORKDIR /app

# New Relic Java agent
ADD https://download.newrelic.com/newrelic/java-agent/newrelic-agent/current/newrelic-agent.jar /app/newrelic/newrelic.jar

# Copiamos el jar generado
COPY --from=builder /app/target/*.jar app.jar

EXPOSE 8080
ENTRYPOINT ["java","-javaagent:/app/newrelic/newrelic.jar","-jar","app.jar"]