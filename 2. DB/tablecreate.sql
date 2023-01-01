USE UPASS;


CREATE TABLE `Transport Ticket` 
(
`Passport_id` varchar(10) NOT NULL,
`Transport_types` INT(1) NOT NULL,
`Start_time` TIME(1),
`End_time` TIME(1),
PRIMARY KEY (`Passport_id`)
);


CREATE TABLE `Medical card` 
(
`Passport_id` varchar(10) NOT NULL,
`id` varchar(10) NOT NULL,
`blood type` varchar(2) NOT NULL,
PRIMARY KEY (`Passport_id`),
UNIQUE (`id`)
);


CREATE TABLE `Passport` 
(
`id` varchar(10) NOT NULL,
`First_Name` varchar(15) NOT NULL,
`Last_Name` varchar(15) NOT NULL,
`Patronymic` varchar(18),
PRIMARY KEY (`id`)
);

CREATE TABLE `Disease`
(
`Medical_card_id` varchar(10) NOT NULL,
`Name` varchar(20) NOT NULL,
PRIMARY KEY (`Medical_card_id`)
);

ALTER TABLE `Transport Ticket` ADD CONSTRAINT `Transport Ticket_fr0` FOREIGN KEY (`Passport_id`) REFERENCES Passport(`id`);
ALTER TABLE `Medical card` ADD CONSTRAINT `Medical card_fk0` FOREIGN KEY (`Passport_id`) REFERENCES `Passport` (`id`);
ALTER TABLE `Disease` ADD CONSTRAINT `Disease_fk0` FOREIGN KEY (`Medical_card_id`) REFERENCES `Medical card` (`id`);
