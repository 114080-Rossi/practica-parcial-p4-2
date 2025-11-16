-- ===================================
-- Grupo G02
-- ===================================

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (true, NOW(), 'GET', '', NULL, '/api/v1/user/ping');