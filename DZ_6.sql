DROP DATABASE IF EXISTS DZ6;
CREATE DATABASE IF NOT EXISTS DZ6;
USE DZ6;

-- Создайте процедуру, которая принимает кол-во сек и формат их в кол-во дней часов. Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '

DELIMITER //
CREATE PROCEDURE task_1(seconds INT)
BEGIN
	DECLARE days INT default 0;
    DECLARE hours INT default 0;
    DECLARE minutes INT default 0;
    
	CASE
        WHEN seconds BETWEEN 1 AND 59 THEN
			SET days = 0;
            SET hours = 0;
            SET minutes = 0;
		WHEN seconds BETWEEN 60 AND 3599 THEN
			SET days = 0;
            SET hours = 0;
            SET minutes = seconds DIV 60;
            SET seconds = seconds MOD 60;
		WHEN seconds BETWEEN 3600 AND 84599 THEN
			SET days = 0;
            SET hours = seconds DIV 3600;
            SET minutes = seconds MOD 3600 DIV 60;
            SET seconds = seconds MOD 86400 MOD 3600 MOD 60;
		WHEN seconds >= 86400 THEN
			SET days = seconds DIV 86400;
            SET hours = seconds MOD 86400 DIV 3600;
            SET minutes = seconds MOD 86400 MOD 3600 DIV 60;
            SET seconds = seconds MOD 86400 MOD 3600 MOD 60;
		ELSE
			SELECT "Некорректное число";
	END CASE;
	SELECT days, hours, minutes, seconds;
END //
DELIMITER ;

CALL task_1(123456);

-- Создайте функцию, которая выводит только четные числа от 1 до 10. Пример: 2,4,6,8,10

DELIMITER //
CREATE FUNCTION task_2()
RETURNS VARCHAR(30)
DETERMINISTIC
BEGIN
    DECLARE result VARCHAR(30) DEFAULT "2";
    DECLARE num INT DEFAULT 2;
	WHILE num < 10 DO
		SET num = num + 2;
        SET result = CONCAT(result, ",", num);
    END WHILE;
	RETURN result;
END //
DELIMITER ;

SELECT task_2();