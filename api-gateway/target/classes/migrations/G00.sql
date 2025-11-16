-- ===================================
-- Grupo G00
-- ===================================

-- Analytical Mng
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols/{id}/samples');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols/{id}/collect-samples');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols/{id}/samples/collect');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/api/v1/protocols/{id}/samples/check-out');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'administrador,tecnico_laboratorio,bioquimico', NULL, '/protocols/{id}/samples/{id}/status/{id}');

-- Nbu
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,facturista,administrador,externo', NULL, '/api/v1/analysis');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,facturista,administrador,externo', NULL, '/api/v1/analysis/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,facturista,administrador', NULL, '/api/v1/analysis/nbu/versions');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PATCH', 'secretaria,facturista,administrador', NULL, '/api/v1/analysis/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PATCH', 'secretaria,facturista,administrador', NULL, '/api/v1/analysis/{id}/nbu');
