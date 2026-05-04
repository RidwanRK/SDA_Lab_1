CREATE TABLE IF NOT EXISTS sprint_result (
    result_id SERIAL PRIMARY KEY,
    race_id INT REFERENCES race_weekend(race_id),
    driver_id INT REFERENCES driver(driver_id),
    finish_position INT,
    sprint_points INT DEFAULT 0,
    is_dnf BOOLEAN,
    UNIQUE(driver_id, race_id)
);

DELIMITER //
CREATE TRIGGER trg_check_sprint_eligibility
BEFORE INSERT ON sprint_result
FOR EACH ROW
BEGIN
    -- Check if the race weekend actually has a sprint enabled
    IF NOT EXISTS (
        SELECT 1 FROM race_weekend 
        WHERE race_id = NEW.race_id AND has_sprint = TRUE
    ) THEN
        -- Raise a custom error message
        SIGNAL SQLSTATE '45000' 
        SET MESSAGE_TEXT = 'Cannot record sprint points for a race weekend without a sprint.';
    END IF;
END;
//
DELIMITER ;

INSERT INTO change_log (script_name, script_details) 
VALUES ('004_create_sprint_result.sql', 'Created sprint_result table, added unique constraint, and implemented sprint eligibility trigger.');

SELECT * from sprint_result;
