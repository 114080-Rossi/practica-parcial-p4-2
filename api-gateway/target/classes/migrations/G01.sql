-- ===================================
-- Grupo G01
-- ===================================

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/registers');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/registers/withdraw');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/registers/open');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/registers/deposit');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/registers/close');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/{id}/summary');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/session/{id}/movements');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/session/current');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/branch/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/bulk');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/sync');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/branch/closed');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/registers/{id}/name');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/payments');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/payments/{id}/refund');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/payments/{id}/cancel');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/payments/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PATCH', 'secretaria,administrador', NULL, '/api/v1/payments/{id}/invoices/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/mercadopago/pos');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/mercadopago/orders/{id}/refund');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/mercadopago/orders/{id}/cancel');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'secretaria,administrador', NULL, '/api/v1/collections/{id}/collect');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/billing/invoices');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/billing/invoices/customers');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/billing/invoices/customers');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/billing/invoices/{id}/pdf');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/billing/invoices/sales');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'secretaria,administrador', NULL, '/api/v1/billing/invoices/sales/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'secretaria,administrador', NULL, '/api/v1/registers/deposit/liquidation');
