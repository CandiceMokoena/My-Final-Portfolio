-- CYBER SECURITY ATTACKS --

DROP TABLE IF EXISTS cybers_attacks2;
CREATE TABLE cybers_attacks2
LIKE cybers_attacks;

INSERT into cybers_attacks2
		SELECT*
			FROM cyber_attacks.cybers_attacks;

-- IDENTIFY AND REMOVE DUPLICATES --
SELECT `Timestamp`, `Source IP Address`, `Destination IP Address`, `Source Port`, `Destination IP Address`,
 `Protocol`, `Packet Length`, `Packet Type`, `Traffic Type`, `Malware Indicators`, `Anomaly Scores`, `Alerts/Warnings`,
 `Attack Type`, `Attack Signature`, `Action Taken`, `Severity Level`, `User Information`, `Device Information`, `Network Segment`,
 `Geo-location Data`, `Proxy Information`, `Firewall Logs`, `IDS/IPS Alerts`, `Log Source`,
	COUNT(*) AS duplicate_count
FROM cybers_attacks2
GROUP BY `Timestamp`, `Source IP Address`, `Destination IP Address`, `Source Port`, `Destination IP Address`,
 `Protocol`, `Packet Length`, `Packet Type`, `Traffic Type`, `Malware Indicators`, `Anomaly Scores`, `Alerts/Warnings`,
 `Attack Type`, `Attack Signature`, `Action Taken`, `Severity Level`, `User Information`, `Device Information`, `Network Segment`,
 `Geo-location Data`, `Proxy Information`, `Firewall Logs`, `IDS/IPS Alerts`, `Log Source`
HAVING COUNT(*) > 1;

-- STANDARDIZE THE DATA --

-- TRIMMING --
UPDATE cybers_attacks2
	SET
    Timestamp = TRIM(Timestamp),
    `Source IP Address` = TRIM(`Source IP Address`),
    `Destination IP Address` = TRIM(`Destination IP Address`),
	Protocol =  TRIM(Protocol),
	`Packet type` = TRIM(`Packet type`),
    `Traffic type` = TRIM(`Traffic type`),
    `Malware Indicators` = TRIM(`Malware Indicators`),
    `Alerts/Warnings` = TRIM(`Alerts/Warnings`),
    `Attack type` = TRIM(`Attack type`),
    `Attack Signature` = TRIM(`Attack Signature`),
    `Action Taken` = TRIM(`Action Taken`),
    `Severity Level` = TRIM(`Severity Level`),
    `User Information` = TRIM(`User Information`),
    `Device Information` = TRIM(`Device Information`),
    `Network Segment` = TRIM(`Network Segment`),
    `Geo-location Data` = TRIM(`Geo-location Data`),
    `Proxy Information` = TRIM(`Proxy Information`),
	`Firewall Logs` = TRIM(`Firewall Logs`),
    `IDS/IPS Alerts` = TRIM(`IDS/IPS Alerts`),
    `Log Source` = TRIM(`Log Source`),
    `Anomaly Scores` = TRIM(`Anomaly Scores`);
    
    UPDATE cybers_attacks2
	SET `Timestamp` = STR_TO_DATE(`Timestamp`, '%m/%d/%Y %H:%i');
    
    SELECT `Source IP Address`, `Destination IP Address`, `Anomaly Scores`, `Proxy Information`
	FROM cybers_attacks2
    WHERE `Source IP Address` LIKE '%,%' 
			OR `Destination IP Address` LIKE '%,%' 
            OR `Anomaly Scores` LIKE '%,%'
			OR `Proxy Information` LIKE '%,%';
            
SELECT `Source IP Address`, `Destination IP Address`, `Source Port`, `Destination Port`, 
		`Packet Length`, `Anomaly Scores`, `Proxy Information`
			FROM cybers_attacks2
			WHERE `Source IP Address` REGEXP '[a-zA-Z]' 
					OR `Destination IP Address` REGEXP '[a-zA-Z]' 
                    OR `Source Port` REGEXP '[a-zA-Z]'
					OR `Destination Port` REGEXP '[a-zA-Z]'
                    OR `Packet Length` REGEXP '[a-zA-Z]' 
                    OR `Anomaly Scores` REGEXP '[a-zA-Z]'
                    OR `Proxy Information` REGEXP '[a-zA-Z]';

SELECT DISTINCT `Log Source`
	FROM cybers_attacks2
    ORDER BY `Log Source`;

-- DROP A COLUMN --
ALTER TABLE cybers_attacks2
DROP COLUMN `User Information`;


SELECT*
FROM cybers_attacks2
ORDER BY timestamp ASC;