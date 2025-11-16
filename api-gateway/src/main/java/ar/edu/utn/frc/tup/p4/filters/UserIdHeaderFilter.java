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
import java.util.Map;

@Component
@Order(2)
@RequiredArgsConstructor
@Log4j2
public class UserIdHeaderFilter implements GlobalFilter, Ordered {

    private final ObjectMapper objectMapper;

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, GatewayFilterChain chain) {
        log.info("SEGUNDO FILTRO.");
        String userId = extractUserIdFromToken(exchange.getRequest().getHeaders());
        if (userId != null) {
            log.info("x-user-id: {}", userId);
            exchange = exchange.mutate()
                    .request(r -> r.headers(h -> h.set("x-user-id", userId)))
                    .build();
        } else {
            log.info("No se pudo extraer el x-user-id.");
            exchange = exchange.mutate()
                    .request(r -> r.headers(h -> h.remove("x-user-id")))
                    .build();
        }
        return chain.filter(exchange);
    }

    private String extractUserIdFromToken(HttpHeaders headers) {
        String authHeader = headers.getFirst(HttpHeaders.AUTHORIZATION);
        if (authHeader != null && authHeader.startsWith("Bearer ")) {
            String token = authHeader.substring(7);
            try {
                String[] parts = token.split("\\.");
                String payload = new String(Base64.getUrlDecoder().decode(parts[1]));
                if (payload.contains("\"id\"")) {
                    Map<String, Object> payloadMap = this.objectMapper.readValue(payload, Map.class);
                    return payloadMap.get("id").toString();
                }
            } catch (Exception e) {
                log.warn("No se pudo extraer el x-user-id.");
            }
        }
        return null;
    }

    @Override
    public int getOrder() {
        return 2;
    }
}



