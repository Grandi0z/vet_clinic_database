CREATE DATABASE vet_clinic;

CREATE TABLE animals (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30) NOT NULL,
    date_of_birth DATE,
    escape_attempts SMALLINT,
    neutered BOOLEAN NOT NULL,
    weight_kg DECIMAL(7,2) NOT NULL);

ALTER TABLE animals ADD COLUMN species VARCHAR(30);

CREATE TABLE owners (
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(30) NOT NULL,
    age INT,
    PRIMARY KEY(id));
CREATE TABLE species (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(20) NOT NULL);
ALTER TABLE animals ADD CONSTRAINT pk_animals PRIMARY KEY (id);
ALTER TABLE species ADD CONSTRAINT pk_species PRIMARY KEY (id);

ALTER TABLE animals DROP COLUMN IF EXISTS species;
ALTER TABLE animals ADD COLUMN  species_id INT;
ALTER TABLE animals ADD COLUMN owner_id INT;
ALTER TABLE animals ADD CONSTRAINT fk_species FOREIGN KEY(species_id) REFERENCES species(id);
ALTER TABLE animals ADD CONSTRAINT fk_owners FOREIGN KEY(owners_id) REFERENCES owners(id);

CREATE TABLE vets (
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(30) NOT NULL,
    age INT,
    date_of_graduation DATE,
    PRIMARY KEY(id));

CREATE TABLE specializations (
    species_id INT,
    vets_id INT,
    PRIMARY KEY(species_id, vets_id));

CREATE TABLE visits (
    animals_id INT,
    vets_id INT,
    visit_date DATE,
    PRIMARY KEY(animals_id, vets_id, date));

ALTER TABLE visits ADD CONSTRAINT fk_animal FOREIGN KEY (animals_id) REFERENCES animals (id)
ON UPDATE CASCADE
ON DELETE SET NULL;
ALTER TABLE visits ADD CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id)
ON UPDATE CASCADE
ON DELETE SET NULL;

ALTER TABLE specializations ADD CONSTRAINT fk_species FOREIGN KEY (species_id) REFERENCES species (id)
ON UPDATE CASCADE
ON DELETE SET NULL;
ALTER TABLE specializations ADD CONSTRAINT fk_vets FOREIGN KEY (vets_id) REFERENCES vets (id)
ON UPDATE CASCADE
ON DELETE SET NULL;

ALTER TABLE owners ADD COLUMN email VARCHAR(120);

CREATE INDEX idx_animal_id ON visits(animal_id);
CREATE INDEX idx_vet_id ON visits(vet_id);
CREATE INDEX idx_email ON owners(email);
CLUSTER visits USING idx_animal_id;