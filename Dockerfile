# Etapa 1: Construcción
FROM maven:3.8.6-openjdk-11 AS build
WORKDIR /app
# Copiar archivos necesarios para la construcción
COPY pom.xml .
COPY src ./src
# Construir el proyecto y empaquetar el JAR
RUN mvn clean package -DskipTests
# Etapa 2: Ejecución
FROM openjdk:11-jre-slim
WORKDIR /app
# Copiar el JAR generado desde la etapa de construcción
COPY --from=build /app/target/*.jar ./app.jar
# Comando para ejecutar la aplicación
ENTRYPOINT ["java", "-jar", "app.jar"]
