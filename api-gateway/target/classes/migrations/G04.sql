-- ===================================
-- Grupo G04
-- ===================================
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/plans/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/plans/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/plans/patient-coverage-details');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/plans/deactivate/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/plans/activate/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/plans');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/plans');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/plans/complete/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/plans/complete/search');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/deactivate/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/activate/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/insurers');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/complete/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/{id}/complete');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/complete/search');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/complete/by-coverage/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurers/complete/by-agreement/{id}');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurer-contact-infos');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/insurer-contact-infos');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/insurer-contact-infos');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/insurer-contact-infos/deactivate');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurer-contact-infos/{id}');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/agreements/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/agreements/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/agreements/deactivate/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/agreements');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/agreements');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/agreements/search');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/contact-types');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/wizard');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/wizard/plan');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/pricing/calculate');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/insurer-types');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/excel/settlement/{id}');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/provided-services/{id}');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/provided-services');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/settlement');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/settlement/preview');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'POST', 'facturista,administrador', NULL, '/api/v1/coverages/settlement');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/settlement-pages');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/settlement/inform');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/settlement/cancel');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'PUT', 'facturista,administrador', NULL, '/api/v1/coverages/settlement/register-payment');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/settlement/{id}');

INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/reports/insurer-distribution');
INSERT INTO endpoint_permissions (is_public, created_at, http_method, allowed_roles, description, endpoint_path) VALUES (false, NOW(), 'GET', 'facturista,administrador', NULL, '/api/v1/coverages/reports/summary');
