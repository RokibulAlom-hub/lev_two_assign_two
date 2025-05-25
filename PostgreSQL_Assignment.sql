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
SELECT * FROM sightings ;     
ALTER TABLE rangers ADD PRIMARY KEY (rangerid); 