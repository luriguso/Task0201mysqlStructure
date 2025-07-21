/* Database creation */
DROP DATABASE bottle_bottom;
CREATE DATABASE IF NOT EXISTS `bottle_bottom`;
USE `bottle_bottom`;

/* ---------------- CLIENT ---------------- */
CREATE TABLE `client` (
    `id_client` INT NOT NULL AUTO_INCREMENT,
    `id_recommended` INT DEFAULT NULL,
    `name` VARCHAR(100) NOT NULL,
    `mailing_address` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `mail` VARCHAR(100) NOT NULL UNIQUE,
    `registration_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_client`),
    FOREIGN KEY (`id_recommended`) REFERENCES `client` (`id_client`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `client` (`id_client`, `id_recommended`, `name`, `mailing_address`, `phone`, `mail`, `registration_date`) VALUES
(1, NULL, 'Luis Ricardo Gutierrez Soliz', '08906', '631604226', 'luriguso@gmail.com', '2025-06-12 09:34:59'),
(2, 1, 'Jhandira Aiza Balderrama', '01010', '63473721', 'jhanaiba@gmail.com', '2025-06-12 09:35:58'),
(3, 1, 'Wendy Calizaya', '08907', '8237782', 'wendy@gmail.com', '2025-06-12 10:51:30'),
(4, NULL, 'Jose Sanca', '08910', '76123721', 'jose@gmail.com', '2025-06-12 10:51:40'),
(5, 1, 'Fernando Poma', '08908', '57826323', 'fernando@gmail.com', '2025-06-12 10:51:30'),
(6, 3, 'Percy Gamboa', '08906', '8923789', 'percy@gmail.com', '2025-06-12 10:51:55'),
(7, 2, 'Kevin Bozo', '08907', '8237782', 'kevin@gmail.com', '2025-06-12 10:51:30');


/* ---------------- EMPLOYEE ---------------- */
CREATE TABLE `employee` (
    `id_employee` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `employee` (`id_employee`, `name`) VALUES
(1, 'Juan Perez'),
(2, 'Pedro Fernandez'),
(3, 'Luis Gutierrez'),
(4, 'Veimar Gutierrez'),
(5, 'Cristian Jerez');


/* ---------------- PROVIDER ---------------- */
CREATE TABLE `provider` (
    `id_provider` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `phone` VARCHAR(20) NOT NULL,
    `fax` VARCHAR(20) NOT NULL,
    `nif` VARCHAR(20) NOT NULL,
    `street` VARCHAR(100) NOT NULL,
    `number` VARCHAR(20) NOT NULL,
    `floor` VARCHAR(20) NOT NULL,
    `door` VARCHAR(20) NOT NULL,
    `city` VARCHAR(20) NOT NULL,
    `postal_code` VARCHAR(10) NOT NULL,
    `country` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `provider` (`id_provider`, `name`, `phone`, `fax`, `nif`, `street`, `number`, `floor`, `door`, `city`, `postal_code`, `country`) VALUES
(1, 'proveedor police', '987654321', '123-456-7890', 'B12345678', 'Passtge de Llunas', '11', '2', '4', 'Barcelona', '08906', 'España'),
(2, 'Proveedor Rayban', '271232312', '123-456-7812', 'B1234323', 'Carrer rafael campalans', '4', '1', '1', 'Barcelona', '08904', 'España'),
(3, 'Proveedor Oakley', '872368712', '232-343-234', 'A123123', 'Av. Diagonal', '180', '2', '3', 'Barcelona', '08912', 'España'),
(4, 'Proveedor Polaroid', '2132132', '213-433-234', 'B123912', 'Av. Meridiana', '320', '3', '1', 'Barcelona', '08911', 'España'),
(5, 'Proveedor Tous', '4324243', '211-324-234', 'C123123', 'Av. Gran via les corts catalanes', '1101', '12', '5', 'Barcelona', '08916', 'España'),
(6, 'Proveedor Vogue', '645645645', '232-463-234', 'D123123', 'Rambla Prim', '81', '2', '3', 'Barcelona', '08917', 'España');


/* ---------------- BRAND ---------------- */
CREATE TABLE `brand` (
    `id_brand` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `id_provider` INT NOT NULL,
    PRIMARY KEY (`id_brand`),
    FOREIGN KEY (`id_provider`) REFERENCES `provider`(`id_provider`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `brand` (`id_brand`, `name`, `id_provider`) VALUES
(1, 'Police', 1),
(2, 'Rayban', 2),
(3, 'Oakley', 3),
(4, 'Polaroid', 4),
(5, 'Tous', 5),
(6, 'Vogue', 6);


/* ---------------- GLASS ---------------- */
CREATE TABLE `glass` (
    `id_glass` INT NOT NULL AUTO_INCREMENT,
    `id_provider` INT NOT NULL,
    `id_brand` INT NOT NULL,
    `left_lens_prescription` VARCHAR(10) NOT NULL,
    `right_lens_prescription` VARCHAR(10) NOT NULL,
    `mount_type` VARCHAR(10) NOT NULL,
    `crystal_color` VARCHAR(20) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id_glass`),
    FOREIGN KEY (`id_provider`) REFERENCES `provider` (`id_provider`),
    FOREIGN KEY (`id_brand`) REFERENCES `brand` (`id_brand`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `glass` (`id_glass`, `id_provider`, `id_brand`, `left_lens_prescription`, `right_lens_prescription`, `mount_type`, `crystal_color`, `price`) VALUES
(1, 1, 1, '0.25', '0.75', 'floating', 'blue', 150.00),
(2, 2, 2, '0.50', '0.50', 'metallic', 'black', 199.99),
(3, 2, 2, '1.50', '1', 'paste', 'red', 50.00),
(4, 1, 1, '1.75', '1.20', 'floating', 'blue', 150.00),
(5, 3, 3, '1.60', '1', 'metallic', 'green', 250.00),
(6, 4, 4, '1.30', '1.2', 'metallic', 'red', 55.00),
(7, 5, 5, '1.10', '1', 'paste', 'white', 70.00),
(8, 5, 5, '1.20', '1', 'floating', 'black', 80.00),
(9, 3, 3, '1.30', '1', 'metallic', 'red', 100.00),
(10, 4, 4, '1.50', '1', 'paste', 'black', 130.00),
(11, 6, 6, '1.50', '1', 'floating', 'red', 50.00);


/* ---------------- SALE ---------------- */
CREATE TABLE `sale` (
    `id_sale` INT NOT NULL AUTO_INCREMENT,
    `id_client` INT NOT NULL,
    `id_glass` INT NOT NULL,
    `id_employee` INT NOT NULL,
    `sales_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_sale`),
    FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`),
    FOREIGN KEY (`id_glass`) REFERENCES `glass` (`id_glass`),
    FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `sale` (`id_sale`, `id_client`, `id_glass`, `id_employee`, `sales_date`) VALUES
(1, 1, 1, 1, '2025-06-12 10:31:41'),
(2, 2, 3, 4, '2025-05-10 11:01:16'),
(3, 1, 1, 4, '2025-06-10 11:13:36'),
(4, 1, 3, 5, '2024-05-12 11:13:36'),
(5, 1, 4, 4, '2025-06-12 11:13:36'),
(6, 3, 6, 3, '2024-09-11 11:13:36'),
(7, 6, 2, 2, '2024-05-12 11:13:36'),
(8, 3, 9, 2, '2025-06-12 11:13:36'),
(9, 3, 11, 1, '2025-06-12 11:13:36'),
(10, 6, 10, 1, '2024-09-11 11:13:36'),
(11, 7, 3, 4, '2024-05-12 11:13:36'),
(12, 6, 5, 5, '2025-06-10 11:13:36'),
(13, 4, 9, 5, '2025-06-12 11:13:36'),
(14, 6, 9, 2, '2025-06-12 11:13:36'),
(15, 1, 2, 1, '2024-05-12 11:13:36'),
(16, 1, 4, 1, '2025-05-10 11:13:36'),
(17, 1, 6, 1, '2024-09-11 11:13:36'),
(18, 3, 8, 3, '2025-06-12 11:13:36'),
(19, 6, 1, 5, '2025-06-12 11:13:36'),
(20, 3, 3, 4, '2025-06-10 11:13:36'),
(21, 3, 5, 4, '2025-06-12 11:13:36'),
(22, 6, 10, 5, '2024-09-11 11:13:36'),
(23, 7, 2, 5, '2025-06-10 11:13:36'),
(24, 6, 4, 5, '2024-05-12 11:13:36'),
(25, 6, 8, 2, '2025-06-12 11:13:36');
