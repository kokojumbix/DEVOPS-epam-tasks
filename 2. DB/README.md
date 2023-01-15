## 1 PART

## First of all, mysql needed to be installed.

In case of using "apt":
```sh
sudo apt-get install mysql-server
```

In case of using "yum" can be used mysql fork - mariadb:
```sh
sudo yum install mariadb-server
```

I'm using Centos with package manager "yum", so there are result of using install command.
![install](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/Screenshots/DB%20task/image.png)

Also for this was written little script, which install mariadb using yum. It has name "installdb.sh".
https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/2.%20DB/installdb.sh

## After install mysql, was created selected subject area and described the database scheme.

Selected subject area: Unified system from various spheres of life. (City-Transport ticket, medical card, passport)

![database_scheme](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/Screenshots/DB%20task/DB_designer_task_1_scheme.png)


## For every subject area needed different access level :

**1 level (Transport controller, Doctor during review):** 

Can read data only in their area. 
(example - Doctor can take information only about medical card)

**2 level** 

Can read and write data only in their area.

**3 level** 

Can read and write data in all areas.

**4 level** 

Can edit rules.

## Creating database on the server through console.

Command to create db:
```sql
CREATE DATABASE UPASS;
```
Commands to create tables in db:
```sql
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
```
Filling DB was made by using SQL file. [Here is file](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/2.%20DB/filldb.sql)

Example of using SELECT operator with [sql file](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/main/2.%20DB/selectdb.sql):
![image](https://user-images.githubusercontent.com/113692759/211839980-e58d0855-b4cd-4a1c-9ef7-09a013c5a7da.png)

DDL, DML, DCL queries in files:

[DCL](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/219c080e95476d76ac14f50a63031c445a436449/2.%20DB/DCLexample.sql)
[DML](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/219c080e95476d76ac14f50a63031c445a436449/2.%20DB/DMLexample.sql)
[DDL](https://github.com/kokojumbix/DEVOPS-epam-tasks/blob/219c080e95476d76ac14f50a63031c445a436449/2.%20DB/DDLexample.sql)

Creating users with different previleges (DCL sql file). Table that show users with their previleges:
![image](https://user-images.githubusercontent.com/113692759/212552972-c5a88890-a434-4cad-b65e-495d154ae028.png)


Verify that the privileges
allow or deny certain actions presented on next screenshots:

testuser (Allowed only command SELECT):
![image](https://user-images.githubusercontent.com/113692759/212553268-6b6bacbe-54f0-4854-b8cc-5702425c1e2d.png)

testinsert (Allowed SELECT and INSERT command):
![image](https://user-images.githubusercontent.com/113692759/212553348-85c52a23-78d6-4587-87a6-e307a8da3ed0.png)







