CREATE TABLE IF NOT EXISTS change_log (
    id SERIAL PRIMARY KEY,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    script_name VARCHAR(255),
    script_details TEXT
);

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('admin', '000_change_log.sql', 'Created change_log schema for tracking migrations.');

