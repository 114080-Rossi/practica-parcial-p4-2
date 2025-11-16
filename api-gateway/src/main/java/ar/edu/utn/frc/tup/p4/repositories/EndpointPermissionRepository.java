package ar.edu.utn.frc.tup.p4.repositories;

import ar.edu.utn.frc.tup.p4.entities.EndpointPermission;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface EndpointPermissionRepository extends JpaRepository<EndpointPermission, Long> {

    /**
     * Busca un endpoint específico por path y método.
     * @param path Path del endpoint
     * @param method Método HTTP
     * @return Optional con el permiso si existe
     */
    Optional<EndpointPermission> findByEndpointPathAndHttpMethod(String path, String method);

    /**
     * Busca si un endpoint es público.
     * @param path Path del endpoint
     * @param method Método HTTP
     * @return true si el endpoint es público
     */
    @Query("SELECT e.isPublic FROM EndpointPermission e WHERE e.endpointPath = :path AND e.httpMethod = :method")
    Optional<Boolean> isPublicEndpoint(@Param("path") String path, @Param("method") String method);

    /**
     * Verifica si un endpoint con path que incluye variables existe.
     * Ej: /api/users/123 debería matchear con /api/users/{id}
     */
    @Query("SELECT e FROM EndpointPermission e WHERE :path LIKE CONCAT(REPLACE(e.endpointPath, '{id}', '%'), '%') AND e.httpMethod = :method")
    List<EndpointPermission> findByPathPatternAndMethod(@Param("path") String path, @Param("method") String method);
}
