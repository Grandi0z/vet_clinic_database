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
