# ⚙️ Cómo agregar nuevos servicios al API Gateway

## 📘 Descripción

Este documento explica paso a paso cómo registrar **nuevos microservicios** dentro del **API Gateway** para que:
- las rutas se redirijan correctamente hacia sus destinos,
- se apliquen las políticas de autenticación y autorización definidas (según la tabla `endpoint_permissions`),
- y opcionalmente se configuren filtros específicos por servicio.

---

## 🧭 1. Comprender el flujo del Gateway

El **API Gateway** actúa como **punto de entrada único** a todos los servicios internos.
Mas informacion en [MANUAL-API_GATEWAY](./README.md)

--- 

## 🧩 2. Entender cuales son nuestras variables

Nosotros para manejar la agregacion de nuevos servicios vamos a definir una variable:
- Nombre Servicio: Lo vamos a obtener a partir del nombre del repositorio sacando el `tpi-`. Por ejemplo: tpi-nbu sera nbu.

--- 

## 🧩 3. Definir la ruta del nuevo servicio

> IMPORTANTE: Esto de hace en el repositorio del [api gateway](https://github.com/2025-P4-BE/tpi-api-gateway).

Todas las rutas del Gateway se configuran en `application.properties` bajo la clave:
- spring.cloud.gateway.server.webflux.routes[0].id -> Siendo el ID con el que vamos a registrar nuestro servicio cuando se levante. (NBU_SERVICE) -> `{VARIABLE_PUNTO_2}_SERVICE`
- spring.cloud.gateway.server.webflux.routes[0].uri -> Siendo la URI directa a ese servicio. (lb://NBU-SERVICE) -> `{VARIABLE_PUNTO_2}-SERVICE`
- spring.cloud.gateway.server.webflux.routes[0].predicates[0] -> Siendo como el filtro para saber a que ms tenemos que ir a pegarle. (Path=/nbu/**) -> `/{VARIABLE_PUNTO_2}/**`
- spring.cloud.gateway.server.webflux.routes[0].filters[0] -> Como reescribiremos la URL despues del filtrado. (StripPrefix=1)

Entonces si viene la URI `http://localhost:8080/nbu/example/getAll`.
1. Vamos a aplicar el predicado y encontramos que el servicio al cual pertenece el predicado es el que tiene ID = `NBU_SERVICE`.
2. Vamos a reescribir la request sacando la primera parte del prefijo, quedando `example/getAll`.
3. Le vamos a pegar directamente a donde se ubique NBU-SERVICE. `http://localhost:8001/example/getAll`.

---

## 🔐 4. Permisos del servicio en la base de datos

El Gateway valida los permisos de acceso mediante la tabla endpoint_permissions.

--- 

## 🧰 5. Preparar nuestro servicio para registrarnos en Eureka
Para registrar nuestro servicio en Eureka y asi el API_GATEWAY los reconozca automaticamente lo que tenemos que hacer es:

### 5.1. Agregar la dependencia del cliente de eureka en nuestro `pom.xml`
En la parte de `<properties>` agregamos la siguiente variable:
```xml
<spring-cloud.version>2025.0.0</spring-cloud.version>
```

En la parte de `<dependencies>` agregamos la siguiente dependencia:
```xml
<!-- Eureka Client -->
<dependency>
    <groupId>org.springframework.cloud</groupId>
    <artifactId>spring-cloud-starter-netflix-eureka-client</artifactId>
</dependency>
```

Debajo de las `</dependencies>` agregamos al MISMO NIVEL DE IDENTACION la siguiente estructura:
```xml
<dependencyManagement>
    <dependencies>
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

### Ante cualquier duda van a encontrar replicada esta estructura en el [pom.xml](./pom.xml) de este proyecto.

### 5.2 Agregar las properties necesarias para el registro apropiedo de nuestro servicio.
```properties
# Siempre partido de la variable del punto 2.

# Esta variable indica como nos registraremos en el servicio de Eureka. En nuestro estandar seria:
# {VARIABLE_PUNTO_2}-SERVICE
spring.application.name=NBU-SERVICE

# Siempre sera donde se encuentra localizado nuestro descubridor de servicios.
eureka.client.service-url.defaultZone=http://localhost:8761/eureka/

# Le indica que debe registrarse en el servicio de Eureka.
eureka.client.register-with-eureka=true

# Cada ms individual no tiene la necesidad de traerse los cambios de Eureka.
eureka.client.fetch-registry=false
```

### 5.3 Agregar la notacion del Cliente de Eureka

En la clase Application vamos a tener que agregar la siguiente anotacion para habilitar el cliente de Eureka.
```java
@SpringBootApplication
@EnableDiscoveryClient  //  <-------------- NOTACION A AGREGAR.
public class Application {

    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
```

