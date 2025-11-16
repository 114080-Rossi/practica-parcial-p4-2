package ar.edu.utn.frc.tup.p4.filters;

import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.cloud.gateway.filter.GatewayFilterChain;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.http.HttpHeaders;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

import java.util.Base64;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@Component
@Order(3)
@RequiredArgsConstructor
@Log4j2
public class UserRolesHeaderFilter implements GlobalFilter, Ordered {

    private final ObjectMapper objectMapper;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        log.info("TERCER FILTRO.");
        String roles = extractRolesFromToken(exchange.getRequest().getHeaders());
        if (roles != null) {
            exchange = exchange.mutate()
                    .request(r -> r.headers(h -> h.add("x-user-roles", roles)))
                    .build();
        }
        return chain.filter(exchange);
    }

    @SuppressWarnings("unchecked")
    private String extractRolesFromToken(HttpHeaders headers) {
        String authHeader = headers.getFirst(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                String[] parts = token.split("\\.");
                String payload = new String(Base64.getUrlDecoder().decode(parts[1]));
                if (payload.contains("\"roles\"")) {
                    Map<String, Object> payloadMap = this.objectMapper.readValue(payload, Map.class);
                    List<String> roles = (List<String>) payloadMap.getOrDefault("roles", List.of());
                    return roles.stream()
                            .map(String::toLowerCase)
                            .collect(Collectors.joining(","));
                }
            } catch (Exception e) {
                log.warn("No se pudo extraer el x-user-roles.");
            }
        }
        return null;
    }

    @Override
    public int getOrder() {
        return 3;
    }
}