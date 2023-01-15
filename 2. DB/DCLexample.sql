USE UPASS;


CREATE USER 'testuser'@'localhost';
CREATE USER 'testinsert'@'localhost';

GRANT SELECT ON *.* to 'testuser'@'localhost';

GRANT SELECT, INSERT ON *.* to 'testinsert'@'localhost';



