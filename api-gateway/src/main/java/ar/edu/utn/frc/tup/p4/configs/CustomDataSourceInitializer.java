package ar.edu.utn.frc.tup.p4.configs;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.io.Resource;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;

import javax.sql.DataSource;

/**
 * Configuration class to initialize the database conditionally based on data presence.
 */
@Configuration
public class CustomDataSourceInitializer {

    private static final Logger log = LoggerFactory.getLogger(CustomDataSourceInitializer.class);

    /**
     * Path to data-mysql.sql.
     */
    @Value("classpath:migrations/*.sql")
    private Resource[] migrationScripts;

    @Value("${app.version:SNAPSHOT}")
    private String version;

    @Value("${app.gateway.delete.data}")
    private boolean deleteData;

    /**
     * Creates a CommandLineRunner bean to check if the database contains data.
     * If the database is empty, it inserts records manually.
     *
     * @param dataSource the file with inserts for data.
     * @param jdbcTemplate the JdbcTemplate used to execute SQL queries
     * @return a CommandLineRunner bean that performs the data check
     */
    @Bean
    public DataSourceInitializer dataSourceInitializer(DataSource dataSource, JdbcTemplate jdbcTemplate) {
        DataSourceInitializer initializer = new DataSourceInitializer();
        initializer.setDataSource(dataSource);

        if (deleteData) {
            jdbcTemplate.update("DELETE FROM endpoint_permissions");
            log.info("\uD83D\uDFE2 Borrando datos de la base.");
        }

        Integer count = jdbcTemplate.queryForObject("SELECT COUNT(*) FROM endpoint_permissions", Integer.class);

        if (count == 0) {
            log.info("\uD83D\uDFE2 Ejecutando scripts, version: {}.", version);
            ResourceDatabasePopulator populator = new ResourceDatabasePopulator();
            for (Resource script : migrationScripts) {
                populator.addScript(script);
            }
            initializer.setDatabasePopulator(populator);
        } else {
            log.info("\uD83D\uDFE2 No se han ejecutado scripts.");
        }

        return initializer;
    }
}
