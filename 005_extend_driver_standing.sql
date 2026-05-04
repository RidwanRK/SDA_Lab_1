ALTER TABLE driver_standing 
ADD COLUMN sprint_points INT DEFAULT 0;


DELIMITER //
CREATE PROCEDURE update_sprint_standing(IN target_driver_id INT, IN target_season INT)
BEGIN
    UPDATE driver_standing
    SET sprint_points = (
        SELECT COALESCE(SUM(sr.sprint_points), 0)
        FROM sprint_result sr
        JOIN race_weekend rw ON sr.race_id = rw.race_id
        WHERE sr.driver_id = target_driver_id
        AND rw.season = target_season
    )
    WHERE driver_id = target_driver_id
    AND season = target_season;
END //
DELIMITER ;

INSERT INTO change_log (created_by, script_name, script_details) 
VALUES ('admin','005_extend_driver_standing.sql', 'Added sprint_points to driver_standing and created update_sprint_standing procedure.');

SELECT driver_id, season, total_points, sprint_points
FROM driver_standing
ORDER BY driver_id, season;
