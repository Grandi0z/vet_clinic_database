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

BEGIN;
SELECT a.name, visit_date FROM visits vi 
    JOIN vets v ON v.id=vi.vets_id 
    JOIN animals a ON a.id = vi.animals_id WHERE v.name='William Tatche'
    AND visit_date = (SELECT MAX(visit_date) FROM visits WHERE animals_id=a.id);
COMMIT;

BEGIN;
SELECT COUNT(*) FROM visits vi
    JOIN vets v ON v.id = vi.vets_id
    JOIN animals a ON a.id = vi.animals_id 
    WHERE v.name = 'Stephanie Mendez';
COMMIT;

BEGIN;
SELECT v.name, sp.name FROM vets v
    LEFT JOIN specializations s ON v.id=s.vets_id
    LEFT JOIN species sp ON sp.id = s.species_id;
COMMIT;

BEGIN;
SELECT a.name, vi.visit_date FROM animals a
    JOIN visits vi ON a.id = vi.animals_id
    JOIN vets v ON v.id = vi.vets_id 
    WHERE v.name = 'Stephanie Mendez' AND vi.visit_date BETWEEN '2020-04-01' AND '2020-10-30';
COMMIT;

BEGIN;
SELECT a.name, COUNT(v.animals_id) AS count FROM visits v 
    JOIN animals a ON a.id = v.animals_id GROUP BY a.name
    HAVING COUNT(v.animals_id) = (
        SELECT MAX(count) FROM (SELECT COUNT(v.animals_id) AS count FROM visits v GROUP BY animals_id) t);
COMMIT;

BEGIN;
SELECT a.name, vi.visit_date FROM visits vi
    JOIN animals a ON a.id = vi.animals_id
    JOIN vets v ON v.id = vi.vets_id WHERE v.name='Maisy Smith' GROUP BY a.name, vi.visit_date
    HAVING vi.visit_date = (SELECT MIN(vi.visit_date) FROM visits vi); 
COMMIT;

BEGIN;
SELECT a.name, v.name, vi.visit_date FROM visits vi
    JOIN animals a ON a.id = vi.animals_id
    JOIN vets v ON v.id = vi.vets_id GROUP BY a.name, v.name, vi.visit_date
    HAVING vi.visit_date = (SELECT MAX(vi.visit_date) FROM visits vi);
COMMIT;

BEGIN;
SELECT COUNT(*) AS count FROM visits vi
JOIN animals a ON vi.animals_id = a.id
WHERE vi.vets_id NOT IN (SELECT sp.vets_id FROM specializations sp WHERE sp.species_id = a.species_id);
COMMIT;

BEGIN;
SELECT a.species_id, COUNT(*) AS count, s.name FROM visits vi 
JOIN animals a ON vi.animals_id = a.id
JOIN specializations sp ON sp.species_id = a.species_id 
JOIN vets v ON v.id = vi.vets_id 
JOIN species s ON s.id = sp.species_id 
WHERE v.name = 'Maisy Smith'
GROUP BY a.species_id, s.name
ORDER BY count DESC
LIMIT 1;
COMMIT;


