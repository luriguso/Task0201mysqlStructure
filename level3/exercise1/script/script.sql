/*Database creation*/
CREATE DATABASE `spotify`;

/*Using the Database*/
USE `spotify`;

/*Creating the client table*/
CREATE TABLE `user` (
    `id_user` INT NOT NULL AUTO_INCREMENT,
    `email` VARCHAR(100) NOT NULL UNIQUE,
    `password` VARCHAR(100) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `birthdate` DATE NOT NULL,
    `sex` ENUM('male', 'female', 'other') NOT NULL,
    `country` VARCHAR(50) NOT NULL,
    `postal_code` VARCHAR(10) NOT NULL,
    PRIMARY KEY (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `user` (`email`, `password`, `name`, `birthdate`, `sex`, `country`, `postal_code`)
VALUES 
('alice@example.com', 'alice123', 'Alice', '1990-05-12', 'female', 'USA', '90210'),
('bob@example.com', 'bobsecure', 'Bob', '1985-08-23', 'male', 'UK', 'E1 6AN'),
('carla@example.com', 'carlapass', 'Carla', '1995-03-30', 'female', 'Spain', '28013');


/*Creating the subscription table*/
CREATE TABLE `subscription` (
    `id_subscription` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT NOT NULL,
    `subscription_start_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `service_renewal_date` TIMESTAMP NOT NULL,
    `payment_method` ENUM('credit_card', 'payPal') NOT NULL,
    PRIMARY KEY (`id_subscription`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `subscription` (`id_user`, `subscription_start_date`, `service_renewal_date`, `payment_method`)
VALUES 
(1, '2024-06-01 10:00:00', '2024-07-01 10:00:00', 'credit_card'),
(3, '2024-05-15 08:00:00', '2024-06-15 08:00:00', 'payPal');

/*Creating the credit_card table*/
CREATE TABLE `credit_card` (
    `id_credit_card` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT NOT NULL,
    `number` VARCHAR(19) NOT NULL UNIQUE,
    `month_year` CHAR(7) NOT NULL,
    `security_code` CHAR(4) NOT NULL,
    PRIMARY KEY (`id_credit_card`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `credit_card` (`id_user`, `number`, `month_year`, `security_code`)
VALUES (1, '4111111111111111', '12/2026', '123');

/*Creating the paypal table*/
CREATE TABLE `paypal` (
    `id_paypal` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT NOT NULL,
    `user_name` VARCHAR(200) NOT NULL UNIQUE,
    PRIMARY KEY (`id_paypal`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `paypal` (`id_user`, `user_name`)
VALUES (3, 'carla_paypal_user');

/*Creating the payment table*/
CREATE TABLE `payment` (
    `id_payment` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT NOT NULL,
    `payment_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `order_number` VARCHAR(200) NOT NULL UNIQUE,
    `total_price` DECIMAL(10,2) UNSIGNED NOT NULL,
    PRIMARY KEY (`id_payment`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `payment` (`id_user`, `payment_date`, `order_number`, `total_price`)
VALUES 
(1, '2024-06-01 10:05:00', 'ORD12345', 9.99),
(3, '2024-05-15 08:10:00', 'ORD67890', 9.99);

/*Creating the playlist_songs table*/
CREATE TABLE `artist` (
    `id_artist` INT NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(100) NOT NULL,
    `artist_image` VARCHAR(200) NOT NULL,
    PRIMARY KEY (`id_artist`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `artist` (`name`, `artist_image`)
VALUES 
('Coldplay', 'coldplay.jpg'),
('Adele', 'adele.jpg'),
('Ed Sheeran', 'edsheeran.jpg');

/*Creating the playlist_songs table*/
CREATE TABLE `album` (
    `id_album` INT NOT NULL AUTO_INCREMENT,
    `id_artist` INT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `year_release` INT NOT NULL,
    `cover_image` VARCHAR(200) NOT NULL,
    PRIMARY KEY (`id_album`),
    FOREIGN KEY (`id_artist`) REFERENCES `artist` (`id_artist`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `album` (`id_artist`, `title`, `year_release`, `cover_image`)
VALUES 
(1, 'Parachutes', 2000, 'parachutes.jpg'),
(2, '25', 2015, '25.jpg'),
(3, 'Divide', 2017, 'divide.jpg');

/*Creating the playlist_songs table*/
CREATE TABLE `song` (
    `id_song` INT NOT NULL AUTO_INCREMENT,
    `id_album` INT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `duration` INT NOT NULL,
    `number_plays` INT UNSIGNED NOT NULL DEFAULT 0,
    PRIMARY KEY (`id_song`),
    FOREIGN KEY (`id_album`) REFERENCES `album` (`id_album`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `song` (`id_album`, `title`, `duration`, `number_plays`)
VALUES 
(1, 'Yellow', 270, 500000),
(2, 'Hello', 295, 1200000),
(3, 'Shape of You', 240, 3000000);

/*Creating the playlist table*/
CREATE TABLE `playlist` (
    `id_playlist` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT NOT NULL,
    `title` VARCHAR(100) NOT NULL,
    `number_songs` INT DEFAULT 0,
    `creation_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` ENUM('active', 'removed') NOT NULL DEFAULT 'active',
    PRIMARY KEY (`id_playlist`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `playlist` (`id_user`, `title`, `number_songs`, `creation_date`, `status`)
VALUES (1, 'Chill Vibes', 2, '2024-06-02 12:00:00', 'active');

/*Creating the playlist_songs table*/
CREATE TABLE `playlist_songs` (
    `id_playlist_song` INT NOT NULL AUTO_INCREMENT,
    `id_playlist` INT NOT NULL,
    `added_by_user` INT NOT NULL,
    `id_song` INT NOT NULL,
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_playlist_song`),
    FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id_playlist`),
    FOREIGN KEY (`added_by_user`) REFERENCES `user` (`id_user`),
    FOREIGN KEY (`id_song`) REFERENCES `song` (`id_song`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `playlist_songs` (`id_playlist`, `added_by_user`, `id_song`, `date`)
VALUES 
(1, 2, 1, '2024-06-02 12:05:00'),
(1, 1, 3, '2024-06-02 12:10:00');

CREATE TABLE `related_artist` (
    `id_artist` INT NOT NULL,
    `id_related_artist` INT NOT NULL,
    PRIMARY KEY (`id_artist`, `id_related_artist`),
    FOREIGN KEY (`id_artist`) REFERENCES `artist`(`id_artist`),
    FOREIGN KEY (`id_related_artist`) REFERENCES `artist`(`id_artist`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `related_artist` (`id_artist`, `id_related_artist`)
VALUES 
(1, 3), 
(2, 3); 

CREATE TABLE `favorite_song` (
    `id_user` INT NOT NULL,
    `id_song` INT NOT NULL,
    PRIMARY KEY (`id_user`, `id_song`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
    FOREIGN KEY (`id_song`) REFERENCES `song` (`id_song`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `favorite_song` (`id_user`, `id_song`)
VALUES (3, 3);

CREATE TABLE `favorite_album` (
    `id_user` INT NOT NULL,
    `id_album` INT NOT NULL,
    PRIMARY KEY (`id_user`, `id_album`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
    FOREIGN KEY (`id_album`) REFERENCES `album` (`id_album`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `favorite_album` (`id_user`, `id_album`)
VALUES (1, 1);

CREATE TABLE `follow_artist` (
    `id_user` INT NOT NULL,
    `id_artist` INT NOT NULL,
    PRIMARY KEY (`id_user`, `id_artist`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`),
    FOREIGN KEY (`id_artist`) REFERENCES `artist` (`id_artist`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

INSERT INTO `follow_artist` (`id_user`, `id_artist`)
VALUES 
(1, 1),
(3, 3);