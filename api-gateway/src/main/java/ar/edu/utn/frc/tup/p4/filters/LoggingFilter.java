package ar.edu.utn.frc.tup.p4.filters;

import lombok.extern.log4j.Log4j2;
import org.springframework.cloud.gateway.filter.GlobalFilter;
import org.springframework.core.Ordered;
import org.springframework.core.annotation.Order;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ServerWebExchange;
import reactor.core.publisher.Mono;

@Component
@Order(1)
@Log4j2
public class LoggingFilter implements GlobalFilter, Ordered {

    @Override
    public Mono<Void> filter(ServerWebExchange exchange, org.springframework.cloud.gateway.filter.GatewayFilterChain chain) {
        log.info("PRIMER FILTRO.");
        log.info("➡️ Request: {} {}", exchange.getRequest().getMethod(), exchange.getRequest().getURI());
        return chain.filter(exchange)
                .then(Mono.fromRunnable(() ->
                        log.info("⬅️ Response: {}", exchange.getResponse().getStatusCode())));
    }

    @Override
    public int getOrder() {
        return 1;
    }
}
