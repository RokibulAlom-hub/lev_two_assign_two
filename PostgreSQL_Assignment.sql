-- Active: 1747470424969@@127.0.0.1@5432@conservation_db
-- created rangers table and instered data
CREATE TABLE rangers (
    rangerid SERIAL ,
    rname VARCHAR(50),
    region VARCHAR(20)
) ;
INSERT INTO rangers ( rname, region)
VALUES
      
      ('Bob White' , 'River Delta'),
      ('Carol King' , 'Mountain Range') ;
-- created specis table and instered data
CREATE TABLE species (
    speciesid SERIAL,
    common_name VARCHAR(20),
    scientific_name VARCHAR(60),
    discovery_date DATE,
    conservation_status VARCHAR(20)
) ;      
INSERT INTO species (common_name, scientific_name, discovery_date, conservation_status) 
VALUES 
('Snow Leopard', 'Panthera uncia', '1775-01-01', 'Endangered'),
('Bengal Tiger', 'Panthera tigris tigris', '1758-01-01', 'Endangered'),
('Red Panda', 'Ailurus fulgens', '1825-01-01', 'Vulnerable'),
('Asiatic Elephant', 'Elephas maximus indicus', '1758-01-01', 'Endangered');

-- creating sighting table and inserting data
CREATE TABLE sightings (
   sighting_id SERIAL PRIMARY KEY,
   speciesid INTEGER REFERENCES species(speciesid),
   rangerid INTEGER REFERENCES rangers(rangerid),
   locations VARCHAR(20),
   sighting_time TIMESTAMP,
   note VARCHAR(50)
) ;
INSERT INTO sightings (sighting_id, speciesid, rangerid, locations, sighting_time, note) 
VALUES 
(1, 1, 1, 'Peak Ridge', '2024-05-10 07:45:00', 'Camera trap image captured'),
(2, 2, 2, 'Bankwood Area', '2024-05-12 16:20:00', 'Juvenile seen'),
(3, 3, 3, 'Bamboo Grove East', '2024-05-15 09:10:00', 'Feeding observed'),
(4, 1, 2, 'Snowfall Pass', '2024-05-18 18:30:00', NULL);
SELECT * FROM rangers ;     
ALTER TABLE rangers ADD PRIMARY KEY (rangerid);

--task 1 input first data into rangers table 
INSERT INTO rangers (rname , region) VALUES ('Derek Fox', 'Coastal Plains') ;

--task 2 Count unique species ever sighted
SELECT  COUNT (DISTINCT speciesid) 
FROM sightings ;

--task 3 Find all sightings where the location includes "Pass".
SELECT * FROM sightings
WHERE locations LIKE '%Pass%';
-- task 4 List each ranger's name and their total number of sightings.
SELECT rangers.rname , COUNT(sightings.rangerid) AS total_sightings
FROM rangers 
LEFT JOIN sightings ON rangers.rangerid = sightings.rangerid 
GROUP BY rangers.rname ;

--task 5 List species that have never been sighted.
SELECT species.common_name 
FROM species 
LEFT JOIN sightings ON species.speciesid = sightings.speciesid 
WHERE sightings.speciesid IS NULL ; 

--task 6 show the most recent two sightings
SELECT sighting_time
FROM sightings 
ORDER BY sighting_time DESC
LIMIT 2;

--task 7 Update all species discovered before year 1800 to have status 'Historic'.

UPDATE species
SET conservation_status = 'Historic'
WHERE discovery_date <= '1800-01-01' ;
SELECT conservation_status FROM species ;
-- task 8 Label each sighting's time of day as 'Morning', 'Afternoon', or 'Evening'.

SELECT sighting_id,sighting_time,
  CASE 
    WHEN EXTRACT (HOUR FROM sighting_time) >= 6 AND  EXTRACT (HOUR FROM sighting_time) < 12 THEN 'Morning'
    WHEN EXTRACT (HOUR FROM sighting_time) >= 12 AND  EXTRACT (HOUR FROM sighting_time) < 18 THEN 'Afternoon'
    ELSE 'Evening'
  END AS time_of_day
FROM sightings ;

--task 9 Delete rangers who have never sighted any species

DELETE FROM species
WHERE NOT EXISTS (
    SELECT 1
    FROM sightings
    WHERE sightings.speciesid = species.speciesid
) ;

