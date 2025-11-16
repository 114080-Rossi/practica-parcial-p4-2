# ===== Etapa 1: Build (rápido y cacheable) =====
FROM maven:3.9.9-eclipse-temurin-17 AS build
WORKDIR /app

# Copiar solo el pom para cachear dependencias
COPY pom.xml .
RUN mvn -B -DskipTests dependency:go-offline

# Copiar el código fuente y compilar
COPY src ./src
RUN mvn clean package -DskipTests

# ===== Etapa 2: Runtime =====
FROM eclipse-temurin:17-jre-alpine
WORKDIR /app

# Instalar curl para healthchecks
RUN apk add --no-cache curl

RUN addgroup -S appgroup && adduser -S appuser -G appgroup
USER appuser

COPY --from=build /app/target/*.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
