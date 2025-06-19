/*Database creation*/
CREATE DATABASE `youtube`;

/*Using the Database*/
USE `youtube`;

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

/*Adding Sample Records to user*/
INSERT INTO `user` (`email`, `password`, `name`, `birthdate`, `sex`, `country`, `postal_code`) VALUES
('alice@example.com', 'hashedpass1', 'Alice', '1990-04-15', 'female', 'USA', '90210'),
('bob@example.com', 'hashedpass2', 'Bob', '1988-06-22', 'male', 'UK', 'W1D4FA'),
('carol@example.com', 'hashedpass3', 'Carol', '1995-12-03', 'other', 'Canada', 'M5V2T6');

/*Creating the video table*/
CREATE TABLE `video` (
    `id_video` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT NOT NULL,
    `title` VARCHAR(200) NOT NULL,
    `description` VARCHAR(500) NOT NULL,
    `size` DECIMAL(10,2) NOT NULL,
    `name_file` VARCHAR(200),
    `duration` TIME NOT NULL,
    `Thumbnail` VARCHAR(300) NOT NULL,
    `number_views` INT UNSIGNED NOT NULL DEFAULT 0,
    `number_likes` INT UNSIGNED NOT NULL DEFAULT 0,
    `number_dislikes` INT UNSIGNED NOT NULL DEFAULT 0,
    `status` ENUM('public', 'hidden', 'private') NOT NULL DEFAULT 'private',
    `publish_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_video`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to video*/
INSERT INTO `video` (`id_user`, `title`, `description`, `size`, `name_file`, `duration`, `Thumbnail`, `status`) VALUES
(1, 'Trip to Iceland', 'Snow, volcanoes, and waterfalls.', 250.75, 'iceland_trip.mp4', '00:12:34', 'thumb_iceland.jpg', 'public'),
(2, 'iPhone Review', 'Unboxing and review of iPhone 15.', 180.50, 'iphone15.mp4', '00:08:00', 'thumb_iphone.jpg', 'public'),
(3, 'Vegan Lasagna', 'Delicious plant-based lasagna.', 320.20, 'vegan_lasagna.mp4', '00:10:15', 'thumb_lasagna.jpg', 'public');


/*Creating the provider table*/
CREATE TABLE `tag` (
    `id_tag` int(11) NOT NULL AUTO_INCREMENT,
    `name` varchar(100) NOT NULL,
    PRIMARY KEY (`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to tag*/
INSERT INTO `tag` (`name`) VALUES
('travel'),
('tech'),
('cooking'),
('vegan'),
('review');

/*Creating the tag_video table*/
CREATE TABLE `tag_video` (
    `id_video` int(11) NOT NULL,
    `id_tag` int(11) NOT NULL,
    PRIMARY KEY (`id_video`, `id_tag`),
    FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`),
    FOREIGN KEY (`id_tag`) REFERENCES `tag` (`id_tag`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to tag_video*/
INSERT INTO `tag_video` (`id_video`, `id_tag`) VALUES
(1, 1),
(2, 2),
(2, 5),
(3, 3),
(3, 4);

/*Creating the channel sale*/
CREATE TABLE `channel` (
    `id_channel` INT NOT NULL AUTO_INCREMENT,
    `id_user` INT(11) NOT NULL,
    `name` VARCHAR(200) NOT NULL,
    `description` VARCHAR(500) NOT NULL,
    `date_creation` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_channel`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to channel*/
INSERT INTO `channel` (`id_user`, `name`, `description`) VALUES
(1, 'Alice Vlogs', 'Exploring the world'),
(2, 'Bob Tech', 'Tech reviews and tutorials'),
(3, 'Cooking with Carol', 'Easy and fun recipes');

/*Creating the subscription table*/
CREATE TABLE `subscription` (
    `id_channel` INT NOT NULL,
    `id_user` INT NOT NULL,
    PRIMARY KEY (`id_channel`, `id_user`),
    FOREIGN KEY (`id_channel`) REFERENCES `channel` (`id_channel`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to subscription*/
INSERT INTO `subscription` (`id_channel`, `id_user`) VALUES
(1, 2),
(1, 3),
(3, 1);

/*Creating the video_reaction table*/
CREATE TABLE `video_reaction` (
    `id_video` int(11) NOT NULL,
    `id_user` int(11) NOT NULL,
    `reaction` ENUM('like', 'dislike') NOT NULL DEFAULT 'like',
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_video`, `id_user`),
    FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to video_reaction*/
INSERT INTO `video_reaction` (`id_video`, `id_user`, `reaction`) VALUES
(1, 2, 'like'),
(1, 3, 'like'),
(2, 1, 'dislike'),
(3, 1, 'like'),
(3, 2, 'like');

/*Creating the playlist table*/
CREATE TABLE `playlist` (
    `id_playlist` int(11) NOT NULL AUTO_INCREMENT,
    `id_user` int(11) NOT NULL,
    `name` VARCHAR(100) NOT NULL,
    `date_creation` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `status` ENUM('public', 'private') NOT NULL DEFAULT 'private',
    PRIMARY KEY (`id_playlist`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to playlist*/
INSERT INTO `playlist` (`id_user`, `name`, `status`) VALUES
(1, 'My Travel Picks', 'public'),
(2, 'Gadget Reviews', 'private');

/*Creating the playlist_video table*/
CREATE TABLE `playlist_video` (
    `id_playlist` int(11) NOT NULL,
    `id_video` int(11) NOT NULL,
    PRIMARY KEY (`id_playlist`, `id_video`),
    FOREIGN KEY (`id_playlist`) REFERENCES `playlist` (`id_playlist`),
    FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to playlist_video*/
INSERT INTO `playlist_video` (`id_playlist`, `id_video`) VALUES
(1, 1),
(2, 2);

/*Creating the comment table*/
CREATE TABLE `comment` (
    `id_comment` INT NOT NULL AUTO_INCREMENT,
    `id_video` INT NOT NULL,
    `id_user` INT NOT NULL,
    `text` VARCHAR(500) NOT NULL,
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_comment`),
    FOREIGN KEY (`id_video`) REFERENCES `video` (`id_video`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to comment*/
INSERT INTO `comment` (`id_video`, `id_user`, `text`) VALUES
(1, 2, 'Wow, Iceland looks amazing!'),
(2, 3, 'Great review, very helpful.'),
(3, 1, 'Can’t wait to try this recipe!');

/*Creating the comment_reaction table*/
CREATE TABLE `comment_reaction` (
    `id_comment` int(11) NOT NULL,
    `id_user` int(11) NOT NULL,
    `reaction` ENUM('like', 'dislike') NOT NULL DEFAULT 'like',
    `date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id_comment`, `id_user`),
    FOREIGN KEY (`id_comment`) REFERENCES `comment` (`id_comment`),
    FOREIGN KEY (`id_user`) REFERENCES `user` (`id_user`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

/*Adding Sample Records to comment_reaction*/
INSERT INTO `comment_reaction` (`id_comment`, `id_user`, `reaction`) VALUES
(1, 1, 'like'),
(2, 1, 'like'),
(3, 2, 'dislike');
