INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg) VALUES 
('Agumon', '2020-02-02', 0, true, 10.23),
('Gabumon', '2018-11-15', 2, TRUE, 8),
('Pikachu', '2021-01-07', 1, false, 15.04),
('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, weight_kg, neutered, escape_attempts) VALUES 
('Charmander', '2020-02-08', -11, , false, 0),
('Plantmon', '2021-11-15', -5.7, , true, 2),
('Squirtle', '1993-04-02', -12.13, false, 3),
('Angemon', '2005-06-12', -45, true, 1),
('Boarmon', '2005-06-07', 20.4, true, 7),
('Blossom', '1998-10-13', 17, true, 3),
( 'Ditto', '2022-05-14', 22, true, 4);

INSERT INTO owners (full_name, age) VALUES 
('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond',77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

INSERT INTO species (name) VALUES 
('Pokemon'),
('Digimon');

UPDATE animals SET species_id = CASE
  WHEN name LIKE '%mon' THEN 2
  WHEN species_id IS NULL THEN 1
  ELSE species_id
END;

UPDATE animals SET owner_id = CASE
  WHEN name IN ('Agumon')  THEN 1
  WHEN name IN ('Gabumon', 'Pikachu')  THEN 2
  WHEN name IN ('Devimon', 'Plantmon')  THEN 3
  WHEN name IN ('Charmander', 'Squirtle', 'Blossom')  THEN 4
  WHEN name IN ('Angemon', 'Boarmon')  THEN 5
  ELSE owner_id
END;

