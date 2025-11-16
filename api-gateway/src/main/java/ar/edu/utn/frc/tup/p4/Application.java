package ar.edu.utn.frc.tup.p4;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;

/**
 * Main class.
 */
@SpringBootApplication
@EnableDiscoveryClient
@EnableCaching 
public class Application {

    /**
     * Main program.
     * @param args application args
     */
    public static void main(String[] args) {
        SpringApplication.run(Application.class, args);
    }
}
