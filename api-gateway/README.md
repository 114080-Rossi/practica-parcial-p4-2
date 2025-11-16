# MANUAL API GATEWAY

## 📘 Descripción General

Este módulo implementa un **API Gateway reactivo** basado en **Spring Cloud Gateway + WebFlux**, que centraliza la **autenticación y autorización de peticiones** provenientes del frontend o de otros microservicios.  
El objetivo principal es garantizar que **solo los roles autorizados** puedan acceder a los endpoints expuestos por los distintos servicios del sistema, utilizando una **tabla dinámica de permisos** almacenada en base de datos.

---

## 🧱 Arquitectura de Componentes

| Componente                         | Responsabilidad principal                                                                                                                                              |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| **`AuthorizationFilter`**          | Filtro global que intercepta todas las solicitudes HTTP entrantes al Gateway. Valida tokens, determina si la ruta es pública y verifica si el usuario tiene permisos.  |
| **`AuthorizationService`**         | Lógica de negocio que consulta la base de datos para validar permisos por endpoint y método HTTP.                                                                      |
| **`EndpointPermissionRepository`** | Repositorio JPA que accede a la tabla `endpoint_permissions`. Permite búsquedas exactas y por patrones (`/api/users/{id}`).                                            |
| **`EndpointPermission`**           | Entidad JPA que representa los permisos de acceso por endpoint: método HTTP, roles permitidos, si es público y descripción.                                            |

---

## ⚙️ Flujo de Ejecución

### 1. Intercepción de la petición
Cada solicitud HTTP pasa primero por el filtro global `AuthorizationFilter`.  
Se obtienen:
- `path` → la URI del endpoint solicitado
- `method` → el método HTTP (`GET`, `POST`, etc.)

```java
String path = exchange.getRequest().getURI().getPath();
String method = exchange.getRequest().getMethod().name();
```

### 2. Verificación de rutas públicas
Algunas rutas (como login o health checks) son públicas y no requieren validación de token.
El filtro consulta el servicio:
```java
if (authorizationService.isPublicEndpoint(path, method)) {
    return chain.filter(exchange);
}
```

Si la ruta está marcada como pública en la base, el request continúa sin autenticación.

### 3. Validación de token JWT
Si la ruta no es pública:
Se extrae el header Authorization.
Se envía al microservicio User API (configurado en application.yml como services.user-api.url) para validar el token.
```java
return webClient.get()
    .uri(userApiUrl + "/v1/auth/validate")
    .header(HttpHeaders.AUTHORIZATION, token)
    .retrieve()
    .bodyToMono(String.class)
```
Si el token es inválido o expiró, se responde con 403 Forbidden.

### 4. Verificación de permisos por endpoint
Si el token es válido, se extraen los roles del usuario desde el JWT:
```java 
String roles = extractPermissionsFromToken(exchange.getRequest().getHeaders());
```

### 5. Autorización dinámica por endpoint
AuthorizationService consulta la base de datos (EndpointPermissionRepository) buscando un registro que coincida con el path y method.
Búsqueda exacta:
```java
findByEndpointPathAndHttpMethod(endpoint, method)
```

Búsqueda por patrón:
Si el path incluye variables (/api/users/123), se busca el patrón /api/users/{id}:
```java
findByPathPatternAndMethod(endpoint, method)
```

Si se encuentra el registro, compara los roles del usuario con los permitidos:

```java
endpointPermission.hasAnyRole(userRolesList)
```

Si coincide al menos uno, el acceso es permitido.
Si no, se devuelve 403 - Usuario no autorizado.

Luego se delega a AuthorizationService.hasAccess() para validar si el usuario tiene permisos sobre el endpoint.

---

## 🧩 Entidad EndpointPermission

La tabla endpoint_permissions define las reglas de acceso:
Campo	Descripción
Método HTTP permitido.
Roles permitidos separados por coma ("admin,secretaria").
Indica si el endpoint es público.
Breve descripción funcional.
Fecha de creación del registro.

| Campo               | Descripción                                               |
|---------------------|-----------------------------------------------------------|
| **`endpoint_path`** | Path del endpoint (puede incluir {id}).                   |
| **`http_method`**   | Método HTTP permitido.                                    |
| **`allowed_roles`** | Roles permitidos separados por coma ("admin,secretaria"). |
| **`is_public`**     | Indica si el endpoint es público.                         |
| **`description`**   | Breve descripción funcional.                              |
| **`created_at`**    | Fecha de creación del registro.                           |

---

# 🧠 Pseudocódigo general
1. Recibir request (path, method)
2. Si el endpoint es público -> permitir acceso
3. Extraer token JWT
4. Validar token contra User API
5. Si token inválido -> 403
6. Extraer roles del token
7. Buscar endpoint en BD
8. Si no existe -> 403 "Endpoint no registrado"
9. Si roles coinciden -> permitir
10. Si no coinciden -> 403 "No autorizado"

--- 

## 🔐 Detección de requests internos (backend)

En entornos donde el Gateway también recibe llamadas de otros microservicios internos, se puede detectar el origen para aplicar reglas distintas.
Ejemplo:
```java
String origin = exchange.getRequest().getHeaders().getFirst(HttpHeaders.ORIGIN);
boolean fromBackend = origin != null && origin.contains(servicesBackendProperty);
```

Si fromBackend es verdadero, se puede omitir la validación de token o aplicar lógica distinta.
