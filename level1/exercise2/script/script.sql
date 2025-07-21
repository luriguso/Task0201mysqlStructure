/* Database creation */
DROP DATABASE pizzeria;
CREATE DATABASE IF NOT EXISTS `pizzeria`;
USE `pizzeria`;

CREATE TABLE `province`(
    `id_province` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `province` (`name`) VALUES
('Barcelona'),
('Valencia'),
('Malaga'),
('Alicante'),
('Vizcaya');

CREATE TABLE `location`(
    `id_location` INT NOT NULL AUTO_INCREMENT,
    `id_province` INT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    PRIMARY KEY (`id_location`),
    FOREIGN KEY (`id_province`) REFERENCES `province` (`id_province`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `location` (`id_province`,`name`) VALUES
(1, 'Hospitalet de Llobregat'),
(1, 'Sabadell'),
(2, 'Torrent'),
(2, 'Gandía'),
(3, 'Marbella'),
(3, 'Vélez-Málaga'),
(4, 'Elche'),
(4, 'Torrevieja'),
(5, 'Barakaldo'),
(5, 'Getxo');

CREATE TABLE `store`(
    `id_store` INT NOT NULL AUTO_INCREMENT,
    `id_location` INT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `address` VARCHAR(100) NOT NULL,
    `postal_code` VARCHAR(20) NOT NULL,
    PRIMARY KEY (`id_store`),
    FOREIGN KEY (`id_location`) REFERENCES `location` (`id_location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `store` (`id_location`,`name`,`address`,`postal_code`) VALUES
(1, 'Pizzeria italiana', 'Passatge de LLunas 11', '08906');

CREATE TABLE `employee`(
    `id_employee` INT NOT NULL AUTO_INCREMENT,
    `id_store` INT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `nif` VARCHAR(20) NOT NULL,
    `number_phone` VARCHAR(20) NOT NULL,
    `title` ENUM('cook', 'delivery_person') NOT NULL,
    PRIMARY KEY (`id_employee`),
    FOREIGN KEY (`id_store`) REFERENCES `store` (`id_store`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `employee` (`id_store`,`name`,`last_name`,`nif`,`number_phone`,`title`) VALUES
(1, 'Carlos', 'García', '12345678A', '612345678', 'cook'),
(1, 'Marta', 'López', '23456789B', '622345679', 'delivery_person'),
(1, 'Luis', 'Martínez', '34567890C', '632345680', 'cook'),
(1, 'Elena', 'Fernández', '45678901D', '642345681', 'delivery_person'),
(1, 'Javier', 'Sánchez', '56789012E', '652345682', 'cook');

CREATE TABLE `category`(
    `id_category` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(50),
    PRIMARY KEY (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `category` (`name`) VALUES
('Pizzas'),
('Drinks'),
('Desserts');

CREATE TABLE `product`(
    `id_product` INT NOT NULL AUTO_INCREMENT,
    `id_category` INT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `description` VARCHAR(200) NOT NULL,
    `image` VARCHAR(300) NOT NULL,
    `price` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id_product`),
    FOREIGN KEY (`id_category`) REFERENCES `category` (`id_category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO product (`id_category`, `name`, `description`, `image`, `price`) VALUES
(1, 'Margherita', 'Classic pizza with tomato, mozzarella, and basil.', 'images/margherita.jpg', 8.99),
(1, 'Pepperoni', 'Spicy pepperoni and mozzarella cheese.', 'images/pepperoni.jpg', 9.99),
(1, 'Hawaiian', 'Ham, pineapple, and cheese.', 'images/hawaiian.jpg', 10.49),
(1, 'Four Cheese', 'Mozzarella, gorgonzola, parmesan, and cheddar.', 'images/four_cheese.jpg', 11.25),
(1, 'Veggie', 'Peppers, onions, olives, and mushrooms.', 'images/veggie.jpg', 9.75),
(2, 'Coca-Cola', 'Chilled 330ml bottle of Coca-Cola.', 'images/coca_cola.jpg', 1.80),
(2, 'Sparkling Water', '500ml sparkling mineral water.', 'images/sparkling_water.jpg', 1.50),
(2, 'Beer', 'Craft beer 330ml bottle.', 'images/beer.jpg', 2.50),
(3, 'Tiramisu', 'Classic Italian dessert with coffee and mascarpone.', 'images/tiramisu.jpg', 4.25),
(3, 'Chocolate Lava Cake', 'Warm chocolate cake with molten center.', 'images/lava_cake.jpg', 4.75);

/*Creating the client table*/
CREATE TABLE `client` (
    `id_client` INT NOT NULL AUTO_INCREMENT,
    `id_location` INT NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `address` VARCHAR(200) NOT NULL,
    `postal_code` VARCHAR(10) NOT NULL,
    `number_phone` VARCHAR(20),
    PRIMARY KEY (`id_client`),
    FOREIGN KEY (`id_location`) REFERENCES `location` (`id_location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO client (`id_location`, `name`, `last_name`, `address`, `postal_code`, `number_phone`) VALUES
(1, 'Laura', 'Gómez', 'Carrer de la Riera Blanca, 12', '08901', '600123456'),
(2, 'David', 'Martínez', 'Av. de Barberà, 45', '08205', '611234567'),
(3, 'Ana', 'Ruiz', 'Calle Mayor, 22', '46900', '622345678'),
(4, 'Jorge', 'Santos', 'Plaza del Prado, 5', '46701', '633456789'),
(5, 'Isabel', 'Navarro', 'Calle Jacinto Benavente, 10', '29601', '644567890');

CREATE TABLE `order` (
    `id_order` INT NOT NULL AUTO_INCREMENT,
    `id_client` INT NOT NULL,
    `id_store` INT NOT NULL,
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `type_order` VARCHAR(50) NOT NULL,
    `product_quantity` INT NOT NULL,
    `total_price` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id_order`),
    FOREIGN KEY (`id_client`) REFERENCES `client` (`id_client`),
    FOREIGN KEY (`id_store`) REFERENCES `store` (`id_store`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `order` (`id_client`, `id_store`, `type_order`, `product_quantity`, `total_price`) VALUES
(1, 1, 'delivery', 2, 22.10),
(2, 1, 'pickup', 1, 9.99),
(3, 1, 'delivery', 3, 27.30),
(4, 1, 'pickup', 2, 19.25),
(5, 1, 'delivery', 1, 12.00),
(1, 1, 'pickup', 2, 20.75),
(3, 1, 'delivery', 1, 7.50),
(2, 1, 'pickup', 3, 29.90),
(4, 1, 'delivery', 2, 17.40),
(5, 1, 'pickup', 1, 11.20);

CREATE TABLE `order_detail` (
    `id_order_detail` INT NOT NULL AUTO_INCREMENT,
    `id_order` INT NOT NULL,
    `id_product` INT NOT NULL,
    `quantity` INT NOT NULL,
    `subtotal` DECIMAL(10,2) NOT NULL,
    PRIMARY KEY (`id_order_detail`),
    FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`),
    FOREIGN KEY (`id_product`) REFERENCES `product` (`id_product`)    
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `order_detail` (`id_order`, `id_product`, `quantity`, `subtotal`) VALUES
(1, 1, 1, 9.25),
(1, 2, 1, 9.25),
(1, 6, 2, 3.60),
(2, 3, 1, 9.99),
(3, 2, 1, 8.50),
(3, 4, 1, 9.30),
(3, 5, 1, 9.50),
(4, 1, 2, 19.25),
(5, 3, 1, 12.00),
(6, 2, 1, 10.75),
(6, 5, 1, 10.00),
(7, 4, 1, 7.50),
(8, 1, 1, 9.90),
(8, 3, 2, 20.00),
(9, 2, 1, 8.40),
(9, 5, 1, 9.00),
(10, 4, 1, 11.20);

CREATE TABLE `delivery` (
    `id_delivery` INT NOT NULL AUTO_INCREMENT,
    `id_order` INT NOT NULL,
    `id_employee` INT NOT NULL,
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_delivery`),
    FOREIGN KEY (`id_order`) REFERENCES `order` (`id_order`),
    FOREIGN KEY (`id_employee`) REFERENCES `employee` (`id_employee`)    
)  ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO delivery (`id_order`, `id_employee`) VALUES
(1, 2),
(3, 4),
(5, 2),
(7, 2),
(9, 4);