package ar.edu.utn.frc.tup.p4.services;

import ar.edu.utn.frc.tup.p4.entities.EndpointPermission;
import ar.edu.utn.frc.tup.p4.filters.AuthorizationFilter;
import jakarta.persistence.EntityNotFoundException;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;

import java.util.Arrays;
import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
@Log4j2
public class AuthorizationService {

    private final EndpointPermissionCacheService endpointPermissionCacheService;

    /**
     * Verifica si un usuario con ciertos roles puede acceder a un endpoint.
     */
    public boolean hasAccess(String endpoint, String method, String userRoles) {
        log.debug("Verificando acceso: endpoint={}, method={}, roles={}", endpoint, method, userRoles);

        String normalizedEndpoint = normalizeEndpoint(endpoint);
        Optional<EndpointPermission> permission = endpointPermissionCacheService.findPermission(normalizedEndpoint, method);

        if (permission.isEmpty()) {
            log.warn("🚫 Endpoint no encontrado en configuración: {} {}", method, normalizedEndpoint);
            throw new EntityNotFoundException("Endpoint no configurado: " + normalizedEndpoint);
        }

        EndpointPermission endpointPermission = permission.get();

        List<String> userRolesList = parseRoles(userRoles);
        boolean hasAccess = endpointPermission.hasAnyRole(userRolesList);

        if (hasAccess) {
            log.info("✅ Acceso permitido para {} {} con roles {}", method, normalizedEndpoint, userRoles);
        } else {
            log.warn("🚫 Acceso denegado para {} {} con roles {}. Roles requeridos: {}",
                    method, normalizedEndpoint, userRoles, endpointPermission.getAllowedRoles());
        }

        return hasAccess;
    }

    /**
     * Verifica si un endpoint es público (delegando en el servicio cacheado).
     */
    public boolean isPublicEndpoint(String endpoint, String method) {
        String normalizedEndpoint = normalizeEndpoint(endpoint);
        return endpointPermissionCacheService.isPublicEndpoint(normalizedEndpoint, method);
    }

    /**
     * Normaliza el endpoint removiendo query params.
     */
    private String normalizeEndpoint(String endpoint) {
        if (endpoint.contains("?")) {
            endpoint = endpoint.substring(0, endpoint.indexOf("?"));
        }
        return endpoint;
    }

    /**
     * Convierte un string de roles separados por coma en una lista.
     */
    private List<String> parseRoles(String roles) {
        if (roles == null || roles.isEmpty()) {
            return List.of();
        }
        return Arrays.asList(roles.split(","));
    }
}
