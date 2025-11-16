package ar.edu.utn.frc.tup.p4.configs;

import org.springframework.cloud.client.loadbalancer.reactive.ReactorLoadBalancerExchangeFilterFunction;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.reactive.function.client.WebClient;

@Configuration
public class WebClientConfig {
    @Bean
    public WebClient webClient(WebClient.Builder builder, ReactorLoadBalancerExchangeFilterFunction lbFunction) {
        return builder
                .filter(lbFunction)
                .build();
    }
}
