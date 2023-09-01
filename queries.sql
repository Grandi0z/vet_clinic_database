SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name = 'Pikachu' OR name = 'Agumon';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered=true;
SELECT * FROM animals WHERE name NOt IN ('Gabumon');
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3 OR weight_kg = 17.3 OR weight_kg = 10.4;

BEGIN;
UPDATE animals SET species = 'unspecified';

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
ROLLBACK;
COMMIT;

BEGIN;
DELETE FROM animals;
COMMIT;
ROLLBACK;
SELECT * FROM animals

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT DLT2022;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO DLT2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0 ;
COMMIT;
SELECT * FROM animals

SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) as average_weight FROM animals;
SELECT a.name, b.max_escape_attempts
    FROM animals AS a
    JOIN (
        SELECT MAX(escape_attempts) AS max_escape_attempts
        FROM animals
    ) AS b 
    ON a.escape_attempts = b.max_escape_attempts;
SELECT species, MAX(weight_kg), MIN(weight_kg) FROM animals GROUP BY species;  
SELECT species, AVG(escape_attempts) FROM animals 
    WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species; 

SELECT name FROM animals a JOIN owners o ON a.owner_id = o.id WHERE o.full_name = 'Melody Pond';
SELECT a.name FROM animals a JOIN species s ON a.species_id = s.id WHERE s.name Like '%Pokemon%';
SELECT full_name, name FROM animals a RIGHT JOIN owners o ON a.owner_id = o.id;
SELECT s.name, COUNT(*) FROM animals a JOIN species s ON a.species_id = s.id GROUP BY s.name;
SELECT a.name FROM animals a 
    JOIN owners o ON a.owner_id = o.id
    JOIN species s ON a.species_id = s.id WHERE s.name LIKE '%Digimon%' 
    AND o.full_name = 'Jennifer Orwell';
SELECT a.name, full_name FROM animals a 
    JOIN owners o ON a.owner_id = o.id
    JOIN species s ON a.species_id = s.id WHERE a.escape_attempts < 1 
    AND o.full_name = 'Dean Winchester';
SELECT full_name, COUNT(*) AS count FROM animals a
    JOIN owners o ON a.owner_id = o.id
    GROUP BY full_name
    HAVING COUNT(*) = (
        SELECT MAX(count) FROM (SELECT COUNT(*) AS count FROM animals GROUP BY owner_id) t)
    ORDER BY full_name;
