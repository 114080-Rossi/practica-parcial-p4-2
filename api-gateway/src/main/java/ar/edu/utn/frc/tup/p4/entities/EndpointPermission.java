package ar.edu.utn.frc.tup.p4.entities;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.beans.Transient;
import java.time.LocalDateTime;
import java.util.Arrays;
import java.util.List;

/**
 * Entidad que define qué roles pueden acceder a cada endpoint.
 */
@Entity
@Table(name = "endpoint_permissions")
@Data
@NoArgsConstructor
@AllArgsConstructor
public class EndpointPermission {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    /**
     * Path del endpoint (puede incluir variables como {id}).
     * Ejemplos: /api/users, /api/orders/{id}
     */
    @Column(name = "endpoint_path", nullable = false)
    private String endpointPath;

    /**
     * Método HTTP permitido.
     */
    @Column(name = "http_method", nullable = false, length = 10)
    private String httpMethod;

    /**
     * Roles permitidos separados por comas.
     * Ejemplo: "ROLE_ADMIN,ROLE_MANAGER"
     */
    @Column(name = "allowed_roles", nullable = false, length = 500)
    private String allowedRoles;

    /**
     * Si es público, no se validan roles.
     */
    @Column(name = "is_public")
    private Boolean isPublic = false;

    /**
     * Descripción del endpoint.
     */
    @Column(name = "description")
    private String description;

    @Column(name = "created_at")
    private LocalDateTime createdAt;

    /**
     * Convierte el string de roles en una lista.
     * @return Lista de roles permitidos
     */
    @Transient
    public List<String> getAllowedRolesList() {
        if (allowedRoles == null || allowedRoles.isEmpty()) {
            return List.of();
        }
        return Arrays.asList(allowedRoles.split(","));
    }

    /**
     * Verifica si un rol específico tiene acceso.
     * @param role El rol a verificar
     * @return true si el rol tiene acceso
     */
    @Transient
    public boolean hasRole(String role) {
        return getAllowedRolesList().contains(role.toLowerCase());
    }

    /**
     * Verifica si alguno de los roles del usuario tiene acceso.
     * @param userRoles Lista de roles del usuario
     * @return true si al menos un rol tiene acceso
     */
    @Transient
    public boolean hasAnyRole(List<String> userRoles) {
        return userRoles.stream()
                .anyMatch(this::hasRole);
    }
}
