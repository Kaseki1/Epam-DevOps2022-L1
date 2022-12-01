CREATE TABLE for_users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    val INT NOT NULL
);
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'user1';
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'user2';
REVOKE ALL ON *.* FROM 'user1'@'localhost';
REVOKE ALL ON *.* FROM 'user2'@'localhost';
GRANT SELECT ON for_users TO 'user1'@'localhost';
GRANT INSERT ON for_users TO 'user2'@'localhost';
