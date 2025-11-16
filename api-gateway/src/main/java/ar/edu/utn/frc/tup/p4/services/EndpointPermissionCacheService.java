package ar.edu.utn.frc.tup.p4.services;

import ar.edu.utn.frc.tup.p4.entities.EndpointPermission;
import ar.edu.utn.frc.tup.p4.repositories.EndpointPermissionRepository;
import lombok.RequiredArgsConstructor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Optional;

@Service
@RequiredArgsConstructor
public class EndpointPermissionCacheService {

    private static final Logger log = LoggerFactory.getLogger(EndpointPermissionCacheService.class);
    private final EndpointPermissionRepository endpointPermissionRepository;

    /**
     * Busca un permiso de endpoint (usa caché para reducir consultas repetidas).
     */
    @Cacheable(value = "endpointPermissions", key = "#endpoint + ':' + #method")
    public Optional<EndpointPermission> findPermission(String endpoint, String method) {
        log.info("🔍 Buscando permiso en BD o caché: {} {}", method, endpoint);

        // Intentar búsqueda exacta
        Optional<EndpointPermission> exact = endpointPermissionRepository.findByEndpointPathAndHttpMethod(endpoint, method);
        if (exact.isPresent()) {
            return exact;
        }

        // Buscar con path pattern (ej: /api/users/{id})
        List<EndpointPermission> exacts = endpointPermissionRepository.findByPathPatternAndMethod(endpoint, method);
        long slashCount = endpoint.chars().filter(ch -> ch == '/').count();
        return exacts.stream()
                .filter(e -> endpoint.matches(e.getEndpointPath().replace("{id}", "[^/]+"))
                        && e.getHttpMethod().equalsIgnoreCase(method)
                        && e.getEndpointPath().chars().filter(ch -> ch == '/').count() == slashCount)
                .findFirst();
    }

    /**
     * Determina si un endpoint es público (resultado cacheado).
     */
    @Cacheable(value = "publicEndpoints", key = "#endpoint + ':' + #method")
    public boolean isPublicEndpoint(String endpoint, String method) {
        return findPermission(endpoint, method)
                .map(p -> Boolean.TRUE.equals(p.getIsPublic()))
                .orElse(false);
    }
}
