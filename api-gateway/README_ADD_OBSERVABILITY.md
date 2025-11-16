# ⚙️ Cómo agregar observabilidad a los servicios

## 📘 Descripción

Este documento explica paso a paso cómo agregar observabilidad a **nuestros microservicios**.

---

## 1. Agregar las siguientes propiedades en el `application.properties`.

```properties
# En caso que ya tengan esta propiedad seteanla en INFO.
logging.level.root=INFO
management.endpoints.web.exposure.include=health,info,eureka,prometheus
management.metrics.tags.application=${spring.application.name}
management.prometheus.metrics.export.enabled=true
otel.exporter.otlp.endpoint=${TEMPO_URL:http://localhost:4317}
otel.exporter.otlp.protocol=grpc
otel.resource.attributes.service.name=${spring.application.name}
otel.traces.exporter=otlp
otel.metrics.exporter=none
otel.logs.exporter=none
```

--- 

## 2. Agregar las mismas propiedades en el `application.properties` de TEST con el siguiente contenido.
```properties
# En caso que ya tengan esta propiedad seteanla en INFO.
logging.level.root=INFO
management.endpoints.web.exposure.include=health,info,eureka,prometheus
management.metrics.tags.application=${spring.application.name}
management.prometheus.metrics.export.enabled=true
otel.exporter.otlp.endpoint=${TEMPO_URL:http://localhost:4317}
otel.exporter.otlp.protocol=grpc
otel.resource.attributes.service.name=${spring.application.name}
otel.traces.exporter=otlp
otel.metrics.exporter=none
otel.logs.exporter=none
```
---

## 3. Agregar las siguientes dependencias en el bloque de `<dependencies>` del `pom.xml`.

```xml
<dependency>
    <groupId>io.micrometer</groupId>
    <artifactId>micrometer-registry-prometheus</artifactId>
</dependency>
<dependency>
    <groupId>com.github.loki4j</groupId>
    <artifactId>loki-logback-appender</artifactId>
    <version>1.5.0</version>
</dependency>
<!-- Starter para instrumentar Spring Boot 3.x -->
<dependency>
    <groupId>io.opentelemetry.instrumentation</groupId>
    <artifactId>opentelemetry-spring-boot-starter</artifactId>
</dependency>

<!-- Exportador OTLP (para Tempo, por ejemplo) -->
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-exporter-otlp</artifactId>
</dependency>

<!-- Para métricas con OTEL -->
<dependency>
    <groupId>io.opentelemetry</groupId>
    <artifactId>opentelemetry-sdk-extension-autoconfigure</artifactId>
</dependency>
```

---

## 4. Sustutuir el bloque actual de `<dependencyManagement>` del `pom.xml` por el siguiente:
```xml
<dependencyManagement>
    <dependencies>
        <dependency>
            <groupId>io.opentelemetry.instrumentation</groupId>
            <artifactId>opentelemetry-instrumentation-bom</artifactId>
            <version>2.10.0</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
        <dependency>
            <groupId>org.springframework.cloud</groupId>
            <artifactId>spring-cloud-dependencies</artifactId>
            <version>${spring-cloud.version}</version>
            <type>pom</type>
            <scope>import</scope>
        </dependency>
    </dependencies>
</dependencyManagement>
```

--- 

## 5. En la carpeta `resources` agregar un archivo. Nombrarlo exactamente: `logback-spring.xml`.

---

## 6. Dentro del archivo `logback-spring.xml` copiar y pegar:
```xml
<configuration>
    <springProperty name="APP_NAME" source="spring.application.name"/>
    <appender name="LOKI" class="com.github.loki4j.logback.Loki4jAppender">
        <http>
            <url>http://loki:3100/loki/api/v1/push</url>
        </http>

        <format>
            <label>
                <pattern>app=${APP_NAME},host=${HOSTNAME},level=%level</pattern>
                <readMarkers>true</readMarkers>
            </label>
            <message>
                <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} %-5level [requestId: %X{X-Request-ID}] [%thread] %logger{36} - %msg%n</pattern>
            </message>
        </format>
    </appender>

    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{yyyy-MM-dd HH:mm:ss.SSS} %-5level [%thread] %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <root level="INFO">
        <appender-ref ref="LOKI" />
        <appender-ref ref="CONSOLE" />
    </root>

</configuration>
```

## 7. Ahora ponemos el archivo `logback-spring.xml` en resources pero dentro de TEST con el siguiente contenido.
```xml
<?xml version="1.0" encoding="UTF-8"?>
<configuration>
    <appender name="CONSOLE" class="ch.qos.logback.core.ConsoleAppender">
        <encoder>
            <pattern>%d{HH:mm:ss.SSS} [%thread] %-5level %logger{36} - %msg%n</pattern>
        </encoder>
    </appender>

    <root level="INFO">
        <appender-ref ref="CONSOLE" />
    </root>
</configuration>
```
