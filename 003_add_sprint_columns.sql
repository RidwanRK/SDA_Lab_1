ALTER TABLE race_weekend 
ADD COLUMN has_sprint BOOLEAN DEFAULT FALSE;

ALTER TABLE race_weekend 
ADD COLUMN sprint_date TIMESTAMP;

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('admin','003_add_sprint_columns.sql', 'Added has_sprint and sprint_date to race_weekend.');



SELECT * FROM race_weekend;