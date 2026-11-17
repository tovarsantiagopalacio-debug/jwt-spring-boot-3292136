-- Base de datos del proyecto innovation (ficha 3292136)
-- Con ddl-auto: none, Hibernate no crea las tablas: hay que correr este script una vez.

CREATE DATABASE IF NOT EXISTS innovation;
USE innovation;

CREATE TABLE IF NOT EXISTS roles (
    id          BIGINT AUTO_INCREMENT PRIMARY KEY,
    name        VARCHAR(50)  NOT NULL,
    description VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS users (
    id       BIGINT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL, -- hash BCrypt (60 caracteres)
    email    VARCHAR(150) NOT NULL UNIQUE,
    rol_id   BIGINT       NOT NULL,
    CONSTRAINT fk_users_roles FOREIGN KEY (rol_id) REFERENCES roles (id)
);

-- Roles iniciales: el registro exige que el rolId exista
INSERT INTO roles (name, description)
SELECT 'ADMIN', 'Administrador' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'ADMIN');
INSERT INTO roles (name, description)
SELECT 'USER', 'Usuario' WHERE NOT EXISTS (SELECT 1 FROM roles WHERE name = 'USER');
