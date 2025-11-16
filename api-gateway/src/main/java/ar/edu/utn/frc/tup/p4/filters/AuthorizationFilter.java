package ar.edu.utn.frc.tup.p4.filters;

import ar.edu.utn.frc.tup.p4.services.AuthorizationService;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@Order(4)
@RequiredArgsConstructor
@Log4j2
public class AuthorizationFilter implements GlobalFilter, Ordered {

    private final AuthorizationService authorizationService;

    private final ObjectMapper objectMapper;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        log.info("CUARTO FILTRO.");
        String path = exchange.getRequest().getURI().getPath();
        String method = exchange.getRequest().getMethod().name();

        // Si es ruta pública, continuar sin validar
        if (authorizationService.isPublicEndpoint(path, method)) {
            log.info("🔓 Ruta pública detectada: {}", path);
            return chain.filter(exchange);
        }

        String token = exchange.getRequest().getHeaders().getFirst(HttpHeaders.AUTHORIZATION);
        if (token == null || token.isBlank()) {
            log.warn("❌ Token no proporcionado para ruta protegida: {}", path);
            return forbidden(exchange, "Token no proporcionado");
        }

        log.info("🔐 Validando token para: {}", path);

        String roles = extractPermissionsFromToken(exchange.getRequest().getHeaders());
        try {
            if (authorizationService.hasAccess(path, method, roles)) {
                return chain.filter(exchange);
            }
        } catch (EntityNotFoundException e) {
            return forbidden(exchange, "Endpoint no registado.");
        }

        return forbidden(exchange, "Usuario no autorizado.");
    }

    private Mono<Void> forbidden(ServerWebExchange exchange, String message) {
        log.warn("🚫 Acceso denegado: {}", message);
        exchange.getResponse().setStatusCode(HttpStatus.FORBIDDEN);
        exchange.getResponse().getHeaders().add("X-Error-Message", message);
        return exchange.getResponse().setComplete();
    }

    private String extractPermissionsFromToken(HttpHeaders headers) {
        String authHeader = headers.getFirst(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                String[] parts = token.split("\\.");
                String payload = new String(Base64.getUrlDecoder().decode(parts[1]));
                if (payload.contains("\"roles\"")) {
                    // Extraer y formatear permisos
                    return extractPermissionsArray(payload);
                }
            } catch (Exception ignored) {
                log.info("No se pudo extraer los roles.");
            }
        }
        return null;
    }

    @SuppressWarnings("unchecked")
    private String extractPermissionsArray(String payload) {
        Map<String, Object> payloadMap;
        try {
            payloadMap = this.objectMapper.readValue(payload, Map.class);
        } catch (JsonProcessingException e) {
            return null;
        }

        List<String> roles = (List<String>) payloadMap.getOrDefault("roles", List.of());

        return roles.stream()
                .map(String::toLowerCase)
                .collect(Collectors.joining(","));
    }

    @Override
    public int getOrder() {
        return 4;
    }
}