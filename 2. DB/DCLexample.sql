USE UPASS;

CREATE USER 'testuser'@'%' IDENTIFIED BY 'password';

GRANT SELECT ON 'mysql'.* to 'testuser'@'%';



